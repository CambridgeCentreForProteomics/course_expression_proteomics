The final step in any statistical analysis is to visualise the results.
This is important for ourselves as it allows us to check that the data
looks as expected.

The most common visualisation used to display the results of expression
proteomics experiments is a volcano plot. This is a scatterplot that
shows statistical significance (p-values) against the magnitude of fold
change. Of note, when we plot the statistical significance we use the
raw unadjusted p-value (`-log10(P.Value)`). This is because it is better
to plot the statistical test results in their 'raw' form and not values derived from them (the
adjusted p-value is derived from each p-value using the BH-method of
correction). Furthermore, the process of FDR correction can result in some points
that previously had distinct p-values having the same adjusted p-value.
Finally, different methods of correction will generate different
adjusted p-values, making the comparison and interpretation of values
more difficult.
