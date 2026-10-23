# GitHub release plan

1. Review `README.md`, `CHANGELOG.md`, and `RELEASE_NOTES.md`.
2. Run `RUN_FULL_PUBLICATION_PIPELINE.bat` on Windows.
3. Inspect `release/` outputs and dataset QA summaries.
4. Commit all source files except generated build artifacts.
5. Tag the repository as `v2.0.0`.
6. Create a GitHub release and attach the release ZIP/checksum if desired.
7. Optionally archive the release with Zenodo.
8. Deposit the curated dataset in Mendeley Data or CNRS Data depending on size.
