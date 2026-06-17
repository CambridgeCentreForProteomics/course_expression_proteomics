## ================================================
## Lesson 04: Normalisation and aggregation
## ================================================


## ---------------------------------------------------------------------------------------------------------
## Load R/Bioconductor libraries
## ---------------------------------------------------------------------------------------------------------

library("QFeatures")
library("naniar")
library("tidyr")
library("dplyr")
library("ggplot2")
library("patchwork")


## ---------------------------------------------------------------------------------------------------------
## Load data from previous lesson
## ---------------------------------------------------------------------------------------------------------



## ---------------------------------------------------------------------------------------------------------
## Examine the distribution of raw precursor intensities
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



## ---------------------------------------------------------------------------------------------------------
## Challenge 1: Quantification completeness at the protein level
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
## broken down by group.
##
## Hint: Count finite values per protein per group using sum(is.finite(value)).
## ---------------------------------------------------------------------------------------------------------




## ---------------------------------------------------------------------------------------------------------
## Challenge 2: Patterns of missingness
##
## Use naniar::gg_miss_upset to visualise patterns of missingness in the
## protein-level data. An upset plot shows which combinations of samples
## tend to have missing values for the same proteins.
##
## - Are missing values random across samples, or do they cluster within
##   particular groups?
## - Is the missingness more consistent with MCAR or MNAR?
##
## Hint: Extract the protein assay with assay(), convert to a data frame,
## and pass to naniar::gg_miss_upset. Use nintersects to limit the number
## of intersections shown.
## ---------------------------------------------------------------------------------------------------------




## ---------------------------------------------------------------------------------------------------------
## Normalisation
## ---------------------------------------------------------------------------------------------------------

## diff.median shifts each sample's intensity distribution so that all sample
## medians match the grand median across all samples.



## Visualise the effect of normalisation with density plots

longForm(dia_qf[,,'proteins'], colvars = 'group')
