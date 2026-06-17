### Multiple hypothesis testing and correction

Using the linear model defined above, we have carried out a
statistical test for each protein.

Multiple testing describes the process of separately testing multiple null
hypothesis i.e., carrying out many statistical tests at a time, each to
test a null hypothesis on different data. Here we have carried out
one statistical test per protein.
If we were to use the typical p \< 0.05 significance threshold for each
test, we would expect a 5% chance of incorrectly rejecting the null
hypothesis *per test*. For a typical proteomics dataset with thousands of
proteins, we would expect many p-values <= 0.05 by chance.

If we do not account for the fact that we have carried out multiple
hypothesis, we risk including false positives in our data. Many
methods exist to correct for multiple hypothesis testing and these
mainly fall into two categories:

1.  Control of the Family-Wise Error Rate (FWER)
2.  Control of the False Discovery Rate (FDR)

Above we specified the "BH" method for adjusting p-values in our `topTable` function call. This is shorthand for the Benjamini-Hochberg procedure, to control the FDR.

::: callout-tip
#### The False Discovery Rate

The False Discovery Rate (FDR) defines the fraction of false discoveries
that we are willing to tolerate in our list of differential proteins.
For example, an FDR threshold of 0.05 means that approximately 5% of the
proteins deemed differentially abundant will be false positives. It is up to you
to decide what this threshold should be, but conventionally a value between 0.01
(1% FPs) and 0.1 (10% FPs) is chosen.
:::
