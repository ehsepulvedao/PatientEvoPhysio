#!/usr/bin/env python3
"""OpenModelica runner for PatientEvoPhysio.

The runner uses only the Python standard library. It creates a reproducible
``.mos`` script, invokes OpenModelica, and stores simulation results with
portable JSON metadata.

Default behaviour is intentionally dataset-friendly: only the curated
scientific variable set from ``config/core_variables.json`` is written to the
result CSV. Full OpenModelica output is available explicitly with ``--raw``.
"""
from __future__ import annotations

import csv
import fnmatch
import hashlib
import json
import os
import re
import shutil
import subprocess
from dataclasses import dataclass, asdict
from datetime import datetime, timezone
from pathlib import Path
from typing import Dict, Iterable, Optional

ROOT = Path(__file__).resolve().parents[1]
MODEL_FILE = ROOT / "PatientEvoPhysio.mo"
CONFIG_FILE = ROOT / "config" / "scenarios.json"
CORE_VARIABLES_FILE = ROOT / "config" / "core_variables.json"
DEFAULT_OUTPUT_ROOT = ROOT / "data" / "generated"
DEFAULT_BUILD_ROOT = ROOT / "build" / "omc"


@dataclass(frozen=True)
class RunSpec:
    scenario_id: str
    model: str
    start_time: float = 0.0
    stop_time: float = 5.0
    number_of_intervals: int = 5000
    method: str = "dassl"
    tolerance: float = 1e-6
    profile: Optional[str] = None
    run_id: Optional[str] = None


def sha256(path: Path) -> str:
    h = hashlib.sha256()
    with path.open("rb") as f:
        for chunk in iter(lambda: f.read(1024 * 1024), b""):
            h.update(chunk)
    return h.hexdigest()


def load_config() -> dict:
    with CONFIG_FILE.open("r", encoding="utf-8") as f:
        return json.load(f)


def load_core_variable_config() -> dict:
    with CORE_VARIABLES_FILE.open("r", encoding="utf-8") as f:
        return json.load(f)


def relative_public_path(path: Path) -> str:
    """Return a portable repository-relative path when possible."""
    try:
        return path.resolve().relative_to(ROOT.resolve()).as_posix()
    except (ValueError, OSError):
        return path.name


def find_omc() -> str:
    """Return an OpenModelica compiler executable without requiring PATH edits."""
    explicit = os.environ.get("OMC_EXE")
    if explicit and Path(explicit).is_file():
        return str(Path(explicit))

    for name in ("omc.exe", "omc"):
        found = shutil.which(name)
        if found:
            return found

    candidates = []
    env_home = os.environ.get("OPENMODELICAHOME")
    if env_home:
        candidates.extend([Path(env_home) / "bin" / "omc.exe", Path(env_home) / "bin" / "omc"])

    if os.name == "nt":
        roots = [
            os.environ.get("ProgramFiles"),
            os.environ.get("ProgramFiles(x86)"),
            str(Path(os.environ.get("LOCALAPPDATA", "")) / "Programs") if os.environ.get("LOCALAPPDATA") else None,
            "C:/",
        ]
        for raw_root in roots:
            if not raw_root:
                continue
            root = Path(raw_root)
            try:
                for home in sorted(root.glob("OpenModelica*"), reverse=True):
                    candidates.append(home / "bin" / "omc.exe")
            except OSError:
                pass

    for candidate in candidates:
        if candidate.is_file():
            return str(candidate)

    raise FileNotFoundError(
        "OpenModelica compiler 'omc' could not be located automatically. "
        "Install OpenModelica using its normal installer. Standard Windows "
        "installations do not require PATH changes for PatientEvoPhysio."
    )


def omc_quote_path(path: Path) -> str:
    return str(path.resolve()).replace("\\", "/").replace('"', '\\"')


def safe_run_id(text: str) -> str:
    return re.sub(r"[^A-Za-z0-9_.-]+", "_", text).strip("_") or "run"



def output_relative_path(spec: RunSpec) -> Path:
    """Return the collision-safe relative output path for a simulation run."""
    if spec.run_id and spec.profile:
        return Path("runs") / safe_run_id(spec.run_id) / "profiles" / safe_run_id(spec.profile)
    if spec.run_id:
        return Path("runs") / safe_run_id(spec.run_id)
    if spec.profile:
        return Path("profiles") / safe_run_id(spec.profile) / safe_run_id(spec.scenario_id)
    return Path("runs") / safe_run_id(spec.scenario_id)

def _value_literal(value: str) -> str:
    value = value.strip()
    if value.lower() in {"true", "false"}:
        return value.lower()
    try:
        float(value)
    except ValueError as exc:
        raise ValueError(f"Only numeric or Boolean override values are allowed: {value!r}") from exc
    if not re.fullmatch(r"[+-]?(?:\d+(?:\.\d*)?|\.\d+)(?:[eE][+-]?\d+)?", value):
        raise ValueError(f"Unsafe numeric literal: {value!r}")
    return value


def nested_modification(overrides: Dict[str, str]) -> str:
    """Convert dotted parameter paths to nested Modelica modifications."""
    tree: dict = {}
    identifier = re.compile(r"^[A-Za-z_]\w*$")
    for dotted, raw_value in sorted(overrides.items()):
        parts = dotted.split(".")
        if not parts or any(not identifier.fullmatch(p) for p in parts):
            raise ValueError(f"Invalid Modelica parameter path: {dotted!r}")
        cursor = tree
        for part in parts[:-1]:
            cursor = cursor.setdefault(part, {})
            if not isinstance(cursor, dict):
                raise ValueError(f"Conflicting parameter path: {dotted!r}")
        cursor[parts[-1]] = _value_literal(str(raw_value))

    def emit(node: dict) -> str:
        items = []
        for key, val in sorted(node.items()):
            if isinstance(val, dict):
                items.append(f"{key}({emit(val)})")
            else:
                items.append(f"{key}={val}")
        return ", ".join(items)

    return emit(tree)


def _wrapper_source(wrapper_name: str, base_model: str, overrides: Dict[str, str]) -> str:
    mods = nested_modification(overrides)
    modifier = f"({mods})" if mods else ""
    return (
        "within ;\n"
        f"model {wrapper_name}\n"
        f"  extends {base_model}{modifier};\n"
        f"end {wrapper_name};\n"
    )


def _omc_version(omc: str) -> str:
    try:
        cp = subprocess.run([omc, "--version"], capture_output=True, text=True, timeout=30)
        return (cp.stdout or cp.stderr).strip()
    except Exception as exc:
        return f"unavailable: {exc}"


def _glob_to_omc_regex(pattern: str) -> str:
    """Convert the small glob subset used by core_variables.json to OMC regex.

    We avoid backslash escapes inside Modelica strings by representing literal
    dots as ``[.]``. The configuration intentionally uses only ``*`` as a glob
    metacharacter.
    """
    parts = []
    for ch in pattern:
        if ch == "*":
            parts.append(".*")
        elif ch == ".":
            parts.append("[.]")
        elif ch in "^$|()[]{}+?":
            parts.append("[" + ch + "]")
        else:
            parts.append(ch)
    return "".join(parts)


def curated_variable_filter() -> str:
    patterns = load_core_variable_config()["patterns"]
    alternatives = [_glob_to_omc_regex(p) for p in patterns]
    return "^(" + "|".join(alternatives) + ")$"


def curate_csv_file(input_csv: Path, output_csv: Path) -> tuple[int, int]:
    """Create the configured analysis subset from a full OpenModelica CSV."""
    cfg = load_core_variable_config()
    patterns = cfg["patterns"]
    with input_csv.open("r", encoding="utf-8-sig", newline="") as src:
        reader = csv.DictReader(src)
        fields = reader.fieldnames or []
        selected = [name for name in fields if any(fnmatch.fnmatchcase(name, p) for p in patterns)]
        if "time" in fields and "time" not in selected:
            selected.insert(0, "time")
        if not selected:
            raise RuntimeError("No columns matched config/core_variables.json")
        output_csv.parent.mkdir(parents=True, exist_ok=True)
        with output_csv.open("w", encoding="utf-8", newline="") as dst:
            writer = csv.DictWriter(dst, fieldnames=selected)
            writer.writeheader()
            for row in reader:
                writer.writerow({k: row.get(k, "") for k in selected})
    return len(selected), len(fields)


def portable_run_mos(spec: RunSpec, target_model: str, prefix: str,
                     variable_filter: str, wrapper_relative: Optional[str] = None) -> str:
    """Return a repository-portable Modelica command record with no local paths.

    This file is intended to document/replay the exact model, solver and output
    selection from the repository root. The Python runner remains the preferred
    clean-build entry point because it isolates compiler artifacts automatically.
    """
    lines = [
        '// Portable PatientEvoPhysio run record. Execute from the repository root.',
        '// Preferred clean reproduction: python scripts/generate_csv.py ...',
        'loadModel(Modelica, {"3.2.3"});',
        'getErrorString();',
        'loadModel(Physiolibrary, {"2.3.1"});',
        'getErrorString();',
        'loadFile("PatientEvoPhysio.mo", encoding="UTF-8");',
        'getErrorString();',
    ]
    if wrapper_relative:
        lines.extend([f'loadFile("{wrapper_relative}", encoding="UTF-8");', 'getErrorString();'])
    lines.extend([
        f'checkModel({target_model});',
        'getErrorString();',
        (
            f'simulate({target_model}, startTime={spec.start_time}, stopTime={spec.stop_time}, '
            f'numberOfIntervals={spec.number_of_intervals}, method="{spec.method}", '
            f'tolerance={spec.tolerance}, outputFormat="csv", fileNamePrefix="{prefix}", '
            f'variableFilter="{variable_filter}");'
        ),
        'getErrorString();',
    ])
    return "\n".join(lines) + "\n"


def build_spec(scenario_id: str, *, profile: Optional[str] = None,
               start_time: Optional[float] = None, stop_time: Optional[float] = None,
               number_of_intervals: Optional[int] = None,
               method: Optional[str] = None, tolerance: Optional[float] = None,
               run_id: Optional[str] = None) -> RunSpec:
    cfg = load_config()
    if scenario_id not in cfg["scenarios"]:
        raise KeyError(f"Unknown scenario_id {scenario_id!r}")
    base = {
        "start_time": 0.0,
        "stop_time": 5.0,
        "number_of_intervals": 5000,
        "method": "dassl",
        "tolerance": 1e-6,
    }
    if profile:
        if profile not in cfg["profiles"]:
            raise KeyError(f"Unknown profile {profile!r}")
        base.update({k: v for k, v in cfg["profiles"][profile].items() if k != "scenarios"})
    explicit = {
        "start_time": start_time,
        "stop_time": stop_time,
        "number_of_intervals": number_of_intervals,
        "method": method,
        "tolerance": tolerance,
    }
    base.update({k: v for k, v in explicit.items() if v is not None})
    return RunSpec(
        scenario_id=scenario_id,
        model=cfg["scenarios"][scenario_id]["model"],
        profile=profile,
        run_id=run_id,
        **base,
    )


def run_simulation(spec: RunSpec, *, output_root: Path = DEFAULT_OUTPUT_ROOT,
                   overrides: Optional[Dict[str, str]] = None,
                   output_mode: str = "curated") -> Path:
    """Run one scenario and return the primary CSV path.

    ``output_mode`` may be:

    - ``curated`` (default): OpenModelica writes only the configured scientific
      variable subset. This is the recommended mode for datasets and long runs.
    - ``raw``: all OpenModelica result variables are retained.
    - ``both``: all variables are generated and retained, and a second curated
      CSV is derived from the raw result.

    Compiler artifacts live under ``build/omc`` and are deleted after success.
    """
    if output_mode not in {"curated", "raw", "both"}:
        raise ValueError("output_mode must be 'curated', 'raw', or 'both'")

    omc = find_omc()
    # Every named profile gets its own namespace so simulations with the same
    # physiological scenario but different horizons/settings can coexist.
    # Explicit run IDs (e.g. virtual patients) are stored under runs/. If a
    # named profile is also present it is namespaced below that patient/run ID.
    run_path = output_relative_path(spec)

    output_dir = Path(output_root) / run_path
    output_dir.mkdir(parents=True, exist_ok=True)

    work_dir = DEFAULT_BUILD_ROOT / run_path
    if work_dir.exists():
        shutil.rmtree(work_dir)
    work_dir.mkdir(parents=True, exist_ok=True)

    target_model = spec.model
    wrapper_file = None
    if overrides:
        wrapper_name = "PEP_" + re.sub(r"\W+", "_", str(run_path))
        if not re.match(r"^[A-Za-z_]", wrapper_name):
            wrapper_name = "PEP_run_" + wrapper_name
        wrapper_file = work_dir / f"{wrapper_name}.mo"
        wrapper_file.write_text(_wrapper_source(wrapper_name, spec.model, overrides), encoding="utf-8")
        target_model = wrapper_name

    prefix = safe_run_id(spec.scenario_id if not spec.run_id else spec.run_id)
    variable_filter = ".*" if output_mode in {"raw", "both"} else curated_variable_filter()

    mos = work_dir / "run.mos"
    lines = [
        'loadModel(Modelica, {"3.2.3"});',
        'getErrorString();',
        'loadModel(Physiolibrary, {"2.3.1"});',
        'getErrorString();',
        f'loadFile("{omc_quote_path(MODEL_FILE)}", encoding="UTF-8");',
        'getErrorString();',
    ]
    if wrapper_file:
        lines.extend([
            f'loadFile("{omc_quote_path(wrapper_file)}", encoding="UTF-8");',
            'getErrorString();',
        ])
    lines.extend([
        f'cd("{omc_quote_path(work_dir)}");',
        f'checkModel({target_model});',
        'getErrorString();',
        (
            f'simulate({target_model}, startTime={spec.start_time}, stopTime={spec.stop_time}, '
            f'numberOfIntervals={spec.number_of_intervals}, method="{spec.method}", '
            f'tolerance={spec.tolerance}, outputFormat="csv", fileNamePrefix="{prefix}", '
            f'variableFilter="{variable_filter}");'
        ),
        'getErrorString();',
    ])
    mos.write_text("\n".join(lines) + "\n", encoding="utf-8")

    cp = subprocess.run([omc, str(mos)], cwd=work_dir, capture_output=True, text=True)
    log_text = (cp.stdout or "") + "\n--- STDERR ---\n" + (cp.stderr or "")
    log = output_dir / "omc.log"
    log.write_text(log_text, encoding="utf-8")

    candidates = sorted(work_dir.glob(f"{prefix}*_res.csv")) + sorted(work_dir.glob(f"{prefix}*.csv"))
    work_csv = next((candidate for candidate in candidates if candidate.name != "metadata.csv"), None)

    if wrapper_file and wrapper_file.exists():
        shutil.copy2(wrapper_file, output_dir / wrapper_file.name)
    wrapper_rel = None
    if wrapper_file:
        wrapper_rel = relative_public_path(output_dir / wrapper_file.name)
    (output_dir / "run.mos").write_text(
        portable_run_mos(spec, target_model, prefix, variable_filter, wrapper_rel),
        encoding="utf-8",
    )

    primary_csv: Optional[Path] = None
    raw_csv: Optional[Path] = None
    curated_csv: Optional[Path] = None
    curated_columns: Optional[int] = None
    raw_columns: Optional[int] = None

    if work_csv is not None and work_csv.exists():
        if output_mode == "curated":
            curated_csv = output_dir / f"{prefix}_res.csv"
            shutil.copy2(work_csv, curated_csv)
            primary_csv = curated_csv
        elif output_mode == "raw":
            raw_csv = output_dir / f"{prefix}_raw.csv"
            shutil.copy2(work_csv, raw_csv)
            primary_csv = raw_csv
        else:
            raw_csv = output_dir / f"{prefix}_raw.csv"
            shutil.copy2(work_csv, raw_csv)
            curated_csv = output_dir / f"{prefix}_res.csv"
            curated_columns, raw_columns = curate_csv_file(raw_csv, curated_csv)
            primary_csv = curated_csv

    metadata = {
        "schema_version": 2,
        "generated_at_utc": datetime.now(timezone.utc).isoformat(),
        "run": asdict(spec),
        "resolved_model": target_model,
        "overrides": overrides or {},
        "output_mode": output_mode,
        "variable_filter": variable_filter,
        "model_file": MODEL_FILE.name,
        "model_sha256": sha256(MODEL_FILE),
        "openmodelica": _omc_version(omc),
        "dependencies": {"Modelica": "3.2.3", "Physiolibrary": "2.3.1"},
        "omc_return_code": cp.returncode,
        "files": {
            "primary_csv": relative_public_path(primary_csv) if primary_csv else None,
            "curated_csv": relative_public_path(curated_csv) if curated_csv else None,
            "raw_csv": relative_public_path(raw_csv) if raw_csv else None,
            "log": relative_public_path(log),
            "run_script": relative_public_path(output_dir / "run.mos"),
        },
        "curation": {
            "config": relative_public_path(CORE_VARIABLES_FILE),
            "selected_columns": curated_columns,
            "raw_columns": raw_columns,
        },
        "build_workspace": relative_public_path(work_dir),
        "build_artifacts_retained": cp.returncode != 0 or primary_csv is None,
    }
    (output_dir / "metadata.json").write_text(json.dumps(metadata, indent=2), encoding="utf-8")

    if cp.returncode != 0 or primary_csv is None or not primary_csv.exists():
        raise RuntimeError(
            f"Simulation failed or no CSV was produced for {spec.scenario_id}. "
            f"Inspect {log}, {output_dir / 'metadata.json'}, and retained build workspace {work_dir}."
        )

    shutil.rmtree(work_dir, ignore_errors=True)
    return primary_csv


def profile_scenarios(profile: str) -> Iterable[str]:
    cfg = load_config()
    try:
        return list(cfg["profiles"][profile]["scenarios"])
    except KeyError as exc:
        raise KeyError(f"Unknown profile {profile!r}") from exc
