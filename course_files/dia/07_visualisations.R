## =============================================================
## Lesson 07: Visualisation of differential abundance results
## =============================================================


## ---------------------------------------------------------------------------------------------------------
## Load R/Bioconductor libraries
## ---------------------------------------------------------------------------------------------------------

library("QFeatures")
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
## Building a heatmap of all replicated proteins
## ---------------------------------------------------------------------------------------------------------

## Extract the quantification matrix and rename columns with sample shortnames.
## Prepare a data frame of sample annotations recording the group of each sample.


## Plot the matrix with clustering switched off


## Scale each row (Z-score)


## Annotate the samples by group


## Cluster rows and columns with the pheatmap defaults


## Correlation-based distance (1 - Pearson r, pairwise complete observations
## to handle missing values) and Ward's linkage


## Diverging colour palette and layout


## ---------------------------------------------------------------------------------------------------------
## Challenge: Heatmaps of protein subsets
##
## Choose a subset of the replicated proteins and plot a heatmap of it, using
## the code above as a template. For example:
##
## - Proteins with a significant overall difference across groups according
##   to the F-test (adj.P.Val < 0.05)
## - Proteins significant (adj.P.Val < 0.05) in at least one pairwise contrast
## - Proteins significant in one contrast only
##
## For your heatmap consider:
## - How do the proteins and samples cluster?
## - Do the sample groups separate cleanly?
## - How does the choice of subset change what the heatmap can show?
##
## Hint: The row names of quant_mtx are UniProt IDs, so you can select rows with
## a vector of IDs taken from limma_results_F or limma_results_all_contrasts.
## Calculate the row and column distances again for the subset before passing
## them to pheatmap.
## ---------------------------------------------------------------------------------------------------------




## ---------------------------------------------------------------------------------------------------------
## Comparing log fold changes across contrasts
## ---------------------------------------------------------------------------------------------------------

## pivot_wider reshapes results so each protein occupies one row, with separate
## columns for the logFC and adj.P.Val from each contrast.



## Initial scatter plot of logFC values across two contrasts


## Discussion: the plot shows one point per protein and nothing else.
## - What other information would help us interpret it?
## - Which of that information do we already have in compare_limma_results or in
##   the earlier analysis, and which would we need to calculate?
## - How could each addition be shown: a colour, a point size, a label, a
##   reference line?


## Categorise each protein by significance status across the two contrasts


## Scatter plot coloured by significance category, labelling proteins significant
## in both contrasts


## Add transparency and a linear regression line

