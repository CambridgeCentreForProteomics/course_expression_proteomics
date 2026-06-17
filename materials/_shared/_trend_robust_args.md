-   `trend` - takes a logical value of `TRUE` or `FALSE` to indicate
    whether an intensity-dependent trend should be allowed for the prior
    variance (i.e., the population level variance prior to empirical
    Bayes moderation). This means that when the empirical Bayes
    moderation is applied the protein variances are not squeezed towards
    a global mean but rather towards an intensity-dependent trend.
-   `robust` - takes a logical value of `TRUE` or `FALSE` to indicate
    whether the parameter estimation of the priors should be robust
    against outlier sample variances.

See (@Phipson2016 and @Smyth2004) for further details.
