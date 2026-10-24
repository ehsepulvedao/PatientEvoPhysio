# RC7 validation checklist

## Environment

- [ ] Modelica 3.2.3 loaded.
- [ ] Physiolibrary 2.3.1 loaded.
- [ ] PatientEvoPhysio v2.0.0 loads without syntax errors.

## Standard automated validation

- [ ] `RUN_STANDARD_VALIDATION.bat` completes.
- [ ] Nine hemodynamic `*_res.csv` files are produced.
- [ ] All routine validation summaries are PASS or scientifically reviewed.
- [ ] Generated CSVs contain the curated variable subset rather than every OpenModelica internal variable.
- [ ] Repository root remains free of compiler artifacts.

## Initialization

- [ ] Review `data/diagnostics/initialization/neonate_healthy/initialization_summary.json`.
- [ ] If OpenModelica reports unspecified initial conditions, identify the assumed/fixed variables before changing any start/fixed attributes.
- [ ] Do not alter physiological initialization solely to remove a warning without numerical/scientific justification.

## Extended validation

- [ ] `RUN_EXTENDED_VALIDATION.bat` completes.
- [ ] Healthy-neonate 600 s oxygen dynamics remain bounded/plausible.
- [ ] Fetal-to-neonatal 720 s transition completes.
- [ ] Optional 24 h transition tested before stable release/public dataset generation.

## Reproducibility

- [ ] `metadata.json` contains no local absolute repository path.
- [ ] SHA-256/model/dependency/OpenModelica versions are recorded.
- [ ] `run.mos` reproduces each run.

- [ ] Confirm `hemodynamic_smoke/neonate_healthy` and `neonate_oxygen_10min/neonate_healthy` exist in separate profile-specific output directories.
