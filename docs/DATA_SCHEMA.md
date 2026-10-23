# Generated data schema

## Curated CSV

The canonical variable selection is defined in `config/core_variables.json`. It prioritizes:

- time;
- physiological pressures (`*.pressure_mmHg`);
- physiological flows (`*.flow_L_per_min`);
- compartment volumes (`*.volume`);
- oxygen saturation/concentration outputs;
- valve states (`*.open`);
- vascular resistance (`*.R`);
- selected elastance/heart-period signals;
- respiration/altitude variables relevant to transition studies.

This is a software schema, not yet the final publication-dataset schema. It can be frozen once the scientific dataset study defines observable/mechanistic views.

## Metadata

`metadata.json` schema v2 stores:

- scenario/model;
- numerical simulation settings;
- parameter overrides;
- output mode;
- exact variable filter;
- SHA-256 of `PatientEvoPhysio.mo`;
- OpenModelica and dependency versions;
- portable relative artifact references;
- temporary-build retention state.

## Validation

Routine summary:

```text
*_res.validation.json
```

Full statistics:

```text
*_res.validation.details.json
```

The summary is intentionally small enough for automated QA/CI. Details retain per-variable min/max/count/non-finite statistics.

## Publication-derived products

The simulation CSV remains the authoritative numerical output. RC7 may add derived research products without modifying the source CSV:

- `report/scientific_summary.*`: descriptive run metrics;
- `report/*.svg`: quality-control visualizations;
- `*.hybrid.csv`: optional left-heart hybrid-mode labels derived from valve states and the LV pressure derivative;
- `data/analysis/ml_timeseries_index.csv`: scenario-labelled file index;
- `data/analysis/diagnosis_feature_table.csv`: compact descriptive feature table derived from run summaries;
- `data/quality/*`: dataset-level QA aggregation;
- `release/*`: upload-ready dataset packages.
