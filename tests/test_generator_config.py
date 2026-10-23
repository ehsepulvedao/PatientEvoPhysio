#!/usr/bin/env python3
"""Lightweight tests for data-generation configuration and wrapper syntax."""
from __future__ import annotations

import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "scripts"))

from patientevophysio_runner import build_spec, nested_modification, output_relative_path  # noqa: E402

cfg = json.loads((ROOT / "config" / "scenarios.json").read_text(encoding="utf-8"))
assert cfg["profiles"]["hemodynamic_smoke"]["stop_time"] == 5.0
assert cfg["profiles"]["hemodynamic_smoke"]["number_of_intervals"] == 5000
assert cfg["profiles"]["neonate_oxygen_10min"]["stop_time"] == 600.0
assert cfg["scenarios"]["neonate_healthy"]["model"].endswith("Neonate.Healthy")
assert cfg["scenarios"]["fetal_to_neonatal_transition"]["model"].endswith("FetalToNeonatal_Transition")


# Named profiles using the same physiological scenario must never overwrite each other.
smoke = build_spec("neonate_healthy", profile="hemodynamic_smoke")
oxygen = build_spec("neonate_healthy", profile="neonate_oxygen_10min")
assert output_relative_path(smoke) == Path("profiles/hemodynamic_smoke/neonate_healthy")
assert output_relative_path(oxygen) == Path("profiles/neonate_oxygen_10min/neonate_healthy")
assert output_relative_path(smoke) != output_relative_path(oxygen)

mod = nested_modification({
    "leftVentricularElastanceSignal.HR": "130",
    "leftVentricle.volume_start": "4.8e-6",
})
assert "leftVentricularElastanceSignal(HR=130)" in mod
assert "leftVentricle(volume_start=4.8e-6)" in mod

try:
    nested_modification({"leftVentricle.volume_start": "1); system(\"bad\")"})
except ValueError:
    pass
else:
    raise AssertionError("Unsafe override literal was accepted")

print("[PASS] Generator/config tests completed")

patient_profile = build_spec("neonate_healthy", profile="hemodynamic_smoke", run_id="patient_000001")
patient_oxygen = build_spec("neonate_healthy", profile="neonate_oxygen_10min", run_id="patient_000001")
assert output_relative_path(patient_profile) == Path("runs/patient_000001/profiles/hemodynamic_smoke")
assert output_relative_path(patient_profile) != output_relative_path(patient_oxygen)
