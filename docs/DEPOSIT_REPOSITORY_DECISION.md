# Dataset repository decision guide

This project separates **code**, **simulation outputs**, and **dataset releases**.

## Recommended strategy

- **GitHub repository**: source code, Modelica package, Python/Windows scripts, documentation, issue tracking.
- **Release DOI (optional but recommended)**: create a GitHub release and archive it with **Zenodo**.
- **Curated dataset for article submission**:
  - use **Mendeley Data** when the curated dataset is moderate in size and directly tied to the article submission workflow;
  - use a **CNRS / institutional repository** when the dataset becomes large, when multiple releases are expected, or when institutional preservation is preferred.

## Practical rule

- **Small / moderate curated article dataset** -> Mendeley Data
- **Large / multi-release / institutional dataset** -> CNRS Data / institutional repository

## Recommended release split

1. **Code release**
   - GitHub + tag `v2.0.0`
   - optional Zenodo DOI
2. **Curated dataset release**
   - article-facing dataset only
   - includes CSV/metadata/QA/variable dictionary/provenance/checksums
3. **Extended or raw simulation archive**
   - institutional repository if size is large

## Data in Brief note

The package contains a prepared `docs/data_in_brief/` workflow. Before submission, confirm the repository URL/DOI and the journal scope for simulated data.
