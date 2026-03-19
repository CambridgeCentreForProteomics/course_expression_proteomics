### What does the empirical Bayes part mean?

When carrying out high throughput omics experiments we not only have a
population of samples but also a population of features - here we have
several thousand proteins. Proteomics experiments are typically lowly replicated
(e.g n < 10), therefore, the per-protein variance estimates are relatively
inaccurate. The empirical Bayes method borrows information across
features (proteins) and shifts the per-protein variance estimates
towards an expected value based on the variance estimates of other
proteins with a similar abundance. This improves the accuracy of the variance
estimates, thus reducing false negatives for proteins with over-estimated variance and reducing false positives from proteins with under-estimated variance. For more detail about the empirical Bayes methods, see
[here](https://online.stat.psu.edu/stat555/node/40/).
