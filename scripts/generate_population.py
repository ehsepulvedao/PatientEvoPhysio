#!/usr/bin/env python3
"""Generate deterministic virtual-patient simulations from a parameter CSV.

The input format is: patient_id,scenario_id,parameter,value.
This script does not sample distributions; it only executes user-defined
parameter sets so that future cohorts remain scientifically traceable.
"""
from __future__ import annotations

import argparse
import csv
from collections import defaultdict
from pathlib import Path

from patientevophysio_runner import build_spec, run_simulation


def load_rows(path: Path):
    groups = defaultdict(dict)
    scenarios = {}
    with path.open("r", encoding="utf-8-sig", newline="") as f:
        reader = csv.DictReader(f)
        expected = {"patient_id", "scenario_id", "parameter", "value"}
        if set(reader.fieldnames or []) != expected:
            raise ValueError(f"Expected columns exactly {sorted(expected)}; got {reader.fieldnames}")
        for row in reader:
            pid = row["patient_id"].strip()
            sid = row["scenario_id"].strip()
            param = row["parameter"].strip()
            value = row["value"].strip()
            if not all((pid, sid, param, value)):
                raise ValueError(f"Blank field in row: {row}")
            if pid in scenarios and scenarios[pid] != sid:
                raise ValueError(f"Patient {pid!r} uses multiple scenarios")
            scenarios[pid] = sid
            if param in groups[pid]:
                raise ValueError(f"Duplicate parameter {param!r} for patient {pid!r}")
            groups[pid][param] = value
    return scenarios, groups


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("population_csv", type=Path)
    parser.add_argument("--profile", default="hemodynamic_smoke")
    parser.add_argument("--output", type=Path)
    mode = parser.add_mutually_exclusive_group()
    mode.add_argument("--raw", action="store_true", help="Retain all OpenModelica variables")
    mode.add_argument("--both", action="store_true", help="Retain raw and curated outputs")
    args = parser.parse_args()

    scenarios, groups = load_rows(args.population_csv)
    output_mode = "both" if args.both else "raw" if args.raw else "curated"
    for pid in sorted(groups):
        spec = build_spec(scenarios[pid], profile=args.profile, run_id=pid)
        kwargs = {"overrides": groups[pid], "output_mode": output_mode}
        if args.output:
            kwargs["output_root"] = args.output
        csv_path = run_simulation(spec, **kwargs)
        print(f"[OK] {pid}: {csv_path}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
