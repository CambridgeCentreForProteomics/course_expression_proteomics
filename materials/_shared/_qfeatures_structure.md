## The structure of a `SummarizedExperiment`

To simplify the storage of quantitative proteomics data we can store the data as
a [`SummarizedExperiment`](https://bioconductor.org/packages/release/bioc/html/SummarizedExperiment.html)
object (as shown in @fig-summarized-experiment). `SummarizedExperiment` objects
can be conceptualised as data containers made up of three different parts:

1. The `assay` - a matrix which contains the quantitative data from a proteomics
experiment. Each row represents a feature (a precursor, peptide or protein) and
each column contains the quantitative data (measurements) from one experimental
sample.

2. The `rowData` - a table (data frame) which contains all remaining
information associated with each feature (i.e. every column from your search
output that was not a quantification column). Rows represent features but
columns inform about different attributes of the feature (e.g., its sequence,
name, modifications).

3. The `colData` - a table (data frame) to store sample metadata that would not
appear in the output of your search software. This could be, for example, the
condition, replicate, or batch each sample belongs to. Again, this information
is stored in a matrix-like data structure.

Finally, there is also an additional container called `metadata` which is a
place for users to store experimental metadata, such as which instrument the
samples were run on or the date of data acquisition. We will focus on
populating and understanding the three main containers above.

```{r fig-summarized-experiment, echo = FALSE, fig.cap = "Diagramatic representation of the structure of a `SummarizedExperiment` object in R (modified from the SummarizedExperiment package)", fig.align = "center", out.width = "90%"}
knitr::include_graphics("../_shared/figs/summarized-experiment-modified.png", error = FALSE)
```

Data stored in these three main areas can be easily accessed using the `assay()`,
`rowData()` and `colData()` functions, as we will see later.


## The structure of a `QFeatures` object

Whilst a `SummarizedExperiment` is able to neatly store quantitative proteomics
data at a single data level (i.e., precursor, peptide or protein), a typical
data analysis workflow requires us to look across multiple levels. For example,
it is common to start an analysis at a lower data level and then aggregate
upward towards a final protein-level dataset. Doing this allows for greater
flexibility and understanding of the processes required to clean and aggregate
the data.

A [`QFeatures`](https://bioconductor.org/packages/release/bioc/html/QFeatures.html)
object is essentially a list of `SummarizedExperiment` objects. However, the
main benefit of using a `QFeatures` object over storing each data level as an
independent `SummarizedExperiment` is that the `QFeatures` infrastructure
maintains explicit links between the `SummarizedExperiment`s that it stores.
This allows for maximum traceability when processing data across multiple levels
— for example, tracking which precursors or peptides contribute to each protein
(@fig-qfeatures, modified from the [`QFeatures` vignette](https://bioconductor.org/packages/release/bioc/vignettes/QFeatures/inst/doc/QFeatures.html)
with permission).

```{r fig-qfeatures, echo = FALSE, fig.cap = "Graphic representation of the explicit links between data levels when stored in a `QFeatures` object.", fig.align = "center", out.width = "90%"}
knitr::include_graphics("../_shared/figs/qfeatures.png", error = FALSE)
```

:::{.callout-note}
#### QFeatures nomenclature
When talking about a `QFeatures` object, each dataset (individual
`SummarizedExperiment`) can be referred to as a `set` (short for dataset).
Previously, each dataset was referred to as an `experimental assay`, and some
older resources may still use this term. However, the `experimental assay`
should not be confused with the quantitative matrix section of a
`SummarizedExperiment`, which is called the `assay` data.
:::

In order to generate the explicit links between data levels, we need to import
the lowest desired data level into a `QFeatures` object and aggregate upwards
within the `QFeatures` infrastructure using the `aggregateFeatures` function.
If two `SummarizedExperiment`s are generated separately and then added into
the same `QFeatures` object, there will not automatically be links between
them. In this case, if links are required, we can manually add them using the
`addAssayLink()` function.
