# Dependencies and OMEdit loading order

## Target stack

- Modelica Standard Library 3.2.3
- Physiolibrary 2.3.1
- OpenModelica / OMEdit compatible with those libraries

Physiolibrary 2.3.1 internally requests an earlier 3.2.x Modelica release. In the user's OpenModelica environment, Modelica 3.2.3 is reported by OMEdit as fully compatible with that request and is the selected v2 target.

## OMEdit startup conflict

A reproducible conflict was observed when OMEdit automatically loaded Modelica 4.x before PatientEvoPhysio. The solution is:

1. `Tools → Options → Libraries`;
2. disable loading of the latest Modelica version on startup;
3. remove auto-start Modelica from the startup library list if present;
4. restart OMEdit;
5. manually load Modelica 3.2.3;
6. open `PatientEvoPhysio.mo`;
7. allow Physiolibrary 2.3.1 to load from the `uses(...)` annotation.

The README repeats this sequence prominently because otherwise a valid PatientEvoPhysio file can appear to fail before the model is even checked.
