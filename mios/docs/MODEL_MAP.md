# Model map

PatientEvoPhysio contains eight top-level conceptual packages:

- `Icons` — graphical representation of model components;
- `Components` — reusable hydraulic/physiological elements;
- `Types` — domain-specific Modelica types;
- `Scenarios` — complete adult, child, neonatal and fetal models;
- `Connectors` — pressure/flow/oxygen transport interfaces;
- `Functions` — oxygen/Hill/pulmonary/placental helper functions;
- `Signals` — time-varying elastance, respiration and transition signals;
- `UsersGuide` — authorship/contact/scientific documentation.

The canonical scenario paths used by automation are stored in `config/scenarios.json`. Keep that file synchronized whenever scenario classes are renamed or added.
