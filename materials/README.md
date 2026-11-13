# materials/

This directory contains the Rmd notebooks that are rendered into the course website.

## Where the data files live

The raw data files are stored once, in `course_files/tmt/data/` and `course_files/dia/data/`.

Each notebook's setup chunk sets the knitr root directory with `knitr::opts_knit$set(root.dir = here::here("course_files/dia"))` (or `course_files/tmt`). The rendered notebooks and the participant R scripts in `course_files/` therefore read the data with the same plain `"data/..."` relative paths.
