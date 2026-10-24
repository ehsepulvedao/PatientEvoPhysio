# PatientEvoPhysio graphical resources

This directory contains the external graphical resources used by the active PatientEvoPhysio Modelica package.

## Active assets

The active OMEdit/package icons are stored in:

```text
Resources/Images/icon/
```

PatientEvoPhysio v2.0.0 uses external **SVG** resources for the active graphical layer. The Modelica source references these files through portable URIs such as:

```modelica
modelica://PatientEvoPhysio/Resources/Images/icon/scenario_neonate.svg
```

Keeping the graphics external makes `PatientEvoPhysio.mo` substantially easier to review and maintain and avoids active Base64 image payloads inside the Modelica source.

## Maintenance rules

- Keep active package/component graphics in `Resources/Images/icon/`.
- Use SVG as the active distribution format.
- Do not rename or move an active icon without updating the corresponding URI in `PatientEvoPhysio.mo`.
- Keep artwork readable at small OMEdit tree-view sizes.
- Prefer simple silhouettes, strong contrast and transparent backgrounds.
- Avoid adding text inside icons unless it is scientifically necessary.
- Do not re-embed active graphics as Base64 payloads in the Modelica source.
- When replacing an icon, preserve its intended visual proportions so existing Modelica diagrams remain balanced.

The mapping between Modelica elements and graphical resources is documented in:

```text
docs/ICON_ASSET_MAP.csv
```

## Validation

After changing graphical resources, run:

```bash
python tests/test_visual_assets.py
```

The test verifies that all active graphical references resolve correctly and that the active icon set remains SVG-only.
