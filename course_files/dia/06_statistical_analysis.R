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

se <- getWithColData(dia_qf, "proteins")
print(se)

## Keep only proteins quantified in >= 3 samples of every group.
## Looping over the groups means the same code works for any number of groups.
tokeep <- rep(TRUE, nrow(se))

for (g in unique(se$group)) {
  n_quantified <- rowSums(!is.na(assay(se[, se$group == g])))
  tokeep <- tokeep & n_quantified >= 3
}

print(table(tokeep))


## ---------------------------------------------------------------------------------------------------------
## Challenge: Which proteins does the replication filter remove?
##
## 1. For the proteins removed by the filter, count the quantified samples in
##    each group.
## 2. How many are removed because of a single group, with the other two groups
##    well quantified?
## 3. Find CRP in the table. What does its pattern suggest, and can we say
##    anything about it with this workflow?
## ---------------------------------------------------------------------------------------------------------


## Add new set with only the replicated proteins


## ---------------------------------------------------------------------------------------------------------
## Defining the statistical model
## ---------------------------------------------------------------------------------------------------------

## No-intercept design estimates the mean for each group directly.
## This makes it straightforward to specify all pairwise contrasts.


## Verify the design matrix


## ---------------------------------------------------------------------------------------------------------
## Fitting the linear model
## ---------------------------------------------------------------------------------------------------------



## ---------------------------------------------------------------------------------------------------------
## Defining contrasts and moderating the variances
## ---------------------------------------------------------------------------------------------------------

## Define all three pairwise contrasts. The F-test and every pairwise result
## are extracted from this one fit with topTable.

## Verify the contrasts matrix


## Apply the contrasts and moderate with eBayes (trend = TRUE, robust = TRUE)



## ---------------------------------------------------------------------------------------------------------
## Diagnostic plots
## ---------------------------------------------------------------------------------------------------------

## SA plot: residual SD vs log abundance — trend line should be flat or gently
## decreasing; a strong increasing trend suggests trend = TRUE was appropriate.



## ---------------------------------------------------------------------------------------------------------
## Challenge: Recognising a poorly behaved SA plot
##
## The SA plots shown in the lesson were drawn from the same protein-level data
## as our model: our analysis, the same data after the lowest 10% of values
## were removed and imputed with MinDet, and the same data after 10% of values
## were removed at random and replaced by zero. There is nothing to run for this
## exercise.
##
## 1. How does the trend line in each of the other two plots differ from the
##    trend line in ours?
## 2. Where do the red outlier proteins sit in each plot, and what do they tell
##    us about those proteins?
## 3. If you saw a plot like the second or third for your own data, what would
##    you check first?
## ---------------------------------------------------------------------------------------------------------


## ---------------------------------------------------------------------------------------------------------
## F-test for overall significance across groups
## ---------------------------------------------------------------------------------------------------------

## With two groups there is only one contrast and the F-test equals the
## moderated t-test (F = t^2), so this step can be skipped.

## coef = NULL returns the F-statistic for overall significance across all groups.


## Challenge: Interpreting the F-test p-value distribution


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



## Write the final results for every protein in every contrast to a CSV file


## How many significant changes in each contrast?


## ---------------------------------------------------------------------------------------------------------
## Volcano plots for all contrasts
## ---------------------------------------------------------------------------------------------------------

# extract data for highlighting

# plot


## ---------------------------------------------------------------------------------------------------------
## Challenge: Fold-change thresholds on a volcano plot
##
## A common way to call a protein differentially abundant is to require both a
## significant adjusted p-value and a fold change of at least 2 (a log2 fold
## change of +1 or -1).
##
## Using limma_results_all_contrasts, plot a volcano plot for the MPXV_Covid19
## contrast only, with vertical dashed lines at a log2 fold change of -1 and +1.
##
## 1. How many proteins have adj.P.Val < 0.05 and lie outside the two lines?
## 2. Are there significant proteins that lie inside the lines? Are there
##    proteins outside the lines that are not significant?
## 3. The x-axis shows a single estimate of the fold change for each protein,
##    with no indication of its uncertainty. How confident can we be in the size
##    of the fold change for a protein just outside a line, compared with one far
##    outside it?
##
## Hint: Filter with filter(contrast == "MPXV_Covid19") and add
## geom_vline(xintercept = c(-1, 1), linetype = "dashed") to the volcano plot
## code above.
## ---------------------------------------------------------------------------------------------------------


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

