This is to be expected since the majority of proteins exist at low abundances
within the cell and only a few proteins are highly abundant. However, if we
leave the quantitative data in a non-Gaussian distribution then we will not be
able to apply parametric statistical tests later on. Consider the case where
we have a protein with abundance values across three samples A, B and C. If the
abundance values were 0.1, 1 and 10, we can tell from just looking at the numbers
that the protein is 10-fold more abundant in sample B compared to sample A, and
10-fold more abundant in sample C than sample B. However, even though the fold-changes
are equal, the abundance values in A and B are much closer together on
a linear scale than those of B and C. A parametric test would not account for
this bias and would not consider A and B to be as equally different as B and C.
**By applying a logarithmic transformation we can convert our skewed asymmetrical data distribution into a symmetrical, Gaussian distribution.**

::: {.callout-note}
#### Why use base-2?
Although there is no mathematical reason for applying a log2 transformation
rather than using a higher base such as log10, the log2 scale provides an easy
visualisation tool. Any protein that halves in abundance between conditions will
have a 0.5 fold change, which translates into a log2 fold change of -1. Any
protein that doubles in abundance will have a fold change of 2 and a log2 fold
change of +1.
:::
