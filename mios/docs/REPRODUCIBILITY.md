# Reproducibility

A PatientEvoPhysio dataset is reproducible at three levels.

1. **Software provenance**: repository version, source-model SHA-256, Modelica 3.2.3, Physiolibrary 2.3.1 and OpenModelica version are recorded.
2. **Simulation provenance**: start/stop times, number of intervals, solver, tolerance, scenario and parameter overrides are stored in `metadata.json`.
3. **Data provenance**: each release contains a dataset index, variable dictionary, validation summaries and SHA-256 file checksums.

For virtual populations, the parameter-space file, design method, number of patients and random seed must be archived with the generated cohort.

The repository deliberately avoids absolute personal paths in public metadata. Compiler artifacts are isolated under `build/` and ignored by Git.
