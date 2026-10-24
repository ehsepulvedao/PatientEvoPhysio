<div align="center">

# 🫀 PatientEvoPhysio

### Open-source Modelica library for cardiovascular and respiratory computational physiology

<img src="docs/assets/PatientEvoPhysio_banner.png" alt="PatientEvoPhysio — computational physiology from fetal life to adulthood" width="100%">

**From fetal life to adulthood — interpretable computational physiology in Modelica**

[![Release](https://img.shields.io/badge/release-v2.0.0-0ea5e9)](RELEASE_NOTES.md)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.10054996.svg)](https://doi.org/10.5281/zenodo.10054996)
![Modelica](https://img.shields.io/badge/Modelica-3.2.3-blue)
![Physiolibrary](https://img.shields.io/badge/Physiolibrary-2.3.1-green)
![OpenModelica](https://img.shields.io/badge/validated%20with-OpenModelica%201.27.1-1f6feb)
![Scenarios](https://img.shields.io/badge/canonical%20scenarios-10-8b5cf6)
![License](https://img.shields.io/badge/License-CC0%201.0-lightgrey)
[![Integrity checks](https://github.com/ehsepulvedao/PatientEvoPhysio/actions/workflows/integrity-checks.yml/badge.svg)](https://github.com/ehsepulvedao/PatientEvoPhysio/actions/workflows/integrity-checks.yml)

</div>

---

## What is PatientEvoPhysio?

**PatientEvoPhysio** is an open-source Modelica library for mechanistic simulation of human cardiovascular and respiratory physiology across the life cycle. It combines reusable physiological components with complete scenarios spanning **fetal life, neonatal transition, childhood and adulthood**.

The project is designed for research, reproducible simulation and teaching where mechanistic interpretability matters. It includes healthy scenarios, congenital cardiovascular conditions, oxygen transport, altitude-dependent physiology and the fetal-to-neonatal transition.

---

## ✨ Current software release

PatientEvoPhysio v2 provides a modernized and auditable Modelica implementation while preserving the validated physiological model line.

| Area | Current release |
|---|---|
| 🧬 **Modelica source** | Internationalized English identifiers and documented migration from legacy names |
| 🖼️ **Visual layer** | External SVG package/component icons referenced through portable `modelica://` URIs |
| 🫀 **Physiology** | Fetal, neonatal, child and adult cardiovascular–respiratory scenarios |
| ✅ **Quality** | Static source, physiological numeric-baseline and visual-resource integrity checks |
| 📚 **Documentation** | Installation, dependencies, model map, scientific validation and provenance |


---

## 🔬 Physiological scope

| Life stage | Main capabilities |
|---|---|
| 🤰 **Fetal** | Fetal circulation, placental oxygen exchange, umbilical circulation |
| 👶 **Neonatal** | Cardiovascular–respiratory physiology, oxygen transport, birth transition |
| 🧒 **Childhood** | Pediatric cardiovascular scenarios, healthy and stenosis cases |
| 🧑 **Adulthood** | Adult cardiovascular and respiratory physiology |

Canonical v2 scenarios include:

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

## 🏗️ Library architecture

The active package is organized into eight main namespaces:

| Package | Purpose |
|---|---|
| 🎨 `Icons` | Visual definitions used by physiological components |
| 🧩 `Components` | Reusable cardiovascular, respiratory and physiological building blocks |
| 📐 `Types` | Specialized quantities and data types |
| 🧍 `Scenarios` | Complete adult, child, neonatal and fetal models |
| 🔌 `Connectors` | Physiological flow and signal interfaces |
| 🧮 `Functions` | Hill-type and pulmonary/placental support functions |
| 📈 `Signals` | Elastance, respiration, vascular and transition signals |
| 📚 `UsersGuide` | Documentation, authorship and scientific information |

The graphical resources used by OMEdit are stored under `Resources/Images/icon/` and referenced through portable `modelica://PatientEvoPhysio/...` URIs.

---

## 🚀 Quick start

### Requirements

The validated v2.x environment is:

```text
OpenModelica 1.27.1 (validated release environment)
Modelica 3.2.3
Complex 3.2.3
ModelicaServices 3.2.3
Physiolibrary 2.3.1
```

> [!IMPORTANT]
> Recent OMEdit installations may automatically load Modelica 4.x. PatientEvoPhysio v2.0.0 is validated with the Modelica 3.2.x / Physiolibrary 2.3.1 stack. Avoid mixing that stack with ModelicaServices 4.x.

### Recommended OMEdit loading order

1. `Tools → Options → Libraries`.
2. Disable **Load latest Modelica version on startup**.
3. Restart OMEdit completely.
4. Load **Modelica 3.2.3** manually.
5. Open `PatientEvoPhysio.mo`.
6. Allow **Physiolibrary 2.3.1** to load.
7. Verify that Modelica/Complex/ModelicaServices are all from the 3.2.3 family.

### Clone

```bash
git clone https://github.com/ehsepulvedao/PatientEvoPhysio.git
cd PatientEvoPhysio
```

---

## ✅ Validation status

The stable v2 physiological line has been checked with OpenModelica 1.27.1 (64-bit), Modelica 3.2.3 and Physiolibrary 2.3.1.

Repository integrity checks cover:

- the Modelica source structure and canonical scenarios;
- preservation of the audited physiological numeric baseline;
- resolution of the active external SVG resources.

For installation-specific scientific validation, see:

- [`docs/SCIENTIFIC_VALIDATION.md`](docs/SCIENTIFIC_VALIDATION.md)
- [`docs/REPRODUCIBILITY.md`](docs/REPRODUCIBILITY.md)



---

## 📖 Scientific publications

PatientEvoPhysio and its underlying physiological models have been described and applied in the following work:

1. **Sepúlveda-Oviedo EH, Bermeo Clavijo LE, Méndez Córdoba LC.**
   *Effect of timing of umbilical cord clamping and birth on fetal to neonatal transition: OpenModelica-based virtual simulator-based approach.*
   **Biocybernetics and Biomedical Engineering.** 2024;44(3):716–730.
   DOI: `10.1016/j.bbe.2024.08.008`

2. **Sepúlveda-Oviedo EH, Bermeo Clavijo LE, Méndez Córdoba LC.**
   *OpenModelica-based virtual simulator for the cardiovascular and respiratory physiology of a neonate.*
   **Journal of Medical Engineering & Technology.** 2022;46(3):179–197.
   DOI: `10.1080/03091902.2022.2026500`

Additional scientific foundations are documented in `UsersGuide` and the project documentation.

---

## 📌 Citation

If you use PatientEvoPhysio, please cite the software and the scientific publication corresponding to the model/scenario used.

**Software DOI:** [10.5281/zenodo.10054996](https://doi.org/10.5281/zenodo.10054996)

A machine-readable citation is provided in [`CITATION.cff`](CITATION.cff).

---

## 👥 Authors, contributors and maintenance

PatientEvoPhysio was originally developed through the collaboration of the following authors and scientific contributors:

- **Edgar Hernando Sepúlveda-Oviedo** — original author and scientific contributor.
- **Leonardo Enrique Bermeo Clavijo** — original author and scientific contributor.
- **Luis Carlos Méndez-Córdoba** — original author and scientific contributor.

### Current project maintenance

**Edgar Hernando Sepúlveda-Oviedo**
PROMES-CNRS (UPR 8521), Perpignan, France
Université de Perpignan Via Domitia, Perpignan, France
Email: `edgar-hernando.sepulveda-oviedo@univ-perp.fr`

See [`AUTHORS.md`](AUTHORS.md) for detailed authorship, project roles and maintenance information.

---

## 🤝 Contributing

Bug reports, compatibility tests, physiological validation cases, documentation improvements and new scientifically justified scenarios are welcome. Please open an issue before major model changes so that numerical and physiological implications can be discussed explicitly.

---

## ⚖️ License

PatientEvoPhysio is released under the **Creative Commons CC0 1.0 Universal** public-domain dedication. See [`LICENSE`](LICENSE).

---

## ⚠️ Disclaimer

PatientEvoPhysio is research and educational software. It is **not a medical device** and is not intended for clinical diagnosis, treatment decisions or direct patient management.

---

<div align="center">

### 🫀 PatientEvoPhysio v2.1.0

**Mechanistic physiology · reproducible simulation · research-ready data**

If PatientEvoPhysio is useful to your work, consider ⭐ starring the repository.

</div>
