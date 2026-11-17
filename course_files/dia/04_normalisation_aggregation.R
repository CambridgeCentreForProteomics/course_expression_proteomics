## ================================================
## Lesson 04: Log transformation and aggregation
## ================================================


## ---------------------------------------------------------------------------------------------------------
## Load R/Bioconductor libraries
## ---------------------------------------------------------------------------------------------------------

library("QFeatures")
library("tidyr")
library("dplyr")
library("ggplot2")
library("patchwork")


## ---------------------------------------------------------------------------------------------------------
## Load data from previous lesson
## ---------------------------------------------------------------------------------------------------------



## ---------------------------------------------------------------------------------------------------------
## Examine the distribution of untransformed precursor intensities
## ---------------------------------------------------------------------------------------------------------


## ---------------------------------------------------------------------------------------------------------
## Log2 transformation
## ---------------------------------------------------------------------------------------------------------

## Log transformation is applied before aggregation because robustSummary
## fits a linear model that assumes approximately Gaussian residuals.



## ---------------------------------------------------------------------------------------------------------
## Summarising to protein-level abundance
## ---------------------------------------------------------------------------------------------------------

## robustSummary handles missing values at the precursor level by modelling
## log-transformed precursor quantities as protein abundance + precursor effect.
## A precursor must be quantified in at least 2 samples.
##
## Aggregate on Protein.Group (the protein group DIA-NN inferred for each
## precursor), not Protein.Ids. maxit = 10000 is passed on to MASS::rlm,
## raising its iteration limit from the default of 20.



## ---------------------------------------------------------------------------------------------------------
## Challenge: Quantification completeness at the protein level
##
## Although robustSummary handles precursor-level missing values, a protein
## will still be missing in any sample where ALL of its precursors are absent.
##
## Use longForm() to convert the "proteins" set to long format (one row per
## protein-sample combination). The colvars argument carries colData columns
## across. Run:
##
##   longForm(dia_qf[,,'proteins'], colvars = 'group') %>%
##     data.frame() %>%
##     head()
##
## Then create a plot showing how many samples each protein is quantified in,
## broken down by group, and consider:
##
## - Why might some proteins still be missing in some samples despite using
##   robustSummary?
## - What happens to proteins quantified in only a few samples of a group in
##   the rest of our workflow?
##
## Hint: Count finite values per protein per group using sum(is.finite(value)).
## ---------------------------------------------------------------------------------------------------------



