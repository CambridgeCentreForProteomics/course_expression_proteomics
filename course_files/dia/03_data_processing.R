## ================================================
## Lesson 03: Data cleaning
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
## Filtering by Q-value
## ---------------------------------------------------------------------------------------------------------

## Filtering on DIA-NN Q-values at <= 0.01 controls the FDR at 1% among the identifications retained.
## We apply a 1% FDR threshold (Q-value <= 0.01) to all four columns.
## Omitting the i argument applies the filter to all per-sample sets simultaneously.

dia_qf

dia_qf <- dia_qf %>%
  filterFeatures(~ Q.Value <= 0.01) %>%       # Run-level precursor Q-value
  filterFeatures(~ PG.Q.Value <= 0.01) %>%    # Run-level protein group Q-value
  filterFeatures(~ Lib.Q.Value <= 0.01) %>%   # Library-level precursor Q-value
  filterFeatures(~ Lib.PG.Q.Value <= 0.01)    # Library-level protein group Q-value

dia_qf

hist(nrows(dia_qf),
     xlab = "Precursors",
     main = "Precursor counts per sample\nafter Q-value filtering")


## ---------------------------------------------------------------------------------------------------------
## Joining per-sample sets into a single precursor set
## ---------------------------------------------------------------------------------------------------------

## joinAssays merges all per-sample sets into one combined set, aligning by Precursor.Id.
## Where a precursor was not detected in a sample, the entry will be NA.



## Compare rowData columns before and after joining

sample_level_rdata_names <- rowDataNames(dia_qf)[[1]]

joined_rdata_names <- rowDataNames(dia_qf)[["precursors"]]

setdiff(sample_level_rdata_names, joined_rdata_names)


## Challenge: Comparing rowData before and after joining
## (inspection only; run before the per-sample sets are removed)

## 1. Rows and columns of the first per-sample set and of "precursors"



## 2. Which of the four Q-value columns we filtered on remain in "precursors"?




## ---------------------------------------------------------------------------------------------------------
## Removing individual sample-level assays
## ---------------------------------------------------------------------------------------------------------


## ---------------------------------------------------------------------------------------------------------
## Identifying contaminant proteins
## ---------------------------------------------------------------------------------------------------------

## Contaminant entries from the database search are named with a "Cont_" prefix
## in the Protein.Ids column. We check how many precursors are flagged.


## ---------------------------------------------------------------------------------------------------------
## Filtering contaminants
## ---------------------------------------------------------------------------------------------------------

## We create a copy of the "precursors" set, add an assay link, then filter.
## The original "precursors" set is retained for reference.


## ---------------------------------------------------------------------------------------------------------
## Exploring missing values
## ---------------------------------------------------------------------------------------------------------


## ---------------------------------------------------------------------------------------------------------
## Challenge: Visualising missing values
##
## Using the precursors_missing object, create plots to explore the
## distribution of missing values in the data.
##
## 1. Plot a histogram for the proportion of missing values across precursors.
## 2. Plot the proportion of missing values per sample, coloured by group.
##
## Consider:
## - Do most precursors have missing values?
## - Are there any precursors or samples with an unusually high proportion?
## - Does the proportion of missing values differ between groups?
##
## Hint: precursors_missing contains two data frames: nNArows (one row per
## precursor) and nNAcols (one row per sample), each with a pNA column.
## ---------------------------------------------------------------------------------------------------------




## ---------------------------------------------------------------------------------------------------------
## Patterns of missingness across samples
## ---------------------------------------------------------------------------------------------------------

## An upset plot shows which combinations of samples share missing values.
## Each sample is a set; each bar counts the precursors missing in exactly
## that combination of samples. Use naniar::gg_miss_upset on the assay of the
## "precursors_no_cont" set, converted to a data frame.




## ---------------------------------------------------------------------------------------------------------
## Challenge: Missing values and intensity
##
## For each precursor in the "precursors_no_cont" set, calculate the
## proportion of samples in which it is missing and the mean of its log2
## intensity over the samples in which it was detected. Plot one against the
## other.
##
## - How does the proportion of missing values change with intensity?
## - Are high-intensity precursors ever missing?
##
## Hint: Extract the matrix with assay(). rowMeans(is.na(x)) gives the
## proportion missing per row, and rowMeans(log2(x), na.rm = TRUE) the mean of
## the observed log2 values.
## ---------------------------------------------------------------------------------------------------------




## ---------------------------------------------------------------------------------------------------------
## How we handle missing values
## ---------------------------------------------------------------------------------------------------------

## We do not replace missing values. Instead:
## 1. Remove precursors detected in too few samples (next section).
## 2. Summarise proteins from the detected precursors with robustSummary
##    (next lesson).
## 3. Before testing, keep only proteins quantified in at least three samples
##    of every group (statistical analysis lesson).


## ---------------------------------------------------------------------------------------------------------
## Filtering sparse precursors
## ---------------------------------------------------------------------------------------------------------

## pNA = 0.75 means a precursor must be observed in at least 25% of samples
## (approximately 8 of 31 samples).



## ---------------------------------------------------------------------------------------------------------
## Removing a sample
## ---------------------------------------------------------------------------------------------------------

## All 31 samples are kept. To remove one (e.g. after a failed injection),
## subset the QFeatures object by column, which removes it from every set:
##
##   dia_qf <- dia_qf[, dia_qf$runCol != "Ctr_A1"]
##
## Ctr_A1 is only an example; do not run this.

