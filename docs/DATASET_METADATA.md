# Dataset metadata products

## Per run

`metadata.json` records:

- canonical scenario and Modelica model;
- optional named profile and run ID;
- start/stop times, intervals, solver and tolerance;
- parameter overrides;
- output mode and variable filter;
- PatientEvoPhysio source SHA-256;
- OpenModelica version and dependency versions;
- portable references to generated data and logs.

## Dataset release

`build_dataset_release.py` adds:

- `dataset_index.csv` — one row per curated run;
- `variable_dictionary.csv` — union of released variables, units and descriptions;
- `provenance.json` — release-level software/maintainer metadata;
- `quality/` — aggregate run validation;
- `SHA256SUMS.txt` — cryptographic integrity manifest;
- `README_DATASET.md`, license note and data-availability template.
