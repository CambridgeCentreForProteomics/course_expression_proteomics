This is to be expected since the majority of proteins exist at low abundances
within the cell and only a few are highly abundant. However, **raw protein
abundances are not normally distributed**, which means parametric statistical
tests cannot be applied directly.

**Why does the skewed distribution matter?** Consider a protein with abundance
values of 0.25, 1, and 4 across three samples A, B, and C:

- Each step represents a 4-fold increase — the fold changes are equal.
- Yet on a linear scale, samples A and B (difference of 0.75) appear much
  closer together than B and C (difference of 3).
- A parametric test would treat these as unequal differences, introducing a
  systematic bias.

By applying a log2 transformation, the values become −2, 0, and +2 — evenly
spaced — converting the skewed distribution into a symmetrical, approximately
Gaussian distribution suitable for downstream statistical analysis.

::: {.callout-note}
#### Why use base-2?
Although there is no mathematical reason for applying a log2 transformation
rather than using a higher base such as log10, the log2 scale provides an easy
visualisation tool. Any protein that halves in abundance between conditions will
have a 0.5 fold change, which translates into a log2 fold change of -1. Any
protein that doubles in abundance will have a fold change of 2 and a log2 fold
change of +1.
:::
