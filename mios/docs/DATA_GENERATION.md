# Data generation

PatientEvoPhysio v2.0.0 separates scientific outputs from compiler artifacts and makes curated output the default.

## Default mode: curated

```bash
python scripts/generate_csv.py --scenario neonate_healthy
```

OpenModelica receives a `variableFilter` generated from `config/core_variables.json`, so the result file contains only the stable scientific subset instead of every internal/algebraic variable.

## Raw mode

```bash
python scripts/generate_csv.py --scenario neonate_healthy --raw
```

Raw mode is intended for debugging and model auditing. It may be substantially larger.

## Both

```bash
python scripts/generate_csv.py --scenario neonate_healthy --both
```

The raw result is retained and a curated result is derived from it.

## Output tree

```text
data/generated/profiles/<profile>/<scenario>/
  <scenario>_res.csv        curated result (default / --both)
  <scenario>_raw.csv        --raw / --both only
  metadata.json
  omc.log
  run.mos

data/generated/runs/<run_id>/
  ...                       explicit/custom runs and virtual patients
```


Named profiles are part of the output path. Therefore the same scenario can be
run at different horizons without overwriting prior results. For example:

```text
data/generated/profiles/hemodynamic_smoke/neonate_healthy/
data/generated/profiles/neonate_oxygen_10min/neonate_healthy/
```

This separation is intentional and tested automatically.

`metadata.json` records the model SHA-256, OpenModelica version, dependencies, run settings, output mode and repository-relative artifact names. Absolute paths may occur in `omc.log` because it is a local compiler diagnostic, but public metadata is portable.

## Long simulations

`RUN_EXTENDED_VALIDATION.bat` runs 600 s oxygen and 720 s fetal-to-neonatal transition profiles with curated output. A 24 h profile exists but is intentionally manual:

```bash
python scripts/generate_csv.py --profile transition_24h
```

## Virtual cohorts

`generate_population.py` executes deterministic parameter sets. RC7 intentionally does not invent physiological parameter distributions. Define scientifically justified ranges/correlations before adding LHS/Sobol/random sampling.

## RC7 publication profiles

In addition to routine validation profiles, RC7 defines:

- `hybrid_discovery_30s`: high-resolution healthy-neonate time series for hybrid/system-identification work;
- `diagnosis_benchmark_30s`: same solver/output horizon across the six neonatal healthy/pathology scenarios;
- `oxygen_benchmark_10min`: 10 min oxygen-dynamics benchmark across the six neonatal scenarios.

Named experiment plans in `config/experiment_plans.json` group profiles for publication workflows. Use `scripts/run_experiment_plan.py <plan>` or the root-level Windows launchers.

## Virtual population design

`generate_parameter_design.py` supports reproducible Latin-hypercube sampling from a user-supplied parameter-space CSV. The repository intentionally ships only a disabled template because physiologically defensible bounds must be sourced and documented before sampling. Every generated design includes a random seed and design metadata.
