## =============================================================
## Lesson 07: Visualisation of differential abundance results
## =============================================================


## ---------------------------------------------------------------------------------------------------------
## Load R/Bioconductor libraries
## ---------------------------------------------------------------------------------------------------------

library("QFeatures")
library("matrixStats")
library("tidyr")
library("dplyr")
library("tibble")
library("ggplot2")
library("ggrepel")
library("pheatmap")


## ---------------------------------------------------------------------------------------------------------
## Load data from previous lesson
## ---------------------------------------------------------------------------------------------------------

## ---------------------------------------------------------------------------------------------------------
## Heatmap of all replicated proteins
## ---------------------------------------------------------------------------------------------------------

## Extract quantification matrix and rename columns with sample shortnames.
## We use correlation-based distance (1 - Pearson r) with pairwise complete
## observations to handle missing values, and Ward's linkage for clustering.


## Correlation-based distances (handles NAs via pairwise.complete.obs)


## ---------------------------------------------------------------------------------------------------------
## Helper function for repeated heatmaps
## ---------------------------------------------------------------------------------------------------------

## Rather than repeating the same code for each protein subset, we define a
## function that takes a vector of UniProt IDs and plots the heatmap.


## ---------------------------------------------------------------------------------------------------------
## Heatmap for the 50 most variable proteins
## ---------------------------------------------------------------------------------------------------------


## ---------------------------------------------------------------------------------------------------------
## Challenge: Heatmaps of significant proteins
##
## Use plot_heatmap_for_uids (defined above) and the F-test and pairwise
## contrast results to produce heatmaps for:
##
## 1. Proteins with a significant overall difference across groups according
##    to the F-test (adj.P.Val < 0.05)
## 2. Proteins significant (adj.P.Val < 0.05) in at least one pairwise contrast
##
## For each heatmap consider:
## - How do the proteins and samples cluster?
## - Do the sample groups separate cleanly?
## - How does restricting to significant proteins change the heatmap compared
##   to the most variable proteins plotted above?
##
## Hint: Filter limma_results_F and limma_results_all_contrasts to get UniProt
## IDs of significant proteins, then pass these to plot_heatmap_for_uids.
## ---------------------------------------------------------------------------------------------------------




## ---------------------------------------------------------------------------------------------------------
## Comparing log fold changes across contrasts
## ---------------------------------------------------------------------------------------------------------

## pivot_wider reshapes results so each protein occupies one row, with separate
## columns for the logFC and adj.P.Val from each contrast.



## Initial scatter plot of logFC values across two contrasts


## Categorise each protein by significance status across the two contrasts


## Scatter plot coloured by significance category, labelling proteins significant
## in both contrasts


## Add transparency and a linear regression line

