# Dependencies and OpenModelica bootstrap

## Validated target stack

PatientEvoPhysio v2.0.0 was validated with:

- OpenModelica 1.27.1 (64-bit);
- Modelica 3.2.3;
- Complex 3.2.3;
- ModelicaServices 3.2.3;
- Physiolibrary 2.3.1.

`PatientEvoPhysio.mo` correctly declares only its direct Modelica-library dependencies:

```modelica
uses(
  Modelica(version = "3.2.3"),
  Physiolibrary(version = "2.3.1"))
```

`Complex` and `ModelicaServices` belong to the resolved Modelica 3.2.3 dependency stack and therefore are not duplicated as direct `uses(...)` entries in PatientEvoPhysio.

## What `uses(...)` does — and does not do

The Modelica `uses(...)` annotation tells a Modelica tool which dependency versions a package requires. OpenModelica uses it to automatically select and load compatible dependencies that are already installed in `MODELICAPATH`.

A Modelica source file is not supposed to execute package installation as a side effect of being opened. Missing public libraries are installed through OpenModelica's Package Manager. This repository therefore provides a separate canonical bootstrap script.

## Automatic installation on a fresh OpenModelica setup

From the repository root, run:

```text
omc InstallPatientEvoPhysioDependencies.mos
```

On Windows, the recommended one-click entry point is:

```text
INSTALL_DEPENDENCIES_WINDOWS.bat
```

The bootstrap performs the following sequence:

1. updates the OpenModelica package index;
2. installs a Modelica 3.2.3-compatible release;
3. installs the Complex 3.2.3-compatible dependency;
4. installs the ModelicaServices 3.2.3-compatible dependency;
5. installs exactly Physiolibrary 2.3.1;
6. clears the compiler session and loads Modelica 3.2.3 and Physiolibrary 2.3.1;
7. loads `PatientEvoPhysio.mo` to verify that dependency resolution succeeds.

Any installation or verification failure exits with a non-zero status instead of reporting a false success.

`scripts/bootstrap.mos` is intentionally only a compatibility wrapper around the canonical root installer so the repository has one dependency-installation implementation rather than two divergent copies.

## OMEdit startup conflict with Modelica 4.x

Some recent OMEdit configurations force-load the newest Modelica Standard Library when OMEdit starts. Because PatientEvoPhysio v2.0.0 is a validated Modelica 3.2.3 / Physiolibrary 2.3.1 release, an already loaded Modelica 4.x session can prevent the requested stack from being selected.

After the dependency bootstrap completes:

1. close OMEdit completely;
2. restart OMEdit;
3. if Modelica 4.x is still loaded automatically, open `Tools → Options → Libraries`;
4. disable loading the latest Modelica version on startup (and remove any explicit Modelica 4.x startup entry if present);
5. restart OMEdit again;
6. open `PatientEvoPhysio.mo`.

At that point the package `uses(...)` annotation can select and load the installed 3.2.3-family dependencies and Physiolibrary 2.3.1.
