As with all statistical analysis, it is crucial to do some quality
control and to check that the statistical test that has been applied was
indeed appropriate for the data. As mentioned above, statistical tests
typically come with several assumptions. To check that these assumptions
were met and that our model was suitable, we create some diagnostic
plots.

The first plot that we generate is an SA plot to display the residual
standard deviation (sigma) versus log abundance for each protein to
which our model was fitted. We can use the `plotSA` function to do this.

It is recommended that an SA plot be used as a routine diagnostic plot
when applying a limma-trend pipeline. From the SA plot we can visualise
the intensity-dependent trend that has been incorporated into our
linear model. It is important to verify that the trend line fits the
data well. If we had not included the `trend = TRUE` argument in our
`eBayes` function, then we would instead see a straight horizontal line
that does not follow the trend of the data. Further, the plot also
colours any outliers in red. These are the outliers that are only
detected and excluded when using the `robust = TRUE` argument.

Next, we plot a histogram of the raw p-values (not adjusted
p-values). This can be done by passing our results data into standard
`ggplot2` plotting functions.

The near-flat distribution across the bottom corresponds to
null p-values which are distributed approximately uniformly between 0
and 1. The peak close to 0 contains a combination of our significantly changing proteins (true positives) and proteins with a low p-value by chance (false positives).

Other examples of how a p-value histogram could look are shown below.
Whilst in some experiments a uniform p-value distribution may arise due
to an absence of significant alternative hypotheses, other distribution
shapes can indicate that something was wrong with the model design or
statistical test. For more detail on how to interpret p-value histograms
there is a great
[blog post](http://varianceexplained.org/statistics/interpreting-pvalue-histogram/)
by David Robinson, from which the examples below are taken.
