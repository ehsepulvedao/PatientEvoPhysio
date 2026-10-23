#!/usr/bin/env python3
"""Broad engineering sanity checks for a PatientEvoPhysio CSV result.

The default ``*.validation.json`` file is intentionally compact. Full min/max
statistics are written separately to ``*.validation.details.json``.
Guardrails are engineering checks, not clinical reference intervals.
"""
from __future__ import annotations

import argparse
import csv
import json
import math
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def public_path(path: Path) -> str:
    try:
        return path.resolve().relative_to(ROOT.resolve()).as_posix()
    except (ValueError, OSError):
        return path.name


def parse_float(value: str):
    try:
        return float(value)
    except (TypeError, ValueError):
        return None


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("csv_file", type=Path)
    parser.add_argument("--summary", type=Path)
    parser.add_argument("--details", type=Path)
    parser.add_argument("--no-details", action="store_true", help="Do not write the full statistics file")
    args = parser.parse_args()

    issues: list[str] = []
    stats: dict[str, dict] = {}
    nonfinite_count = 0
    row_count = 0
    previous_time = None
    time_monotonic = True
    guardrails = {
        "non_finite": "PASS",
        "time_monotonic": "PASS",
        "volume": "PASS",
        "pressure": "PASS",
        "oxygen_saturation": "PASS",
        "valve_states": "PASS",
    }

    with args.csv_file.open("r", encoding="utf-8-sig", newline="") as f:
        reader = csv.DictReader(f)
        fields = reader.fieldnames or []
        if not fields:
            raise SystemExit("CSV has no header")
        for name in fields:
            stats[name] = {"min": None, "max": None, "n": 0, "non_finite": 0}

        time_name = next((n for n in fields if n.lower() == "time"), None)
        for row_index, row in enumerate(reader, start=2):
            row_count += 1
            for name in fields:
                x = parse_float(row.get(name, ""))
                if x is None:
                    continue
                st = stats[name]
                st["n"] += 1
                if not math.isfinite(x):
                    st["non_finite"] += 1
                    nonfinite_count += 1
                    guardrails["non_finite"] = "REVIEW"
                    issues.append(f"{name}: non-finite value at CSV row {row_index}")
                    continue
                st["min"] = x if st["min"] is None else min(st["min"], x)
                st["max"] = x if st["max"] is None else max(st["max"], x)

                if name == time_name:
                    if previous_time is not None and x < previous_time:
                        time_monotonic = False
                    previous_time = x

                lower = name.lower()
                if lower.endswith(".volume") and x < -1e-12:
                    guardrails["volume"] = "REVIEW"
                if "pressure_mmhg" in lower and (x < -100 or x > 500):
                    guardrails["pressure"] = "REVIEW"
                if "oxygensaturation" in lower and (x < -1 or x > 110):
                    guardrails["oxygen_saturation"] = "REVIEW"
                if lower.endswith(".open") and abs(x) > 1e-9 and abs(x - 1) > 1e-9:
                    guardrails["valve_states"] = "REVIEW"

    if not time_monotonic:
        guardrails["time_monotonic"] = "REVIEW"
        issues.append("time: not monotonically nondecreasing")

    # Convert category-level failures to concise issue messages. Individual
    # non-finite entries remain explicit because their row is useful to debug.
    if guardrails["volume"] == "REVIEW":
        issues.append("one or more volumes are negative beyond numerical tolerance")
    if guardrails["pressure"] == "REVIEW":
        issues.append("one or more pressure_mmHg variables cross the broad [-100, 500] mmHg engineering guardrail")
    if guardrails["oxygen_saturation"] == "REVIEW":
        issues.append("one or more oxygenSaturation variables cross the broad [-1, 110] % engineering guardrail")
    if guardrails["valve_states"] == "REVIEW":
        issues.append("one or more valve *.open variables contain values other than 0/1")

    # De-duplicate while preserving order.
    issues = list(dict.fromkeys(issues))
    status = "PASS" if not issues else "REVIEW"
    summary_path = args.summary or args.csv_file.with_suffix(".validation.json")
    details_path = args.details or args.csv_file.with_suffix(".validation.details.json")

    summary = {
        "schema_version": 2,
        "csv": public_path(args.csv_file),
        "status": status,
        "issues_count": len(issues),
        "issues": issues,
        "rows": row_count,
        "variables": len(stats),
        "non_finite_values": nonfinite_count,
        "guardrails": guardrails,
        "details_file": None if args.no_details else public_path(details_path),
        "note": "Guardrails are engineering sanity checks, not clinical validation limits.",
    }
    summary_path.write_text(json.dumps(summary, indent=2), encoding="utf-8")

    if not args.no_details:
        details = {
            "schema_version": 2,
            "csv": public_path(args.csv_file),
            "statistics": stats,
            "note": "Full per-variable statistics; use the compact validation JSON for routine review.",
        }
        details_path.write_text(json.dumps(details, indent=2), encoding="utf-8")

    print(f"{status}: {len(issues)} issue(s), {row_count} rows, {len(stats)} variables. Summary: {summary_path}")
    for issue in issues:
        print(" -", issue)
    return 0 if not issues else 2


if __name__ == "__main__":
    raise SystemExit(main())
