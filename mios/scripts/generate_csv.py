#!/usr/bin/env python3
"""Generate reproducible PatientEvoPhysio CSV results with OpenModelica."""
from __future__ import annotations

import argparse
from pathlib import Path

from patientevophysio_runner import build_spec, load_config, profile_scenarios, run_simulation


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--list", action="store_true", help="List scenario IDs and profiles")
    parser.add_argument("--scenario", action="append", dest="scenarios", help="Scenario ID; may be repeated")
    parser.add_argument("--profile", help="Named simulation profile from config/scenarios.json")
    parser.add_argument("--start-time", type=float)
    parser.add_argument("--stop-time", type=float)
    parser.add_argument("--intervals", type=int)
    parser.add_argument("--method")
    parser.add_argument("--tolerance", type=float)
    parser.add_argument("--output", type=Path, help="Output root directory")
    mode = parser.add_mutually_exclusive_group()
    mode.add_argument("--raw", action="store_true", help="Retain every OpenModelica result variable")
    mode.add_argument("--both", action="store_true", help="Retain raw output and create a curated CSV")
    args = parser.parse_args()

    cfg = load_config()
    if args.list:
        print("Scenarios:")
        for key, val in cfg["scenarios"].items():
            print(f"  {key:30s} {val['model']}")
        print("\nProfiles:")
        for key, val in cfg["profiles"].items():
            print(f"  {key:30s} {val['stop_time']} s, {val['number_of_intervals']} intervals")
        print("\nOutput modes:\n  curated (default)\n  --raw\n  --both")
        return 0

    scenarios = list(args.scenarios or [])
    if args.profile:
        for sid in profile_scenarios(args.profile):
            if sid not in scenarios:
                scenarios.append(sid)
    if not scenarios:
        parser.error("Provide --scenario, --profile, or --list")

    output_mode = "both" if args.both else "raw" if args.raw else "curated"
    for sid in scenarios:
        spec = build_spec(
            sid,
            profile=args.profile,
            start_time=args.start_time,
            stop_time=args.stop_time,
            number_of_intervals=args.intervals,
            method=args.method,
            tolerance=args.tolerance,
        )
        kwargs = {"output_mode": output_mode}
        if args.output:
            kwargs["output_root"] = args.output
        csv_path = run_simulation(spec, **kwargs)
        print(f"[OK] {sid} [{output_mode}]: {csv_path}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
