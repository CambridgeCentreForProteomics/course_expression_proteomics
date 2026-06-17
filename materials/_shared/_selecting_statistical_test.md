The first point relates to a key assumption of **Gaussian linear modelling**,
which assumes that the residuals (difference between the observed values and the
values predicted by the model) are Gaussian distributed. If this assumption is
not met, it is not appropriate to use a Gaussian linear model. For quantitative
proteomics data, it is reasonable to assume the residuals will be approximately
Gaussian distributed if we first log-transform the abundances.

Many different R packages can be used to carry out differential abundance
analysis on proteomics data. Here we will use `limma`, a package that is widely
used for omics analysis and can be used in single comparisons or multifactorial
experiments using an **empirical Bayes-moderated linear model**. A simple
example of the empirical Bayes-moderated linear model is provided in
@Hutchings2023.
