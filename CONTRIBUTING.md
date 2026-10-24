# Contributing

PatientEvoPhysio represents published physiological models, so scientific changes require more evidence than ordinary code refactoring.

## Engineering-only changes

Examples: documentation, tests, automation, identifier cleanup, plotting/data tools. These should preserve the frozen numerical baseline unless explicitly documented.

## Scientific/model changes

Any change to equations, topology or physiological parameterization should include:

1. the scientific rationale;
2. affected scenarios and variables;
3. references or experimental/clinical basis when applicable;
4. before/after simulation evidence;
5. updated regression baselines and documentation.

## Pull-request checks

Run:

```bash
python tests/static_audit.py
python tests/test_generator_config.py
python tests/compare_numeric_baseline.py
python scripts/generate_csv.py --list
```

and, when OpenModelica is available:

```text
omc scripts/check_scenarios.mos
omc scripts/smoke_neonate.mos
```

Do not commit generated OpenModelica build products or large simulation outputs to the source repository.
