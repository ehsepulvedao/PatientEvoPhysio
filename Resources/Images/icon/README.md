# Active PatientEvoPhysio SVG icons

This directory contains the **26 active SVG graphical resources** used by PatientEvoPhysio v2.0.0.

These files are part of the user-facing graphical layer shown in OMEdit and are referenced directly from `PatientEvoPhysio.mo`.

## Naming convention

The current file-name prefixes indicate the role of each resource:

- `icons_*.svg` — reusable component-level icons;
- `package_*.svg` — package-level icons;
- `scenario_*.svg` — life-stage/scenario icons;
- `signals_*.svg` — signal-package icons;
- `usersguide_*.svg` — UsersGuide section icons.

The filenames are intentionally stable because they are referenced by portable `modelica://PatientEvoPhysio/...` URIs in the Modelica source.

## Editing or replacing an icon

When updating an icon:

1. Keep the existing filename whenever the semantic role is unchanged.
2. Keep the final asset in SVG format.
3. Use a transparent background.
4. Keep the composition simple enough to remain recognizable at small size.
5. Prefer a centered, compact composition and strong visual contrast.
6. Avoid unnecessary text or decorative detail.
7. Preserve the intended visual proportions used by the existing Modelica annotation.
8. If the filename or path must change, update `PatientEvoPhysio.mo` and `docs/ICON_ASSET_MAP.csv` in the same commit.
9. Do not add a parallel PNG version to this active directory.
10. Do not embed the image directly into the `.mo` file as Base64.

## Validation

Run the visual-resource test after any change:

```bash
python tests/test_visual_assets.py
```

For PatientEvoPhysio v2.0.0 the expected result is:

```text
[PASS] Visual assets: 26 portable references validated; 26 active icons are SVG-only
```

This directory should therefore contain the active SVG resources plus this documentation file, and no active PNG icon set.
