# Publication-oriented workflows

PatientEvoPhysio separates the validated mechanistic model from publication-specific data preparation. The model equations and scenario parameterizations are not altered by the workflows below.

## 1. Synthetic dataset / data article

Use the validated reference profiles, add any scientifically justified virtual-patient parameter design, generate all curated CSV files, run quality control, and build an upload-ready dataset release.

Windows entry points:

```text
RUN_STANDARD_VALIDATION.bat
RUN_EXTENDED_VALIDATION.bat
RUN_DATA_ARTICLE_REFERENCE.bat
RUN_SCIENTIFIC_REPORTS.bat
BUILD_DATASET_RELEASE.bat
```

The final dataset release contains a dataset index, variable dictionary, checksums, provenance, per-run metadata, validation outputs and quality summaries.

## 2. Hybrid dynamical-system / symbolic-discovery article

Generate the 30 s high-resolution healthy-neonate profile:

```text
RUN_HYBRID_DISCOVERY_DATA.bat
```

Then create phase labels from the valve states and the left-ventricular pressure derivative:

```text
python scripts/derive_hybrid_labels.py <curated_csv>
```

The derived modes are:

- filling;
- isovolumetric contraction;
- ejection;
- isovolumetric relaxation;
- valve overlap review (quality-control state only).

The original simulator variables remain available so a discovery algorithm can be evaluated against known valve states and switching events.

## 3. Diagnostic / inverse-identification article

Generate the six neonatal scenarios with the same 30 s profile:

```text
RUN_DIAGNOSIS_BENCHMARK_DATA.bat
```

Generate scientific summaries, then build a compact scenario-labelled feature table:

```text
RUN_SCIENTIFIC_REPORTS.bat
python scripts/build_feature_table.py
```

For a virtual cohort, first define literature-supported parameter bounds in a copy of `config/parameter_space.template.csv`, then use `scripts/generate_parameter_design.py` and `scripts/generate_population.py`.

## 4. Oxygen / transition article

Use:

```text
RUN_EXTENDED_VALIDATION.bat
```

or the broader oxygen benchmark:

```text
RUN_OXYGEN_BENCHMARK_DATA.bat
```

The 24 h fetal-to-neonatal profile remains available as `transition_24h` but is deliberately not part of routine validation.

## Important rule for virtual populations

PatientEvoPhysio does not ship invented physiological parameter ranges. The sampling engine is complete, but the ranges and correlations must be justified from literature, clinical references or a documented calibration protocol before cohort generation.
