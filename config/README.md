# Configuration files

- `scenarios.json`: canonical scenario identifiers and reproducible simulation profiles.
- `core_variables.json`: recommended variables for curated datasets and hybrid-system analysis.
- `virtual_population.example.csv`: **format example only** for deterministic parameter overrides.

No random physiological distributions are included in this release candidate. Population ranges and joint distributions must be scientifically justified before they are used to generate a research dataset.

## Publication configuration files

- `experiment_plans.json`: named groups of reproducible simulation profiles for publication workflows.
- `publication_variables.json`: variable groups useful for hemodynamic, oxygen, hybrid-system and diagnostic analyses.
- `parameter_space.template.csv`: disabled template for literature-supported virtual-cohort parameter bounds. Do not publish a cohort generated from arbitrary/unverified ranges.
