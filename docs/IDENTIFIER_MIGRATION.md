# Identifier migration: legacy → v2 English names

RC3 internationalizes public model instances and commonly inspected variables. This changes OpenModelica result paths and therefore requires downstream scripts/plots to use the new names.

## Core component classes and variables

| Legacy | v2 |
|---|---|
| `Constante_Elastance` | `Constant_Elastance` |
| `presion` | `pressure_mmHg` |
| `flujo` | `flow_L_per_min` |
| `Saturacion` | `oxygenSaturation` |
| `Consumo` | `metabolicConsumption` |
| `Mi` | `metabolicConsumptionRate` |
| `ConcentracionInput` | `ConcentrationInput` |
| `ConcentracionOutput` | `ConcentrationOutput` |
| `Pulmonar` | `Pulmonary_Vascular_Transition` |
| `Fetus2neonate_transition` | `FetalToNeonatal_Transition` |

## Cardiac chambers

| Legacy | v2 |
|---|---|
| `Auricula_Derecha` / `Right_atrium` | `rightAtrium` |
| `Auricula_izquierda` / `Left_atrium` | `leftAtrium` |
| `Ventriculo_Derecho` / `Right_ventricle` | `rightVentricle` |
| `Ventriculo_Izquierdo` / `Left_ventricle` | `leftVentricle` |

## Vascular compartments

| Legacy | v2 |
|---|---|
| `Arterias_Intratoracicas` / `Intrathoracic_arteries` | `intrathoracicArteries` |
| `Arterias_Extratoracicas` / `Extrathoracic_arteries` | `extrathoracicArteries` |
| `Arterias_pulmonares` / `Pulmonary_arteries` | `pulmonaryArteries` |
| `Venas_pulmonares` / `Pulmonary_veins` | `pulmonaryVeins` |
| `Venas_Extratoracicas` / `Extrathoracic_veins` | `extrathoracicVeins` |
| `Vena_Intratoraxica` / `Intrathoracic_veins` | `intrathoracicVeins` |

## Valves and resistive/inertial elements

| Legacy | v2 |
|---|---|
| `Valvula_Mitral` | `mitralValve` |
| `Valvula_Aortica` | `aorticValve` |
| `Valvula_Tricuspide` | `tricuspidValve` |
| `Valvula_pulmonar` | `pulmonaryValve` |
| `R_Venas_Pulmonares` | `pulmonaryVenousResistance` |
| `R_Vasos_perifericos_pulmonares` | `pulmonaryPeripheralResistance` |
| `R_Arterias_Pulmonares` | `pulmonaryArterialResistance` |
| `R_Extrathoracic_arteries` | `extrathoracicArterialResistance` |
| `R_Vena_Extratoraxica` | `extrathoracicVenousResistance` |
| `R_Entrada_Auricula_Der` | `rightAtrialInletResistance` |
| `Resistencia_Aortica` | `aorticResistance` |
| `Resistencia_Arterial_Sistemica` | `systemicArterialResistance` |
| `Vasos_Perifericas_Sistemicas` | `systemicPeripheralResistance` |
| `Resistor_Mitral` | `mitralResistance` |
| `Resistor_Tricuspide` | `tricuspidResistance` |
| `Inercia_flujo_sanguineo` | `systemicBloodInertia` |

## Pathology-specific elements

| Legacy | v2 |
|---|---|
| `Flujo_aorta_predominante` | `overridingAortaValve` |
| `R_aorta_predominante` | `overridingAortaResistance` |
| `R_septal_ventricular` | `ventricularSeptalResistance` |
| `R_Foramen_Oval` | `foramenOvaleResistance` |
| `Ducto_Arterioso` / `Ducto_arterioso` | `ductusArteriosusResistance` |
| `inercia_ducto` | `ductusArteriosusInertia` |
| legacy TGA aortic valve/resistance names | `transposedAorticValve`, `transposedAorticResistance` |
| legacy TGA pulmonary valve/resistance names | `transposedPulmonaryValve`, `transposedPulmonaryResistance` |

## Fetal-transition elements

| Legacy | v2 |
|---|---|
| `Arteria_umbilical` | `umbilicalArteryResistance` |
| `Ducto_venoso` | `ductusVenosusResistance` |
| `Foramen_Oval_valve` | `foramenOvaleValve` |
| `Formen_oval` | `foramenOvaleResistance` |
| `Inertia_DA` | `ductusArteriosusInertia` |
| `Time_Pinzamiento` | `clampingTime` |
| `Altura_maxima` | `maximumAltitude` |
| `Delay_Maximo` | `maximumDelay` |
| `pendiente` | `delaySlope` |
| `MSNM` | `altitudeAboveSeaLevel` |

## Cardiac/respiratory signals

| Legacy | v2 |
|---|---|
| `elas_Ventri_Neonato1` | `rightVentricularElastanceSignal` |
| `elas_Ventri_Neonato2` | `leftVentricularElastanceSignal` |
| `elas_Auri_Neonato1` | `rightAtrialElastanceSignal` |
| `elas_Auri_Neonato2` | `leftAtrialElastanceSignal` |
| `pulmonary_Respiration1` | `pulmonaryRespiration` |
| `placental_Respiration1` | `placentalRespiration` |

## Practical example

Legacy result path:

```text
Ventriculo_Izquierdo.presion
```

v2 result path:

```text
leftVentricle.pressure_mmHg
```

The exact pre-English source is preserved in `legacy/PatientEvoPhysio_v2.0.0-rc2_pre_english.mo` for reproducibility.
