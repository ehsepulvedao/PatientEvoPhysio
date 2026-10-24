# v2.1.0 — mass-data campaign layer

- Added resumable, parallel and chunkable virtual-cohort campaigns.
- Added patient-level train/validation/test splits and campaign manifests.
- Added source-gated scenario-specific parameter-space files.
- Added mass-mode dataset packaging and patient/campaign metadata.
- Added a storage-optimized 200 Hz diagnostic cohort profile.
- Corrected the virtual-population HR example to the Modelica SI frequency value.
- Added mass-campaign documentation and Windows launchers.
- Normalized the cardiovascular-system visual extent; no physiological equation was changed.

# Changelog

## 2.0.0 — 2026-10-23

Stable release promoted from the audited RC6/RC7 line.

- finalized the v2.0.0 version metadata;
- activated the redesigned external visual resources under `Resources/Images/icon/`;
- retained the validated English-identifier Modelica implementation;
- retained automated validation, dataset-generation, QA and publication packaging workflows;
- excluded generated numerical datasets from Git;
- refreshed the README and GitHub release documentation.

## 2.0.0-rc.7 — 2026-10-23

- Added publication experiment plans for data-article, hybrid-discovery, diagnosis and oxygen workflows.
- Added scientific run summaries, SVG QC figures and pressure-volume trajectories.
- Added interpretable hybrid cardiac-mode derivation.
- Added deterministic ML/time-series indexes and summary-feature table generation.
- Added Latin-hypercube virtual-cohort design tooling that requires user-supplied physiological bounds.
- Added dataset-level QA aggregation, provenance, variable dictionary, checksums and upload-ready dataset release builder.
- Added Data in Brief-style manuscript/checklist material with an explicit simulation-scope caution.
- Added one-click publication and dataset packaging launchers.
- No physiological equations or model numerical literals intentionally changed.

# Changelog
- Prevent profile output collisions by namespacing generated data under `profiles/<profile>/<scenario>/`.

## 2.0.0-rc.7 — 2026-10-23

- Made curated scientific CSV output the default; added explicit `--raw` and `--both` modes.
- Removed local absolute repository paths from public metadata/validation JSON.
- Split validation into compact summary and full statistics detail files.
- Added reproducible OpenModelica initialization diagnostics (`-d=initialization`).
- Updated standard/extended Windows validation to use the curated pipeline.
- Preserved isolated/clean OpenModelica build workspaces.

## 2.0.0-rc.4 — 2026-10-23

- Isolated OpenModelica compiler artifacts from the repository root and added `CLEAN_BUILD.bat`.
- Windows scripts now auto-detect OpenModelica and Python without requiring manual PATH edits or repository-specific paths.
- Fixed unit-string syntax rejected by OpenModelica (`Pa.s/m3`, gas-constant metadata, percentage annotations).
- Removed non-SI free-text unit strings from fetal oxygen variables while preserving their numerical values and equations.
- Bootstrap now explicitly installs Complex 3.2.3 and ModelicaServices 3.2.3 to avoid accidental mixing with 4.x dependencies.
- No physiological equation or scenario parameter was intentionally changed.


## 2.0.0-rc.3 — 2026-10-23

- Internationalized model/result identifiers to English while preserving all numerical literals from RC2.
- Renamed the fetal transition scenario to `FetalToNeonatal_Transition`.
- Reworked oxygen concentration/molar-flow type metadata toward SI-compatible Modelica types without changing numerical equations or parameter values.
- Updated current maintainer email and PROMES-CNRS / UPVD affiliations.
- Standardized the target dependency stack to Modelica 3.2.3 + Physiolibrary 2.3.1.
- Added explicit OMEdit loading-order instructions for installations that preload Modelica 4.x.
- Added scenario/profile configuration, CSV generation, deterministic virtual-patient parameter overrides, metadata capture and broad result sanity checks.
- Added identifier migration documentation, data-generation guidance and stronger static/configuration tests.
- Preserved the original v1 source and the pre-English RC2 source under `legacy/`.

## 2.0.0-rc.2 — 2026-10-23

- Compatibility-preserving engineering audit of the monolithic Modelica source.
- Added dependency/bootstrap/check scripts and repository documentation.
- Corrected non-physiological source defects and standardized version metadata.
- RC2 was manually checked in OMEdit: all ten principal scenarios passed `Check Model`; the healthy neonatal 5 s DASSL simulation completed successfully.

## 1.x

Historical research code associated with the published PatientEvoPhysio simulator studies.


## Final GitHub-ready adjustments

- Added `Resources/Images/icons/` visual placeholder scaffold.
- Added repository deposition and GitHub release planning documentation.
- Preserved user-provided original/latest `.mo` visual references under `legacy/`.
- Added GitHub Actions Python static check workflow.
- Kept the validated model and data-generation pipeline unchanged.

- Final visual fix: externalized verified historical graphics into `Resources/Images/legacy/`, preserved original Modelica extents, removed active embedded Base64 PNG payloads, and added visual-asset integrity tests.
