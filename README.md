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
[![Python checks](https://github.com/ehsepulvedao/PatientEvoPhysio/actions/workflows/python-checks.yml/badge.svg)](https://github.com/ehsepulvedao/PatientEvoPhysio/actions/workflows/python-checks.yml)

</div>

---

## What is PatientEvoPhysio?

**PatientEvoPhysio** is an open-source Modelica library for mechanistic simulation of human cardiovascular and respiratory physiology across the life cycle. It combines reusable physiological components with complete scenarios spanning **fetal life, neonatal transition, childhood and adulthood**.

The project is designed for research, reproducible simulation, teaching and synthetic-data generation where mechanistic interpretability matters. It includes healthy scenarios, congenital cardiovascular conditions, oxygen transport, altitude-dependent physiology and the fetal-to-neonatal transition.

> **v2.0.0 is the recommended stable release.** It modernizes the published simulator into a reproducible research-software and research-data platform while preserving the audited physiological parameterization of the validated v2 line.

---

## ✨ What is new in v2.0.0?

| Area | v2.0.0 |
|---|---|
| 🧬 **Modelica source** | Internationalized English identifiers and documented migration from legacy names |
| 🖼️ **Visual layer** | Redesigned external package/component icons; no active Base64 image payloads |
| ✅ **Validation** | Standard, extended and initialization-diagnostic workflows |
| 📊 **Research data** | Curated CSV generation, metadata, provenance and validation reports |
| 🔬 **Scientific reports** | Pressure, volume, oxygen, valve-event and P–V metrics |
| 🤖 **AI / diagnosis** | Diagnostic benchmark tables and time-series indexes |
| 🔀 **Hybrid discovery** | Derived cardiac-mode labels for mode-dependent system identification |
| 📦 **Dataset release** | File index, variable dictionary, QA summary, checksums and deposit-ready packaging |
| 🧪 **Reproducibility** | Portable Windows/OpenModelica runners and GitHub static checks |

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

The validated v2.0.0 environment is:

```text
OpenModelica 1.27.1 (validated release environment)
Modelica 3.2.3
Complex 3.2.3
ModelicaServices 3.2.3
Physiolibrary 2.3.1
Python 3.9+ (optional data-generation utilities)
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

The stable release is based on the RC6/RC7 validation campaign performed with OpenModelica 1.27.1 (64-bit):

- **9/9 short scenarios** completed the standard workflow;
- **0 files requiring review** in the standard validation run;
- initialization diagnostics completed successfully;
- **600 s neonatal oxygen** workflow completed with zero review flags;
- **720 s fetal-to-neonatal transition** workflow completed with zero review flags;
- extended-profile validation reported **2/2 profiles passed**.

For a fresh installation, run:

```bat
RUN_STANDARD_VALIDATION.bat
RUN_EXTENDED_VALIDATION.bat
```

For the full publication-oriented workflow:

```bat
RUN_FULL_PUBLICATION_PIPELINE.bat
```

The validation system intentionally separates broad numerical/engineering sanity checks from scientific interpretation. See `docs/QUALITY_ASSURANCE.md`, `docs/SCIENTIFIC_VALIDATION.md` and `docs/VALIDATION_BASELINE.md`.

---

## 📊 Generate research datasets

PatientEvoPhysio v2.0.0 can generate article-ready, traceable simulation datasets instead of only interactive OMEdit results.

### Main one-click workflows

```bat
RUN_DATA_ARTICLE_REFERENCE.bat
RUN_DIAGNOSIS_BENCHMARK_DATA.bat
RUN_HYBRID_DISCOVERY_DATA.bat
RUN_OXYGEN_BENCHMARK_DATA.bat
RUN_ALL_PUBLICATION_DATA.bat
```

Each run can produce:

```text
curated CSV
metadata.json
validation.json
validation.details.json
scientific_summary.json / .csv / .md
quality figures (SVG)
run.mos
OpenModelica log
```

Publication-scale generated data are **not committed to GitHub**. The repository contains the model, generation recipes and QA infrastructure; released datasets should be deposited separately and linked by DOI.

---

## 🧠 Research workflows enabled by v2

### Data article / reusable physiological dataset

The repository can build a deposit-ready package containing file indexes, variable dictionaries, provenance, checksums and quality-control reports. See `docs/data_in_brief/` and `docs/PUBLICATION_WORKFLOWS.md`.

### Diagnostic AI benchmark

Healthy and pathological scenarios can be converted into curated time-series benchmarks and derived feature tables for supervised diagnosis studies.

### Hybrid / symbolic system discovery

The workflow can derive valve-based cardiac phase labels such as filling, isovolumetric contraction, ejection and isovolumetric relaxation, supporting Hybrid-SINDy and symbolic-regression studies.

### Virtual populations

`generate_population.py` supports deterministic virtual cohorts and Latin-hypercube designs. Physiological parameter bounds are intentionally **not invented by the software**; they must be supplied from defensible scientific sources.

---

## 📁 Repository structure

```text
PatientEvoPhysio.mo          active Modelica package
Resources/Images/icon/       active graphical assets
config/                      scenarios and experiment definitions
scripts/                     simulation, QA and packaging utilities
tests/                       static/reproducibility tests
docs/                        scientific and software documentation
data/generated/              generated locally; ignored by Git
release/                     generated dataset release packages; ignored by Git
```

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

## 👥 Maintainer and contributors

### Maintainer / release manager

**Edgar Hernando Sepúlveda-Oviedo**
PROMES-CNRS (UPR 8521), Perpignan, France
Université de Perpignan Via Domitia, Perpignan, France
Email: `edgar-hernando.sepulveda-oviedo@univ-perp.fr`

### Original contributors

**Leonardo Bermeo Clavijo** — Universidad Nacional de Colombia
**Luis Carlos Méndez-Córdoba** — Universidad Nacional de Colombia / Instituto Materno Infantil – Hospital La Victoria

See [`AUTHORS.md`](AUTHORS.md) for details.

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

### 🫀 PatientEvoPhysio v2.0.0

**Mechanistic physiology · reproducible simulation · research-ready data**

If PatientEvoPhysio is useful to your work, consider ⭐ starring the repository.

</div>
