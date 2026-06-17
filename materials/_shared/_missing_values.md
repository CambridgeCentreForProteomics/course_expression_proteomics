Having cleaned our data, the next step is to deal with missing values. It is
important to be aware that missing values can arise for different reasons in
MS data, and these reasons determine the best way to deal with the missing data.

* Biological reasons - a peptide may be genuinely absent from a sample or have such low abundance that it is below the limit of MS detection
* Technical reasons - technical variation and the stochastic nature of MS (particularly using DDA) may lead to some peptides not being quantified. Some peptides have a lower ionization efficiency which makes them less compatible with MS analysis

Missing values that arise for different reasons can generally be deciphered by
their pattern. For example, peptides that have missing quantitation values for
biological reasons tend to be low intensity or completely absent peptides. Hence,
these missing values are **missing not at random (MNAR)** and appear in an
intensity-dependent pattern. By contrast, peptides that do not have quantitation
due to technical reasons are **missing completely at random (MCAR)** and appear
in an intensity-independent manner.
