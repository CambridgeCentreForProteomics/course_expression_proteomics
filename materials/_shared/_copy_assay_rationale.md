As with all data analyses, it is sensible to keep a copy of the data before
applying filters, in case we need to refer back to the unfiltered data later.
We therefore extract a copy of the assay using `addAssay`, giving it a new name
that reflects the processing step we are about to apply. We will only apply
filters to this new copy, leaving the original assay untouched.

::: {.callout-note}
#### Assay links
`QFeatures` maintains hierarchical links between quantitative levels, allowing
easy access to all data levels for individual features of interest. This is
fundamental to the `QFeatures` infrastructure and will be exemplified
throughout this course. When using `addAssay` to add a copy of an existing
assay, the newly created `SummarizedExperiment` does not automatically have a
link to the assay it was copied from. Where a link is required, it can be added
explicitly using `addAssayLink`.
:::
