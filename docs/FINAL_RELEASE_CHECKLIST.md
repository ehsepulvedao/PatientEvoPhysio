# Final v2.0.0 release checklist

Before converting RC7 into stable `v2.0.0`:

- [ ] Run `RUN_FULL_PUBLICATION_PIPELINE.bat` on the target Windows/OpenModelica installation.
- [ ] Confirm standard validation: 9 curated CSVs, 0 REVIEW.
- [ ] Confirm initialization diagnostic matches the documented baseline or explain any change.
- [ ] Confirm extended validation: 2 curated CSVs, 0 REVIEW.
- [ ] Confirm publication reference plans complete without errors.
- [ ] Review `data/quality/quality_report.md`.
- [ ] Confirm all generated runs use one expected PatientEvoPhysio model SHA-256.
- [ ] Inspect representative SVG figures and scientific summaries.
- [ ] Confirm no personal absolute paths appear in public metadata/dataset-release files.
- [ ] Run `python scripts/check_placeholders.py` and intentionally resolve any manuscript placeholders before journal submission.
- [ ] Update `VERSION`, `CITATION.cff`, `MANIFEST.json`, release notes and Modelica package annotation from `2.0.0-rc.7` to `2.0.0` only after the final run passes.
- [ ] Create Git tag `v2.0.0` and GitHub release.
- [ ] Archive the exact release and dataset in the selected persistent repository.
- [ ] Record the final software DOI/version DOI and dataset DOI in manuscript/repository metadata.
