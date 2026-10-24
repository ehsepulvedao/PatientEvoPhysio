<div align="center">

# 🫀 PatientEvoPhysio

### Open-source Modelica library for cardiovascular and respiratory computational physiology

<img src="Resources/Images/PatientEvoPhysio_banner.png" alt="PatientEvoPhysio — computational physiology from fetal life to adulthood" width="100%">

**From fetal life to adulthood — interpretable computational physiology in Modelica**

![Release](https://img.shields.io/badge/release-v2.0.0-0ea5e9)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.10054996.svg)](https://doi.org/10.5281/zenodo.10054996)
![Modelica](https://img.shields.io/badge/Modelica-3.2.x-blue)
![Physiolibrary](https://img.shields.io/badge/Physiolibrary-2.3.1-green)
![OpenModelica](https://img.shields.io/badge/validated%20with-OpenModelica%201.27.1-1f6feb)
![Scenarios](https://img.shields.io/badge/canonical%20scenarios-10-8b5cf6)
![License](https://img.shields.io/badge/License-CC0%201.0-lightgrey)

</div>

---

## What is PatientEvoPhysio?

**PatientEvoPhysio** is an open-source Modelica library for mechanistic simulation of human cardiovascular and respiratory physiology across the life cycle. It combines reusable physiological components with complete simulation scenarios spanning **fetal life, neonatal transition, childhood and adulthood**.

The library was developed to provide an interpretable, equation-based environment for research and teaching in computational physiology. Its models include cardiovascular dynamics, respiratory physiology, oxygen transport, altitude-dependent physiology, congenital cardiovascular conditions, and the fetal-to-neonatal transition.

PatientEvoPhysio is built on reusable Modelica components and uses **Physiolibrary 2.3.1** for physiological modeling primitives.

> **v2.0.0 is the recommended stable release.**

---

## 🔬 Physiological scope

| Life stage | Main capabilities |
|---|---|
| 🤰 **Fetal** | Fetal circulation, placental oxygen exchange, umbilical circulation and fetal-to-neonatal transition |
| 👶 **Neonatal** | Cardiovascular–respiratory physiology, oxygen transport, healthy physiology and congenital cardiovascular conditions |
| 🧒 **Childhood** | Pediatric cardiovascular scenarios, including healthy and stenosis cases |
| 🧑 **Adulthood** | Adult cardiovascular and respiratory physiology |

The library includes healthy physiological models as well as representative pathological conditions and transitional scenarios.

---

## 🏗️ Library architecture

The active Modelica package is organized into eight main namespaces:

| Package | Purpose |
|---|---|
| 🎨 `Icons` | Visual definitions used by physiological components |
| 🧩 `Components` | Reusable cardiovascular, respiratory and physiological building blocks |
| 📐 `Types` | Specialized quantities and data types |
| 🧍 `Scenarios` | Complete adult, child, neonatal and fetal models |
| 🔌 `Connectors` | Physiological flow and signal interfaces |
| 🧮 `Functions` | Hill-type and pulmonary/placental support functions |
| 📈 `Signals` | Elastance, respiration, vascular and transition signals |
| 📚 `UsersGuide` | Embedded documentation, authorship and scientific information |

Graphical resources used by OMEdit are stored under `Resources/Images/` and referenced through portable `modelica://PatientEvoPhysio/...` URIs.

---

## 🚀 Installation and configuration

### Requirements

PatientEvoPhysio v2.0.0 has been validated with:

```text
OpenModelica / OMEdit 1.27.1
Physiolibrary 2.3.1
Modelica 3.2.x compatible dependency stack
```

> [!IMPORTANT]
> Recent OpenModelica installations may automatically load the newest Modelica Standard Library (Modelica 4.x).  
> **PatientEvoPhysio v2.0.0 must be used with the Modelica 3.2.x stack required by Physiolibrary 2.3.1.**
> Do not mix Modelica 4.x / Complex 4.x / ModelicaServices 4.x with Physiolibrary 2.3.1 in the same OMEdit session.

### 1. Disable automatic loading of the latest Modelica version

Before opening `PatientEvoPhysio.mo`:

1. Open **OMEdit**.
2. Go to:

   **Tools → Options → Libraries**

3. Disable:

   **Load latest Modelica version on startup**

4. Apply the change.
5. **Close OMEdit completely and restart it.**

This prevents OMEdit from automatically loading a Modelica 4.x stack before PatientEvoPhysio is opened.

### 2. Install Physiolibrary 2.3.1

After restarting OMEdit:

1. Go to:

   **File → Manage Libraries → Install Library**

2. Select:

   - **Library:** `Physiolibrary`
   - **Version:** `2.3.1`
   - Keep **Exact Match** enabled.

3. Install the library.

The OpenModelica Package Manager will install the compatible dependencies required by Physiolibrary.

### 3. Load the compatible Modelica 3.2.x stack

1. Return to:

   **Tools → Options → Libraries**

2. Manually select/load the **Modelica 3.2.x** version installed for Physiolibrary 2.3.1.
3. Make sure that a Modelica 4.x version is **not** loaded in the same session.
4. Restart OMEdit once more if required.

Depending on the OpenModelica Package Manager revision, the installed compatible package may appear with a maintenance suffix such as `+maint.om`. This is normal.

### 4. Open PatientEvoPhysio

Only after the compatible libraries are available:

1. Open `PatientEvoPhysio.mo`.
2. Confirm that `PatientEvoPhysio` appears in the Libraries browser.
3. Open any model under `PatientEvoPhysio.Scenarios`.

If OMEdit reports that a base class from `Physiolibrary` cannot be found, close PatientEvoPhysio and verify that:

- Physiolibrary **2.3.1** is installed and loaded;
- the active Modelica stack is **3.2.x**, not 4.x;
- no incompatible Modelica/Complex/ModelicaServices 4.x packages were loaded earlier in the session.

Then restart OMEdit and reopen `PatientEvoPhysio.mo`.

### Clone the repository

```bash
git clone https://github.com/ehsepulvedao/PatientEvoPhysio.git
cd PatientEvoPhysio
```

Then follow the configuration steps above and open `PatientEvoPhysio.mo` with OMEdit.

---

## 🧍 Available scenarios

The canonical v2 scenarios include:

```text
PatientEvoPhysio.Scenarios.Adult.Healthy

PatientEvoPhysio.Scenarios.Child.Healthy
PatientEvoPhysio.Scenarios.Child.Stenosis

PatientEvoPhysio.Scenarios.Neonate.Healthy
PatientEvoPhysio.Scenarios.Neonate.Stenosis
PatientEvoPhysio.Scenarios.Neonate.Coarctation_of_the_Aorta
PatientEvoPhysio.Scenarios.Neonate.Tetralogy_of_Fallot
PatientEvoPhysio.Scenarios.Neonate.Transposition_of_the_Great_Arteries
PatientEvoPhysio.Scenarios.Neonate.Persistence_of_Ductus_Arteriosus

PatientEvoPhysio.Scenarios.Fetus.FetalToNeonatal_Transition
```

---

## ▶️ Running a simulation

1. Open one of the models under `PatientEvoPhysio.Scenarios`.
2. Open **Simulation Setup**.
3. Set the desired simulation time and numerical options.
4. Run the simulation.
5. Inspect the physiological variables directly in OMEdit.

No external scripts are required to use the simulator.

---

## 📊 Saving simulation results as CSV

Simulation results can be exported directly by OMEdit.

In **Simulation Setup**, open the **Output** section and select:

```text
Output Format: csv
```

You can also define the result file name and use the variable filter to choose which variables are stored.

The generated CSV file is written to the simulation working directory. The OMEdit working directory can be configured under:

**Tools → Options → General → Working Directory**

This allows users to generate their own simulation datasets directly from the physiological models without requiring additional scripts from the repository.

---

## 📁 Public repository structure

The public distribution intentionally contains only the simulator and the resources required to use and cite it:

```text
PatientEvoPhysio.mo
README.md
CITATION.cff
LICENSE

Resources/
└── Images/
    ├── PatientEvoPhysio_banner.png
    └── icon/
        └── *.svg
```

Simulation results, generated datasets, analysis scripts, validation pipelines and local research workflows are not part of the public distribution.

---

## 📖 Scientific publications

PatientEvoPhysio and its underlying physiological models have been described and applied in the following peer-reviewed publications:

1. **Sepúlveda-Oviedo EH, Bermeo Clavijo LE, Méndez Córdoba LC.**  
   *Effect of timing of umbilical cord clamping and birth on fetal to neonatal transition: OpenModelica-based virtual simulator-based approach.*  
   **Biocybernetics and Biomedical Engineering.** 2024;44(3):716–730.  
   DOI: [10.1016/j.bbe.2024.08.008](https://doi.org/10.1016/j.bbe.2024.08.008)

2. **Sepúlveda-Oviedo EH, Bermeo Clavijo LE, Méndez Córdoba LC.**  
   *OpenModelica-based virtual simulator for the cardiovascular and respiratory physiology of a neonate.*  
   **Journal of Medical Engineering & Technology.** 2022;46(3):179–197.  
   DOI: [10.1080/03091902.2022.2026500](https://doi.org/10.1080/03091902.2022.2026500)

Additional scientific information is embedded in the `PatientEvoPhysio.UsersGuide` package.

---

## 📌 Citation

If you use PatientEvoPhysio in scientific work, please cite the software and the scientific publication corresponding to the model or scenario used.

**Software DOI:** [10.5281/zenodo.10054996](https://doi.org/10.5281/zenodo.10054996)

A machine-readable citation is provided in [`CITATION.cff`](CITATION.cff).

---

## 👥 Authors and maintenance

PatientEvoPhysio was developed through the collaboration of:

- **Edgar Hernando Sepúlveda-Oviedo** — original author and scientific contributor
- **Leonardo Enrique Bermeo Clavijo** — original author and scientific contributor
- **Luis Carlos Méndez-Córdoba** — original author and scientific contributor

### Current project maintenance

**Edgar Hernando Sepúlveda-Oviedo**  
PROMES-CNRS (UPR 8521), Perpignan, France  
Université de Perpignan Via Domitia, Perpignan, France  
Email: `edgar-hernando.sepulveda-oviedo@univ-perp.fr`

The current v2 development and maintenance line is led by Edgar Hernando Sepúlveda-Oviedo. Historical scientific contributions and authorship are preserved in the associated publications and in the embedded `UsersGuide`.

---

## 🤝 Contributions

Bug reports, compatibility tests, physiological validation cases, documentation improvements and new scientifically justified scenarios are welcome.

For substantial changes to physiological models, opening an issue first is recommended so that numerical and physiological implications can be discussed explicitly.

---

## ⚖️ License

PatientEvoPhysio is released under the license provided in [`LICENSE`](LICENSE).

PatientEvoPhysio depends on **Physiolibrary 2.3.1**.

---

## ⚠️ Disclaimer

PatientEvoPhysio is research and educational software. It is **not a medical device** and is not intended for clinical diagnosis, treatment decisions or direct patient management.

---

<div align="center">

### 🫀 PatientEvoPhysio v2.0.0

**Mechanistic physiology · open simulation · interpretable physiological modeling**

If PatientEvoPhysio is useful to your work, consider ⭐ starring the repository.

</div>
