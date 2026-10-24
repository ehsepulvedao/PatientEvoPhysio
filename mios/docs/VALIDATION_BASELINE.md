# Validated RC6 baseline carried into RC7

Environment used for user-side validation:

- OpenModelica 1.27.1 (64-bit)
- Modelica 3.2.3
- Complex 3.2.3
- ModelicaServices 3.2.3
- Physiolibrary 2.3.1

## Standard workflow

- Curated CSV files checked: 9
- Files requiring review: 0
- Healthy-neonate initialization: successful
- Unspecified-initial-condition warning in diagnostic mode: false
- Automatically assumed fixed starts: 14

Expected initialization-baseline variables:

- `leftAtrium.q_in.conc`
- `leftVentricle.q_in.conc`
- `intrathoracicArteries.q_in.conc`
- `extrathoracicArteries.q_in.conc`
- `rightVentricle.q_in.conc`
- `pulmonaryArteries.q_in.conc`
- `pulmonaryVeins.q_in.conc`
- `extrathoracicVeins.q_in.conc`
- `intrathoracicVeins.q_in.conc`
- `rightAtrium.q_in.conc`
- `leftAtrialElastanceSignal.HP`
- `rightAtrialElastanceSignal.HP`
- `leftVentricularElastanceSignal.HP`
- `rightVentricularElastanceSignal.HP`

## Extended workflow

- Healthy-neonate oxygen profile: 600 s, PASS
- Fetal-to-neonatal transition profile: 720 s, PASS
- Curated extended CSV files checked: 2
- Files requiring review: 0

## Representative healthy-neonate 5 s metrics

A validated OpenModelica result used to test the RC7 scientific-report tools produced approximately:

- observed heart rate: 130.006 bpm;
- left-ventricular pressure: 3.27–69.09 mmHg;
- left-ventricular volume: 1.75–4.93 mL (stored as SI m3 in the CSV);
- intrathoracic arterial pressure: 37.48–68.57 mmHg;
- pulmonary arterial resistance flow: approximately 0–2.70 L/min (small numerical reverse values may appear around zero);
- aortic valve openings in 5 s: 11.

These values are regression/descriptive reference points for the validated software configuration, not clinical acceptance intervals.
