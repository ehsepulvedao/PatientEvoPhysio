#!/usr/bin/env python3
"""Extract the stable PatientEvoPhysio analysis subset from a full CSV."""
from __future__ import annotations

import argparse
from pathlib import Path

from patientevophysio_runner import curate_csv_file


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("input_csv", type=Path)
    parser.add_argument("output_csv", type=Path)
    args = parser.parse_args()
    selected, total = curate_csv_file(args.input_csv, args.output_csv)
    print(f"Selected {selected} of {total} columns -> {args.output_csv}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
