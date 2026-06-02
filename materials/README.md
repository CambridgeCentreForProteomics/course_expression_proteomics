# materials/

This directory contains the Rmd notebooks that are rendered into the course website.

## Why data files are duplicated here

The raw data files in `materials/tmt/data/` and `materials/dia/data/` are copies of the files in `course_files/tmt/data/` and `course_files/dia/data/` respectively.

The duplication exists because the data needs to be accessible in two different contexts:

- **`course_files/*/data/`** — used by participants who have `course_files/` set up for them on their local machine and run the R scripts, which use plain `"data/..."` relative paths from within the `course_files/tmt/` or `course_files/dia/` directories.
- **`materials/*/data/`** — used by the rendered notebooks, where Quarto sets the working directory to the notebook's location (`materials/tmt/` or `materials/dia/`), so the same `"data/..."` relative paths resolve here instead.

Symlinks were considered but avoided because git symlink support on Windows is unreliable.
