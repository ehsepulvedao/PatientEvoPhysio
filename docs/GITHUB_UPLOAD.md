# GitHub upload / repository update

This package is designed to replace the engineering contents of the existing PatientEvoPhysio repository while preserving Git history.

Recommended workflow:

1. Create a branch such as `release/v2.0.0` from the current repository.
2. Preserve/tag the historical v1 state before replacing files if it has not already been tagged.
3. Copy the contents of this package to the repository root.
4. Run the complete validation workflow.
5. Commit the RC7 package and open/review the release branch.
6. After final validation, update the version strings to stable `2.0.0`, merge and create the `v2.0.0` tag/release.

Do not commit generated `data/`, `build/` or `release/` products; `.gitignore` is configured to keep those local while retaining `.gitkeep` placeholders.
