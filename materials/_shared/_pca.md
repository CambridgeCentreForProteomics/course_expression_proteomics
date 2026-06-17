The final protein level exploration that we will do is Principal Component
Analysis (PCA).

PCA is a statistical method that can be applied to condense complex data from
large data tables into a smaller set of summary indices, termed principal
components. This process of dimensionality reduction makes it easier to
understand the variation observed in a dataset, both how much variation there is
and what the primary factors driving the variation are. This is particularly
important for multivariate datasets in which experimental factors can contribute
differentially or cumulatively to variation in the observed data. PCA allows us
to observe any trends, clusters and outliers within the data thereby helping to
uncover the relationships between observations and variables.


### The process of PCA

The process of PCA can be considered in several parts:

1. Scaling and centering the data

Firstly, all continuous variables are standardized into the same range so that
they can contribute equally to the analysis. This is done by centering each
variable to have a mean of 0 and scaling its standard deviation to 1.


2. Generation of a covariance matrix

After the data has been standardized, the next step is to calculate a covariance
matrix. The term covariance refers to a measure of how much two variables vary
together. For example, the height and weight of a person in a population will
be somewhat correlated, thereby resulting in covariance within the population.
A covariance matrix is a square matrix of dimensions *p* x *p* (where *p* is
the number of dimensions in the original dataset i.e., the number of variables).
The matrix contains an entry for every possible pair of variables and describes
how the variables are varying with respect to each other.

Overall, the covariance matrix is essentially a table which summarises the
correlation between all possible pairs of variables in the data. If the covariance
of a pair is positive, the two variables are correlated in some direction (increase
or decrease together). If the covariance is negative, the variables are inversely
correlated with one increasing when the other decreases. If the covariance is
near-zero, the two variables are not expected to have any relationship.


3. Eigendecomposition - calculating eigenvalues and eigenvectors

Eigendecomposition is a concept in linear algebra whereby a data matrix is
represented in terms of **eigenvalues** and **eigenvectors**. In this case, the
the eigenvalues and eigenvectors are calculated based on the covariance matrix
and will inform us about the magnitude and direction of our data. Each eigenvector
represents a direction in the data with a corresponding eigenvalue telling us how
much variation in our data occurs in that direction.

* Eigenvector = informs about the direction of variation
* Eigenvalue = informs about the magnitude of variation

The number of eigenvectors and eigenvalues will always be equal to the number of
samples in the dataset.


4. The calculation of principal components

Principal components are calculated by multiplying the original data by a
corresponding eigenvector. As a result, the principal components themselves
represent directionality of data. The order of the principal components is
determined by the corresponding eigenvector such that the first principal
component is that which explains the most variation in the data (i.e., has the
largest eigenvalue).

By having the first principal components explain the largest proportion of
variation in the data, the dimension of the data can be reduced by focusing
on these principal components and ignoring those which explain very little in
the data.
