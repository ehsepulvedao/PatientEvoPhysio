#!/usr/bin/env python3
"""Tests for curated output filtering and portable validation metadata."""
from __future__ import annotations

import csv
import json
import subprocess
import sys
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "scripts"))

from patientevophysio_runner import (  # noqa: E402
    RunSpec, curated_variable_filter, curate_csv_file, portable_run_mos
)

regex = curated_variable_filter()
assert "pressure_mmHg" in regex
assert "flow_L_per_min" in regex
assert "oxygenSaturation" in regex
assert "[.]" in regex
assert "\\" not in regex, "OMC filter should avoid Modelica string backslash escapes"

record = portable_run_mos(
    RunSpec("neonate_healthy", "PatientEvoPhysio.Scenarios.Neonate.Healthy"),
    "PatientEvoPhysio.Scenarios.Neonate.Healthy", "neonate_healthy", regex
)
assert 'loadFile("PatientEvoPhysio.mo"' in record
assert "I:/" not in record and "C:/Users/" not in record and "\\" not in record

with tempfile.TemporaryDirectory() as td:
    td = Path(td)
    raw = td / "raw.csv"
    curated = td / "curated.csv"
    with raw.open("w", newline="", encoding="utf-8") as f:
        w = csv.writer(f)
        w.writerow([
            "time", "leftVentricle.pressure_mmHg", "leftVentricle.volume",
            "aorticValve.open", "leftVentricle.solute", "der(leftVentricle.q_in.conc)"
        ])
        w.writerow([0, 8, 4.8e-6, 0, 1.0, 0.0])
        w.writerow([0.001, 10, 4.7e-6, 1, 1.1, 0.1])
    selected, total = curate_csv_file(raw, curated)
    assert total == 6
    assert selected == 4
    header = next(csv.reader(curated.open(encoding="utf-8")))
    assert header == ["time", "leftVentricle.pressure_mmHg", "leftVentricle.volume", "aorticValve.open"]

    cp = subprocess.run(
        [sys.executable, str(ROOT / "scripts" / "validate_results.py"), str(curated)],
        capture_output=True, text=True,
    )
    assert cp.returncode == 0, cp.stdout + cp.stderr
    summary = json.loads(curated.with_suffix(".validation.json").read_text(encoding="utf-8"))
    details = json.loads(curated.with_suffix(".validation.details.json").read_text(encoding="utf-8"))
    assert summary["status"] == "PASS"
    assert summary["rows"] == 2
    assert summary["variables"] == 4
    assert not Path(summary["csv"]).is_absolute()
    assert "statistics" not in summary
    assert "statistics" in details

print("[PASS] Curated-output/validation pipeline tests completed")
