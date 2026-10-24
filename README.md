# PatientEvoPhysio

**PatientEvoPhysio** is an open-source Modelica library for mechanistic simulation of cardiovascular and respiratory physiology across fetal life, neonatal transition, childhood, and adulthood.

## Requirements

- OpenModelica / OMEdit 1.27.x
- Physiolibrary 2.3.1

## Installation

1. Install OpenModelica and open **OMEdit**.
2. Go to:

   **File → Manage Libraries → Install Library**

3. Select:
   - **Library:** `Physiolibrary`
   - **Version:** `2.3.1`
   - Keep **Exact Match** enabled.

4. Install the library and restart OMEdit.
5. Open `PatientEvoPhysio.mo`.

The OpenModelica Package Manager will install the dependencies required by Physiolibrary.

## Available scenarios

- `PatientEvoPhysio.Scenarios.Adult.Healthy`
- `PatientEvoPhysio.Scenarios.Child.Healthy`
- `PatientEvoPhysio.Scenarios.Child.Stenosis`
- `PatientEvoPhysio.Scenarios.Neonate.Healthy`
- `PatientEvoPhysio.Scenarios.Neonate.Stenosis`
- `PatientEvoPhysio.Scenarios.Neonate.Coarctation_of_the_Aorta`
- `PatientEvoPhysio.Scenarios.Neonate.Tetralogy_of_Fallot`
- `PatientEvoPhysio.Scenarios.Neonate.Transposition_of_the_Great_Arteries`
- `PatientEvoPhysio.Scenarios.Neonate.Persistence_of_Ductus_Arteriosus`
- `PatientEvoPhysio.Scenarios.Fetus.FetalToNeonatal_Transition`

## Running a simulation

1. Open a model under `PatientEvoPhysio.Scenarios`.
2. Open **Simulation Setup**.
3. Set the desired simulation time and numerical options.
4. Run the simulation.

## Saving simulation results as CSV

No additional scripts are required.

In **Simulation Setup**, open the **Output** section and select:

`Output Format: csv`

You may also define the result file name and use the variable filter to select which variables are stored.

The result CSV is generated in the simulation working directory. The OMEdit working directory can be configured under:

**Tools → Options → General → Working Directory**

## Repository contents

The public repository contains only the simulator and the files required to use and cite it:

```text
PatientEvoPhysio.mo
Resources/
  Images/
    icon/
README.md
LICENSE
CITATION.cff
.gitignore
```

Simulation results, generated datasets, analysis scripts, validation pipelines, publication utilities, and local research workflows are not included in the public distribution.

## Citation

If you use PatientEvoPhysio in scientific work, please cite the software and the scientific publication corresponding to the physiological scenario used.

See `CITATION.cff` for the software citation.

DOI: **10.5281/zenodo.10054996**

## Authors

- Edgar Hernando Sepúlveda-Oviedo
- Leonardo Enrique Bermeo Clavijo
- Luis Carlos Méndez-Córdoba

## License

See `LICENSE` for the licensing terms.

PatientEvoPhysio depends on **Physiolibrary 2.3.1**.
