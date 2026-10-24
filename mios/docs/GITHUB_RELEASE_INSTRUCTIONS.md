# Publishing PatientEvoPhysio v2.0.0 on GitHub

The current public repository should be preserved as the historical v1 state, then `main` should be updated to the v2.0.0 tree.

## 1. Clone the existing repository

```bash
git clone https://github.com/ehsepulvedao/PatientEvoPhysio.git
cd PatientEvoPhysio
```

## 2. Tag the current historical state before replacing files

The current `main` head observed on 2026-10-23 was:

```text
c40e1994bcc9992c84ee7e1b150dc7ee3ba3ba64
```

Tag it before the v2 commit:

```bash
git tag -a v1.0.0-legacy c40e1994bcc9992c84ee7e1b150dc7ee3ba3ba64 -m "PatientEvoPhysio legacy public release"
git push origin v1.0.0-legacy
```

## 3. Create a release branch

```bash
git checkout -b release/v2.0.0
```

Copy the contents of the provided `PatientEvoPhysio-v2.0.0` folder into the cloned repository root **without deleting the hidden `.git/` directory**.

Do not copy generated datasets from previous runs. The supplied `.gitignore` already excludes `data/generated/`, `data/analysis/`, `data/quality/`, `data/diagnostics/`, `build/` and `release/` outputs.

## 4. Review the changes

```bash
git status
git diff --stat
```

Then commit:

```bash
git add -A
git commit -m "Release PatientEvoPhysio v2.0.0"
git push -u origin release/v2.0.0
```

## 5. Merge into main

Open a pull request from `release/v2.0.0` to `main`, verify GitHub Actions, and merge it. For a personal repository, a squash merge is a clean option.

After merge:

```bash
git checkout main
git pull origin main
```

## 6. Tag the stable version

```bash
git tag -a v2.0.0 -m "PatientEvoPhysio v2.0.0 stable release"
git push origin v2.0.0
```

## 7. Create the GitHub Release

On GitHub:

1. Open **Releases**.
2. Choose **Draft a new release**.
3. Select tag `v2.0.0`.
4. Set the release title to `PatientEvoPhysio v2.0.0`.
5. Paste or adapt `RELEASE_NOTES.md` as the release description.
6. Mark it as **Latest release**.
7. Publish.

Once `main` contains v2.0.0 and the release is marked Latest, visitors will naturally see v2 as the current recommended version while `v1.0.0-legacy` remains recoverable from Git history/tags.

## 8. Zenodo / software DOI

If the existing Zenodo software record is managed as a versioned record, create a **new version** for v2.0.0 rather than an unrelated duplicate record. Upload the v2.0.0 release archive and update the repository metadata. Keep the software DOI information in `CITATION.cff` and the README synchronized with the DOI actually assigned by Zenodo.

## 9. Publication datasets

Do not put article-scale generated CSVs into the Git repository. Deposit curated releases separately (e.g. Mendeley Data for a moderate article dataset or an institutional/CNRS repository for larger archives) and cite/link the dataset DOI from the article and, when appropriate, from the GitHub release.
