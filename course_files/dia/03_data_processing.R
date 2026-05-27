## ================================================
## Lesson 03: Data cleaning
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
## Filtering by Q-value
## ---------------------------------------------------------------------------------------------------------

## DIA-NN Q-value columns represent the local FDR for each identification.
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
## Filtering sparse precursors
## ---------------------------------------------------------------------------------------------------------

## pNA = 0.75 means a precursor must be observed in at least 25% of samples
## (approximately 8 of 31 samples).

