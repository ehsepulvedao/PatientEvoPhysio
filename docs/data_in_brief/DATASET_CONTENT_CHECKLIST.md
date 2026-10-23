# Dataset content checklist

A final public dataset should contain, at minimum:

- curated time-series CSV files;
- optional raw OpenModelica outputs if scientifically useful and storage permits;
- `dataset_index.csv`;
- `variable_dictionary.csv`;
- per-run `metadata.json`;
- per-run validation summaries/details;
- per-run scientific summaries and representative QC figures;
- dataset-level `quality_summary.csv/json` and `quality_report.md`;
- `provenance.json`;
- `SHA256SUMS.txt`;
- parameter-space/design files and random seed for any virtual cohort;
- dataset README, license and data-availability statement;
- exact PatientEvoPhysio release/tag used to generate the data.
