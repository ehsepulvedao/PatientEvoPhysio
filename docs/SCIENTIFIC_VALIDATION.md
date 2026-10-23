# Scientific validation notes

PatientEvoPhysio is a mechanistic simulator, not a source of clinical ground truth by itself. Synthetic outputs used in future datasets should be traceable to a validated simulator version and parameter set.

## Current evidence

The underlying neonatal and fetal-transition models have been described in peer-reviewed publications. The current source has subsequently evolved, so exact numerical reproduction of historical figures is not required unless a release explicitly claims publication reproduction.

For v2, validation should include:

- compiler/model-balance checks;
- numerical stability and absence of NaN/Inf;
- preservation of plausible orders of magnitude;
- expected cardiac periodicity and valve switching;
- oxygen saturation bounded to meaningful values;
- scenario-specific qualitative/pathophysiological behavior;
- regression against a frozen v2 baseline after the stable version is established.

## Broad engineering guards vs physiology

`scripts/validate_results.py` uses deliberately wide guards to detect catastrophic failures. Passing those checks does **not** prove clinical validity. Publication datasets should add scenario-specific physiological acceptance criteria with citations and explicit uncertainty.

## Stable baseline

After RC7 passes standard and extended OpenModelica testing, store baseline metrics for each scenario (min/max pressures, volumes, flows, valve event counts, oxygen values and selected transition endpoints). Future pull requests that intentionally change those values should document why.
