To remove features based on variables within our `rowData` we make use of the
**`filterFeatures`** function. This function takes a `QFeatures` object as its
input and filters it against a condition based on the `rowData` (indicated by
the `~` operator). If the condition evaluates to `TRUE` for a feature, that
feature will be kept; features returning `FALSE` are removed.

The `filterFeatures` function provides the option to apply a filter either (i)
to the whole `QFeatures` object and all of its `SummarizedExperiment`s, or (ii)
to specific `SummarizedExperiment`s within the `QFeatures` object, by passing
the name or index of the desired set to the `i` argument.
