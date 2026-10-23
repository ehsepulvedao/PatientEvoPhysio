<div align="center">

# 🫀 PatientEvoPhysio

### Open-source Modelica library for human cardiovascular and respiratory physiology

**From fetal life to adulthood — computational physiology in Modelica**

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.10054996.svg)](https://doi.org/10.5281/zenodo.10054996)
![Modelica](https://img.shields.io/badge/Modelica-3.2.3-blue)
![Physiolibrary](https://img.shields.io/badge/Physiolibrary-2.3.1-green)
![License](https://img.shields.io/badge/License-CC0%201.0-lightgrey)
![GitHub last commit](https://img.shields.io/github/last-commit/ehsepulvedao/PatientEvoPhysio)

</div>

---

## 🧬 About PatientEvoPhysio

**PatientEvoPhysio** is an open-source Modelica library designed to simulate and study human **cardiovascular and respiratory physiology across different stages of life**, from fetal and neonatal life to childhood and adulthood.

The library provides reusable physiological components and complete simulation scenarios for studying:

- 🫀 cardiovascular dynamics;
- 🫁 respiratory physiology;
- 👶 fetal-to-neonatal transition;
- 🩺 cardiovascular and respiratory anomalies;
- ✂️ clinical practices such as umbilical cord clamping;
- 🌍 physiological responses under different physical and environmental conditions.

PatientEvoPhysio was developed to support **research, simulation and education** in situations where experimental investigation in living subjects may be difficult or ethically constrained.

The library builds upon concepts and components from **Physiolibrary 2.3.1** and extends them with models specifically developed for multistage human physiological simulation.

📌 **Software DOI:** [10.5281/zenodo.10054996](https://doi.org/10.5281/zenodo.10054996)

---

## 🔬 What can you model?

PatientEvoPhysio contains physiological scenarios organized according to four major life stages:

| Life stage | Available framework |
|---|---|
| 🤰 **Fetal** | Cardiovascular and oxygen transport physiology |
| 👶 **Neonatal** | Cardiovascular–respiratory physiology and birth transition |
| 🧒 **Childhood** | Pediatric physiological scenarios |
| 🧑 **Adulthood** | Adult cardiovascular and respiratory scenarios |

The modular structure allows individual components to be combined to build new physiological scenarios and investigate different clinical or physiological conditions.

---

## 🏗️ Library architecture

The internal structure of PatientEvoPhysio is organized into **eight main packages**:

![PatientEvoPhysio library architecture](https://github.com/ehsepulvedao/PatientEvoPhysio/assets/7245709/b984a87f-c5c8-4d01-8544-f79505e25cea)

| Package | Description |
|---|---|
| 🎨 **Icons** | Graphical icons used by the physiological components. |
| 🧩 **Components** | Reusable cardiovascular, respiratory and physiological components used to assemble simulation scenarios. |
| 📐 **Types** | Specialized data types derived from Modelica primitive types. |
| 🧍 **Scenarios** | Complete physiological models organized into adult, childhood, neonatal and fetal scenarios. |
| 🔌 **Connectors** | Interfaces that enable communication between the internal variables of physiological components. |
| 🧮 **Functions** | Mathematical functions including Hill and inverse Hill equations and pulmonary or placental gas-exchange relationships. |
| 📈 **Signals** | Components describing time-varying physiological behavior such as ventricular elastance, respiration, placental respiration and foramen ovale dynamics. |
| 📚 **UsersGuide** | Documentation, acknowledgements, authorship and scientific information associated with the library. |

---

## 🖥️ Library overview

![PatientEvoPhysio overview](https://github.com/ehsepulvedao/PatientEvoPhysio/assets/7245709/967f427d-3f07-4a28-b29f-1e0a24ae1af4)

PatientEvoPhysio follows a modular approach: physiological components can be interconnected through dedicated connectors to reproduce complex cardiovascular and respiratory systems while preserving physiological interpretability.

---

## 🚀 Installation

### Requirements

PatientEvoPhysio currently relies on:

- **Modelica 3.2.3**
- **Physiolibrary 2.3.1**
- A Modelica-compatible modeling and simulation environment, such as:
  - [OpenModelica](https://openmodelica.org/)
  - [Dymola](https://www.3ds.com/products/catia/dymola)

### Installation steps

1. Download or clone this repository:

```bash
git clone https://github.com/ehsepulvedao/PatientEvoPhysio.git
```

2. Install **Physiolibrary 2.3.1** in your Modelica environment.

3. Open the file:

```text
PatientEvoPhysio.mo
```

4. Load `PatientEvoPhysio` as a Modelica library.

5. Explore the available models under:

```text
PatientEvoPhysio.Scenarios
```

You can then select a physiological scenario, configure its parameters and run the simulation from your preferred Modelica environment.

---

## 🎯 Example applications

PatientEvoPhysio has been used to investigate physiological questions including:

### Fetal-to-neonatal transition

Simulation of the cardiovascular and respiratory changes occurring during birth, including the transition from placental to pulmonary gas exchange.

### Umbilical cord clamping

Evaluation of different timings of umbilical cord clamping and their influence on neonatal cardiovascular adaptation.

### Neonatal cardiovascular and respiratory physiology

Simulation of coupled cardiovascular and respiratory dynamics in neonates under different physiological and environmental conditions.

---

## 📖 Scientific publications

PatientEvoPhysio and its underlying physiological models have been described and applied in several scientific studies.

### Main publications

1. **Sepúlveda-Oviedo EH, Bermeo Clavijo LE, Méndez Córdoba LC.**  
   *Effect of timing of umbilical cord clamping and birth on fetal to neonatal transition: OpenModelica-based virtual simulator-based approach.*  
   **Biocybernetics and Biomedical Engineering.** 2024;44(3):716–730.

2. **Sepúlveda-Oviedo EH, Bermeo Clavijo LE, Méndez Córdoba LC.**  
   *OpenModelica-based virtual simulator for the cardiovascular and respiratory physiology of a neonate.*  
   **Journal of Medical Engineering & Technology.** 2022;46(3):179–197.

3. **Sepúlveda-Oviedo EH, Bermeo L, Méndez L.**  
   *Desarrollo de una herramienta de simulación cardiovascular neonatal para la enseñanza y la investigación.*  
   XLVI Congresso Brasileiro de Educação em Engenharia (COBENGE) and 1º Simpósio Internacional de Educação em Engenharia da ABENGE, Salvador, Brazil, 2018.

4. **Sepúlveda-Oviedo EH.**  
   *Estudio de la práctica del pinzamiento del cordón umbilical usando análisis computacional de la información bibliográfica, modelos de eventos discretos y modelos dinámicos.*  
   Master's thesis, Universidad Nacional de Colombia, 2019.

<details>
<summary><strong>📚 Scientific foundations and additional references</strong></summary>

<br>

- Yigit MB, Kowalski WJ, Hutchon DJR, Pekkana K. *Transition from fetal to neonatal circulation: Modeling the effect of umbilical cord clamping.* Journal of Biomechanics. 2015;48(9):1662–1670.

- Hoppensteadt F, Peskin C. *Modeling and Simulation in Medicine and the Life Sciences.* 2nd ed. Springer; 2002.

- Goodwin J, van Meurs W, Sá-Couto C, Beneken J, Graves S. *A model for educational simulation of infant cardiovascular physiology.* Anesthesia & Analgesia. 2004;99(6):1655–1664.

- Sá-Couto P, Van Meurs W, Bernardes J, Marques de Sá J, Goodwin J. *Mathematical model for educational simulation of oxygen delivery to the fetus.* 2002;10(1):59–66.

- Sá-Couto CD, van Meurs WL, Goodwin JA, Andriessen P. *A model for educational simulation of neonatal cardiovascular pathophysiology.* 2006;1:4–9.

- Serov A, Salafia C, Filoche M, Grebenkov D. *Analytical theory of oxygen transport in the human placenta.* Journal of Theoretical Biology. 2015;368:133–144.

- Mateják M, Kofránek J. *Physiomodel — an integrative physiology in Modelica.* Conf Proc IEEE Eng Med Biol Soc. 2015:1464–1467.

- Huikeshoven F, Coleman T, Jongsma H. *Mathematical model of the fetal cardiovascular system: the uncontrolled case.* American Journal of Physiology. 1980;239(3):R317–R325.

- Koch G. *Alveolar ventilation, diffusing capacity and the A-a PO₂ difference in the newborn infant.* Respiration Physiology. 1968;4(2):168–192.

- Guyton A. *Textbook of Medical Physiology.* 8th ed. W.B. Saunders Company; 1991.

- Graham T, Jarmakani M. *Evaluation of ventricular function in infants and children.* Pediatric Clinics of North America. 1971;18(4):1109–1132.

- Paul A, Das S. *Valvular heart disease and anaesthesia.* Indian Journal of Anaesthesia. 2017;61(9):721–727.

- Avery G, Fletcher M, MacDonald M. *Neonatology: Pathophysiology and Management of the Newborn.* 5th ed. Lippincott Williams & Wilkins; 1999.

</details>

---

## 📌 How to cite PatientEvoPhysio

If you use **PatientEvoPhysio** in research, teaching or scientific software development, please cite the software repository using its DOI:

> **PatientEvoPhysio — Open-source Modelica library for human cardiovascular and respiratory physiology.**  
> DOI: [10.5281/zenodo.10054996](https://doi.org/10.5281/zenodo.10054996)

Please also cite the relevant scientific publication(s) associated with the physiological model or scenario used in your work.

---

## 👥 Development and contributors

### Release manager

**Edgar Hernando Sepúlveda-Oviedo**  
[ResearchGate](https://www.researchgate.net/profile/Edgar-Sepulveda-Oviedo)

Laboratory for Analysis and Architecture of Systems (LAAS-CNRS), Toulouse, France.

### Contributors

**Leonardo Bermeo Clavijo**  
[ResearchGate](https://www.researchgate.net/profile/Leonardo-Bermeo)

Universidad Nacional de Colombia, Facultad de Ingeniería, Departamento de Ingeniería Eléctrica y Electrónica, Bogotá, Colombia.

**Luis Carlos Méndez-Córdoba**  
[ResearchGate](https://www.researchgate.net/profile/Luis-Mendez-Cordoba)

Universidad Nacional de Colombia / Instituto Materno Infantil – Hospital La Victoria, Bogotá, Colombia.

---

## 🤝 Contributing

Contributions that improve the physiological models, documentation, simulation scenarios or compatibility of PatientEvoPhysio are welcome.

You can contribute by:

- reporting bugs or unexpected simulation behavior;
- proposing new physiological components;
- adding or extending clinical scenarios;
- improving documentation;
- testing compatibility with Modelica environments;
- proposing validation cases or physiological datasets.

For major changes, please open an issue first to discuss the proposed contribution.

---

## 🐛 Issues

Found a problem or have a suggestion?

Please use the **GitHub Issues** section of this repository whenever possible.

You may also contact:

- **Edgar Hernando Sepúlveda-Oviedo:** ehsepulved@laas.fr
- **Leonardo Bermeo Clavijo:** lbermeoc@unal.edu.co

---

## 🗺️ Roadmap

Future developments of PatientEvoPhysio aim to extend its physiological scenarios, improve model validation and facilitate its integration into virtual laboratories and educational environments.

The library is also associated with the **VirtualLabUN** initiative of the Universidad Nacional de Colombia.

---

## ⚖️ License

PatientEvoPhysio is released under the **Creative Commons CC0 1.0 Universal** public-domain dedication.

This allows the software to be reused, modified and redistributed with minimal restrictions.

See the [`LICENSE`](LICENSE) file for the complete terms.

---

## ⚠️ Disclaimer

PatientEvoPhysio is intended for **research, education and computational simulation**.

The models provided in this repository are not medical devices and are **not intended for clinical diagnosis, treatment decisions or direct patient management**.

---

<div align="center">

### 🫀 PatientEvoPhysio

**Computational physiology across the human life cycle**

If this project is useful for your research, consider ⭐ starring the repository.

</div>
