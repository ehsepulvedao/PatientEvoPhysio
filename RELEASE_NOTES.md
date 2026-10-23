# PatientEvoPhysio v2.0.0 — stable research-software release

Released: 2026-10-23

PatientEvoPhysio v2.0.0 consolidates the audited and internationalized Modelica package together with reproducible validation, research-data generation, scientific reporting, quality-control and dataset-packaging workflows.

## Highlights

- English identifiers throughout the active v2 Modelica package.
- Modelica 3.2.3 + Physiolibrary 2.3.1 validated dependency stack.
- Ten canonical physiological scenarios spanning fetal, neonatal, childhood and adult models.
- Portable Windows/OpenModelica runners with automatic tool discovery.
- Curated CSV generation with metadata, validation reports and scientific summaries.
- Extended neonatal oxygen and fetal-to-neonatal transition workflows.
- Hybrid cardiac-mode labels and diagnostic benchmark preparation.
- Dataset release builder with provenance, file index, variable dictionary, QA summaries and SHA-256 checksums.
- Externalized active visual assets as SVG files under `Resources/Images/icon/`; no active raster icon files are referenced by the Modelica package and no Base64 image payloads remain in `PatientEvoPhysio.mo`.
- Generated datasets are intentionally excluded from Git and should be deposited separately in a data repository.

## Validation status

The stable release is based on the RC6/RC7 validation campaign performed with OpenModelica 1.27.1 (64-bit). The standard workflow completed the nine short scenarios with zero review flags, initialization diagnostics completed successfully, and the extended 600 s neonatal oxygen and 720 s fetal-to-neonatal transition profiles completed with zero review flags.

For reproducibility, run `RUN_FULL_PUBLICATION_PIPELINE.bat` on a new installation before generating article datasets.

## Compatibility

- Modelica 3.2.3
- Complex 3.2.3
- ModelicaServices 3.2.3
- Physiolibrary 2.3.1
- OpenModelica 1.27.1 used for the validated release workflow
- Python 3.9+ for optional data-generation utilities

## Data releases

The repository contains the software and generators, not the publication-scale generated datasets. Curated datasets should be deposited separately (for example Mendeley Data for moderate article datasets or a CNRS/institutional repository for larger archives) and linked from the corresponding publication/release.
