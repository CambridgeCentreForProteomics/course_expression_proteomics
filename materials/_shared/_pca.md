The final protein-level exploration is principal component analysis (PCA).

PCA summarises the abundances of many proteins in each sample with a few new variables, the principal components (PCs).
Each PC is a weighted combination of the proteins.
PC1 is the direction along which the samples differ most, PC2 is the direction of greatest remaining variation at right angles to PC1, and so on.
Plotting the samples on the first few PCs shows the largest patterns in the data without our having to choose which proteins to look at.

Three things about how the PCs are calculated affect how we read them:

- Proteins are the variables and samples are the observations. With `scale = TRUE`, each protein is scaled to unit variance first, so a protein does not dominate the PCs just because its abundance varies more.
- PCA needs a value for every protein in every sample, so proteins with missing values are removed first. The PCA describes only the proteins that remain.
- There are at most one fewer informative PCs than there are samples. A scree plot shows how much of the variance each PC explains, which tells us how many are worth plotting.

### Reading a PCA plot

- Colour the samples by every variable recorded, not only the experimental groups: batch, run order, preparation date. If samples separate by a technical variable, it needs to be investigated, and may need to go into the statistical model.
- A sample far from the others may be an outlier. Check it against the quality metrics from earlier lessons before deciding whether to remove it; distance on a PCA plot alone is not a reason.
- If the groups do not separate on the first PCs, that does not mean no proteins differ. The largest sources of variation can be differences between individuals, and changes in a few proteins can still be detected by the statistical tests.
- The loadings (`$rotation` in the `prcomp` output) show which proteins contribute most to each PC.
