In `QFeatures` we can use the `normalize` function to apply normalisation. To
see which methods are supported, type `?normalize` to access the function's
help page.

Of the supported methods, median-based methods work well for most quantitative
proteomics data. Unlike mean-based methods, median-based normalisation is less
sensitive to the extreme values and outliers that are commonly present in
proteomics datasets, making it a more robust choice for correcting sample-level
systematic differences in loading or ionisation efficiency.

Median-based normalisation works by calculating a single correction factor per
sample — the difference between that sample's median abundance and a reference
value — and applying it as a constant shift to every protein in that sample.
This means all proteins in a given sample are shifted by the same amount,
preserving the relative differences between proteins within each sample while
bringing the overall distributions into alignment across samples.
