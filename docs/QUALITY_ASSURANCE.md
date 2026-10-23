# Quality assurance framework

The data pipeline uses multiple independent layers of quality control.

## Software and model integrity

- static source audit;
- balanced Modelica delimiters and dependency declarations;
- numeric-baseline preservation check;
- OpenModelica `checkModel` for reference scenarios;
- reproducible dependency versions;
- SHA-256 hash of the Modelica source stored in every run metadata file.

## Numerical quality

Each curated CSV is checked for:

- missing/non-finite values;
- monotonic simulation time;
- negative volumes outside numerical tolerance;
- broad pressure explosion guardrails;
- oxygen saturation outside broad engineering limits;
- valve-state values outside the Boolean 0/1 domain.

These are engineering sanity checks, not clinical reference intervals.

## Scientific descriptive quality

`scripts/scientific_report.py` computes:

- observed heart rate from aortic-valve opening events;
- valve opening counts;
- min/max/mean for core pressures, volumes and flows;
- initial/final/min/max arterial oxygen saturation;
- first crossing of 90% and 95% arterial oxygen saturation, when present;
- descriptive SVG figures including ventricular pressure-volume trajectories.

## Initialization quality

The initialization diagnostic records any variables for which OpenModelica assumes fixed start values. The validated baseline is documented rather than silently forcing additional `fixed=true` constraints.

## Dataset-level quality

`scripts/dataset_quality_report.py` aggregates every run and checks:

- per-run PASS/REVIEW state;
- consistency of model hashes;
- OpenModelica and dependency versions;
- run inventory and data volume;
- presence of scientific reports and provenance.

## Reproducibility

Every run stores solver settings, scenario, profile, source-model hash, dependency versions, OpenModelica version, portable reproduction script, validation files and scientific summaries.
