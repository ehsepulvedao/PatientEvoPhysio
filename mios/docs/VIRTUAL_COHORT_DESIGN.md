# Virtual cohort design

The repository contains the full mechanics required to generate parameterized virtual patients but intentionally does not prescribe physiological distributions.

## Workflow

1. Copy `config/parameter_space.template.csv` to `config/parameter_space.csv`.
2. Select parameters that are scientifically identifiable/relevant to the publication objective.
3. Define min/max bounds and scale using literature, clinical references or a documented calibration source.
4. Record a citation/source for every bound in the publication protocol or an accompanying table.
5. Enable only reviewed parameters.
6. Generate a deterministic Latin-hypercube design with a stored seed.
7. Run `generate_population.py` using the desired named profile.
8. Validate every generated patient; REVIEW cases should be investigated rather than automatically discarded.
9. Archive the parameter-space file, design CSV and design metadata with the public dataset.

## Correlations

The current Latin-hypercube helper samples enabled parameters independently. Physiological correlations must not be ignored when they are scientifically material. For a final large cohort, either define a justified correlated design extension or restrict sampling to parameter combinations that pass a documented physiological plausibility protocol.
