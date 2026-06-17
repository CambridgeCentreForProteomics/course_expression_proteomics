## =============================================================
## Lesson 08: Functional enrichment analysis
## =============================================================


## ---------------------------------------------------------------------------------------------------------
## Load R/Bioconductor libraries
## ---------------------------------------------------------------------------------------------------------

library("QFeatures")
library("ggplot2")
library("clusterProfiler")
library("tidyr")
library("tibble")
library("org.Hs.eg.db")
library("enrichplot")
library("GOSemSim")
library("pheatmap")
library("dplyr")


## ---------------------------------------------------------------------------------------------------------
## Load data from previous lesson
## ---------------------------------------------------------------------------------------------------------


## ---------------------------------------------------------------------------------------------------------
## Subset results to the contrast of interest
## ---------------------------------------------------------------------------------------------------------

## We focus on COVID-19 vs Control as the comparison of primary biological interest.



## ---------------------------------------------------------------------------------------------------------
## GO over-representation analysis
## ---------------------------------------------------------------------------------------------------------

## We test proteins with significantly decreased abundance in COVID-19 vs Control.
## The universe is all proteins that were tested (all quantified proteins).


## ---------------------------------------------------------------------------------------------------------
## Visualising significant GO terms
## ---------------------------------------------------------------------------------------------------------




## ---------------------------------------------------------------------------------------------------------
## Reducing GO term redundancy using semantic similarity
## ---------------------------------------------------------------------------------------------------------

## GOSemSim computes pairwise semantic similarity between GO terms.
## simplify removes highly similar terms, keeping the most significant
## representative from each cluster.



## Re-visualise with reduced redundancy



## ---------------------------------------------------------------------------------------------------------
## Visualising relationships between GO terms with a treeplot
## ---------------------------------------------------------------------------------------------------------



## ---------------------------------------------------------------------------------------------------------
## Linking GO results back to protein abundances
## ---------------------------------------------------------------------------------------------------------

## Extract gene symbols for a GO term of interest: "plasma lipoprotein particle clearance"
## Because we set readable = TRUE in enrichGO, geneID contains gene symbols.



## Map gene symbols to UniProt accessions


## ---------------------------------------------------------------------------------------------------------
## Challenge: Visualising abundances of plasma lipoprotein particle clearance proteins
##
## Use the UniProt IDs retrieved above to assess whether the protein abundances
## for the 'plasma lipoprotein particle clearance' proteins are reliable, then
## examine their abundance patterns across samples.
##
## 1. Use subsetByFeature to subset dia_qf to these proteins. Then plot the
##    precursor-level and protein-level abundances side by side across samples,
##    adapting the approach from lesson 05.
##
## 2. Plot a heatmap of the protein-level abundances for these proteins, with
##    samples annotated by group. Do the samples separate as you would expect
##    from the enrichment result?
##
## Hint: Pass rowvars = 'Genes' to longForm to carry gene names through to
## the plot, then facet by gene name and assay.
## ---------------------------------------------------------------------------------------------------------

uids <- g2p$UNIPROT