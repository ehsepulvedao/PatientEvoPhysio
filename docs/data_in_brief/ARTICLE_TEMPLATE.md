# Physiology-informed synthetic neonatal cardiorespiratory dataset generated with PatientEvoPhysio

> Working Data in Brief-style draft. Replace all `[TO COMPLETE]` fields and confirm journal scope/template before submission. Do not add a Discussion, Conclusion or Summary section if the current journal instructions still prohibit them.

## Authors

Edgar Hernando Sepúlveda-Oviedo¹˒², [TO COMPLETE co-authors]

¹ PROMES-CNRS (UPR 8521), Rambla de la thermodynamique, Tecnosud, Perpignan, 66100, France
² Université de Perpignan Via Domitia, 52 Avenue Paul Alduy, Perpignan, 66860, France

Corresponding author: edgar-hernando.sepulveda-oviedo@univ-perp.fr

## Abstract

This data article describes a synthetic, physiology-informed cardiorespiratory dataset generated with the open PatientEvoPhysio Modelica library. The data include time-resolved cardiovascular and oxygen-transport variables from healthy and pathological neonatal scenarios and, where included in the deposited release, fetal-to-neonatal transition scenarios. Each simulation is accompanied by machine-readable provenance, model and software version information, quality-control summaries, variable metadata and cryptographic checksums. The dataset is intended to support reproducible computational physiology, interpretable system identification, hybrid dynamical-system discovery, diagnostic algorithm benchmarking and educational applications. [TO COMPLETE: final number of simulations, virtual patients, files, data repository and DOI].

## Specifications table

| Field | Description |
|---|---|
| Subject | Biomedical Engineering; Computational Physiology |
| Specific subject area | Neonatal cardiovascular and respiratory modelling; synthetic physiological data |
| Type of data | Time-series CSV data; JSON metadata; quality-control tables; SVG quality-control figures |
| Data collection | Mechanistic simulations generated with PatientEvoPhysio using OpenModelica; exact solver settings and software versions are stored per run |
| Data source location | In silico; not applicable as a physical sampling location |
| Data accessibility | [TO COMPLETE: repository name, DOI, persistent URL] |
| Related research article | Sepúlveda-Oviedo et al., Journal of Medical Engineering & Technology (2022); Sepúlveda-Oviedo et al., Biocybernetics and Biomedical Engineering (2024) |

## Value of the Data

- The data provide fully traceable cardiorespiratory time series with known physiological scenario labels and access to internal simulator states that are difficult or impossible to collect simultaneously in neonates.
- The dataset can support benchmarking of interpretable machine-learning, system-identification, symbolic-regression and hybrid dynamical-system methods under reproducible conditions.
- Healthy and congenital-pathology scenarios enable controlled comparisons in which model parameters, simulated states and generated observations are linked by explicit provenance.
- The included quality-control files, software hashes and deterministic generation workflow allow other researchers to reproduce, extend or challenge the dataset.

## Background

PatientEvoPhysio is an open Modelica library developed to represent cardiovascular and respiratory physiology across adult, child, neonatal and fetal contexts. Previous publications describe the neonatal cardiorespiratory simulator and the fetal-to-neonatal transition model. The present data package focuses on making generated physiological time series reusable as a documented research object rather than embedding them only in figures or supplementary material.

## Data Description

[TO COMPLETE after final generation using `release/.../dataset_index.csv` and `variable_dictionary.csv`.]

Describe:

- directory structure;
- number of runs and scenarios;
- number of virtual patients, if applicable;
- temporal resolution and duration of each simulation profile;
- core hemodynamic variables;
- oxygen variables;
- valve states and hybrid-system ground truth;
- metadata, quality reports and checksums;
- raw versus curated data availability.

## Experimental Design, Materials and Methods

### Simulation environment

The data were generated from `PatientEvoPhysio.mo` using the dependency stack documented in the repository. Each run stores the exact OpenModelica version, source-model SHA-256 hash, Modelica/Physiolibrary versions, solver, tolerance, temporal horizon and number of output intervals.

### Physiological scenarios

[TO COMPLETE from `config/scenarios.json` and the final dataset index.]

### Data generation

Reference simulations are generated through named profiles in `config/scenarios.json`. Virtual-patient cohorts, when included, are generated from a parameter-space file containing explicitly documented physiological bounds. PatientEvoPhysio does not invent parameter ranges automatically. Latin-hypercube designs are reproducible through a stored random seed and design metadata.

### Data curation

The default exported dataset contains a documented subset of physiologically relevant variables selected through `config/core_variables.json`. Full raw OpenModelica output can be retained explicitly when required. Curation does not change the underlying simulator equations.

### Quality control

Every run is checked for non-finite values, non-monotonic time, negative volumes outside numerical tolerance, broad pressure explosion limits, oxygen saturation outside broad engineering limits and non-Boolean valve states. Scientific summaries quantify key pressure, volume, flow, oxygen and valve-event characteristics. Dataset-level reports verify model-hash consistency and aggregate all run-level validation states.

## Limitations / scope notes for the data description

[Use only if compatible with the current journal template.] The data are synthetic outputs of a mechanistic model and are not patient measurements. Their fidelity is limited by model structure, parameterization and the physiological assumptions documented in the associated publications and repository. Generated data should therefore be used for computational research and benchmarking, not as a substitute for clinical observations or clinical decision-making.

## Ethics statement

The released files contain computationally generated synthetic/in-silico data and no identifiable human participant records. [TO COMPLETE/VERIFY institution-specific requirements before submission.]

## Data Availability

The data described in this article are available at: [TO COMPLETE repository, DOI, URL].

## CRediT authorship contribution statement

[TO COMPLETE]

## Acknowledgements

[TO COMPLETE]

## Declaration of competing interest

[TO COMPLETE]

## References

[TO COMPLETE with the two PatientEvoPhysio research articles and only directly relevant sources.]
