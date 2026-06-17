As with all statistical analysis, it is crucial to do some quality
control and to check that the statistical test that has been applied was
indeed appropriate for the data. As mentioned above, statistical tests
typically come with several assumptions. To check that these assumptions
were met and that our model was suitable, we create some diagnostic
plots.

The first plot that we generate is an SA plot to display the residual
standard deviation (sigma) versus log abundance for each protein to
which our model was fitted. We can use the `plotSA` function to do this.