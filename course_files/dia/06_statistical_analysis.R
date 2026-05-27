## =============================================================
## Lesson 06: Statistical analysis
## =============================================================


## ---------------------------------------------------------------------------------------------------------
## Load R/Bioconductor libraries
## ---------------------------------------------------------------------------------------------------------

library("QFeatures")
library("limma")
library("tidyr")
library("dplyr")
library("tibble")
library("ggplot2")
library("ggrepel")
library("patchwork")


## ---------------------------------------------------------------------------------------------------------
## Load data from previous lesson
## ---------------------------------------------------------------------------------------------------------


## ---------------------------------------------------------------------------------------------------------
## Handling missing values prior to testing
## ---------------------------------------------------------------------------------------------------------

## We only test proteins quantified in >= 3 replicates of each condition.
## getWithColData extracts a SummarizedExperiment from the QFeatures object,
## carrying the colData across so we can subset directly by group.

se <- getWithColData(dia_qf, "norm_proteins")
print(se)

## Subset by condition
control <- se[, se$group == "control"]
mpxv    <- se[, se$group == "MPXV"]
cov     <- se[, se$group == "Covid19"]

## Keep only proteins quantified in >= 3 replicates per condition
control_replicated <- rowSums(!is.na(assay(control))) >= 3
mpxv_replicated    <- rowSums(!is.na(assay(mpxv))) >= 3
cov_replicated     <- rowSums(!is.na(assay(cov))) >= 3

tokeep <- control_replicated & mpxv_replicated & cov_replicated
print(table(tokeep))

## Add new set with only the replicated proteins


## ---------------------------------------------------------------------------------------------------------
## Defining the statistical model
## ---------------------------------------------------------------------------------------------------------

## No-intercept design estimates the mean for each group directly.
## This makes it straightforward to specify all pairwise contrasts.


## Verify the design matrix


## ---------------------------------------------------------------------------------------------------------
## Specifying contrasts
## ---------------------------------------------------------------------------------------------------------


## Verify the contrasts matrix


## ---------------------------------------------------------------------------------------------------------
## Running the empirical Bayes-moderated test using limma
## ---------------------------------------------------------------------------------------------------------



## ---------------------------------------------------------------------------------------------------------
## Diagnostic plots
## ---------------------------------------------------------------------------------------------------------

## SA plot: residual SD vs log abundance — trend line should be flat or gently
## decreasing; a strong increasing trend suggests trend = TRUE was appropriate.



## ---------------------------------------------------------------------------------------------------------
## F-test for overall significance across groups
## ---------------------------------------------------------------------------------------------------------

## coef = NULL returns the F-statistic for overall significance across all groups.


## ---------------------------------------------------------------------------------------------------------
## Pairwise contrasts: MPXV vs Control
## ---------------------------------------------------------------------------------------------------------

## Extract gene name annotations from rowData to merge into results


# plot

## How many significant changes?



## ---------------------------------------------------------------------------------------------------------
## Volcano plot: MPXV vs Control
## ---------------------------------------------------------------------------------------------------------

# extract data for highlighting

# plot


## ---------------------------------------------------------------------------------------------------------
## Extracting results for all contrasts
## ---------------------------------------------------------------------------------------------------------


## ---------------------------------------------------------------------------------------------------------
## P-value distributions across all contrasts
## ---------------------------------------------------------------------------------------------------------


## ---------------------------------------------------------------------------------------------------------
## Global multiple testing correction across all contrasts
## ---------------------------------------------------------------------------------------------------------

## Adjusting globally across all proteins and contrasts is more rigorous than
## correcting each contrast separately. BH correction is valid under the positive
## correlation structure typical of multi-contrast proteomics experiments.



## How many significant changes in each contrast?


## ---------------------------------------------------------------------------------------------------------
## Volcano plots for all contrasts
## ---------------------------------------------------------------------------------------------------------

# extract data for highlighting

# plot


## ---------------------------------------------------------------------------------------------------------
## Challenge: Using treat to test against a fold-change threshold
##
## The eBayes function tests whether log fold change equals zero. The treat
## function instead tests whether the absolute log fold change is less than a
## specified threshold, providing a statistically rigorous alternative to
## post-hoc fold-change filtering.
##
## 1. Replace the eBayes call with treat(fc = 1.2, trend = TRUE, robust = TRUE)
##    and extract results for all contrasts using topTreat instead of topTable.
## 2. Apply global Benjamini-Hochberg correction to the p-values as before.
## 3. How many proteins are significant (adj.P.Val < 0.05) in each contrast
##    compared to the eBayes results? Why is the number lower?
## ---------------------------------------------------------------------------------------------------------

