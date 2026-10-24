#!/usr/bin/env python3
"""Run an OpenModelica initialization diagnostic without changing the model.

This script enables OpenModelica's ``-d=initialization`` diagnostics and writes
portable logs/JSON under ``data/diagnostics/initialization``. It is diagnostic
only: it does not silently add ``fixed=true`` or otherwise alter physiology.
"""
from __future__ import annotations

import argparse
import json
import re
import shutil
import subprocess
from datetime import datetime, timezone
from pathlib import Path

from patientevophysio_runner import (
    ROOT, MODEL_FILE, DEFAULT_BUILD_ROOT, build_spec, find_omc,
    omc_quote_path, relative_public_path, safe_run_id,
)

DEFAULT_OUT = ROOT / "data" / "diagnostics" / "initialization"


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--scenario", default="neonate_healthy")
    parser.add_argument("--stop-time", type=float, default=0.5)
    parser.add_argument("--intervals", type=int, default=100)
    args = parser.parse_args()

    spec = build_spec(args.scenario, stop_time=args.stop_time, number_of_intervals=args.intervals)
    omc = find_omc()
    run_id = safe_run_id("initialization_" + args.scenario)
    out_dir = DEFAULT_OUT / args.scenario
    out_dir.mkdir(parents=True, exist_ok=True)
    work_dir = DEFAULT_BUILD_ROOT / run_id
    if work_dir.exists():
        shutil.rmtree(work_dir)
    work_dir.mkdir(parents=True, exist_ok=True)

    mos = work_dir / "initialization_diagnostic.mos"
    mos.write_text("\n".join([
        'loadModel(Modelica, {"3.2.3"});',
        'getErrorString();',
        'loadModel(Physiolibrary, {"2.3.1"});',
        'getErrorString();',
        f'loadFile("{omc_quote_path(MODEL_FILE)}", encoding="UTF-8");',
        'getErrorString();',
        'setCommandLineOptions("-d=initialization");',
        f'cd("{omc_quote_path(work_dir)}");',
        f'checkModel({spec.model});',
        'getErrorString();',
        (f'simulate({spec.model}, startTime=0, stopTime={args.stop_time}, '
         f'numberOfIntervals={args.intervals}, method="dassl", tolerance=1e-6, '
         'outputFormat="csv", fileNamePrefix="initialization_diagnostic", variableFilter="^time$");'),
        'getErrorString();',
    ]) + "\n", encoding="utf-8")

    cp = subprocess.run([omc, str(mos)], cwd=work_dir, capture_output=True, text=True)
    log_text = (cp.stdout or "") + "\n--- STDERR ---\n" + (cp.stderr or "")
    log_path = out_dir / "initialization.log"
    log_path.write_text(log_text, encoding="utf-8")
    shutil.copy2(mos, out_dir / "initialization_diagnostic.mos")

    lower = log_text.lower()
    unspecified = "initial conditions are not fully specified" in lower
    initialization_success = "initialization finished successfully" in lower

    assumed: list[str] = []
    in_block = False
    for line in log_text.splitlines():
        if "Assuming fixed start value for the following" in line:
            in_block = True
            continue
        if in_block:
            m = re.match(r"\s*([A-Za-z_]\w*(?:[.]\w+|\[[^]]+\])*)\s*:", line)
            if m:
                assumed.append(m.group(1))
                continue
            if line.strip() and not line.startswith((" ", "\t")):
                in_block = False

    summary = {
        "schema_version": 1,
        "generated_at_utc": datetime.now(timezone.utc).isoformat(),
        "scenario_id": args.scenario,
        "model": spec.model,
        "omc_return_code": cp.returncode,
        "initialization_finished_successfully": initialization_success,
        "unspecified_initial_conditions_warning": unspecified,
        "assumed_fixed_start_count": len(assumed),
        "assumed_fixed_start_variables": list(dict.fromkeys(assumed)),
        "log": relative_public_path(log_path),
        "diagnostic_script": relative_public_path(out_dir / "initialization_diagnostic.mos"),
        "interpretation": (
            "Diagnostic only. A warning does not imply a failed simulation. Review the listed variables before "
            "changing any start/fixed attributes; no model values are modified by this script."
        ),
    }
    (out_dir / "initialization_summary.json").write_text(json.dumps(summary, indent=2), encoding="utf-8")

    if cp.returncode == 0:
        shutil.rmtree(work_dir, ignore_errors=True)
        print(f"[OK] Initialization diagnostic written to {out_dir}")
        print(f"     unspecified warning: {unspecified}")
        print(f"     assumed fixed starts: {len(assumed)}")
        return 0

    print(f"[FAIL] Initialization diagnostic failed; build workspace retained: {work_dir}")
    return 1


if __name__ == "__main__":
    raise SystemExit(main())
