## =============================================================
## Lesson 05: Exploration and visualisation of protein data
## =============================================================


## ---------------------------------------------------------------------------------------------------------
## Load R/Bioconductor libraries
## ---------------------------------------------------------------------------------------------------------

library("QFeatures")
library("factoextra")
library("tidyr")
library("dplyr")
library("tibble")
library("ggplot2")
library("ggrepel")
library("ggbeeswarm")
library("patchwork")


## ---------------------------------------------------------------------------------------------------------
## Load data from previous lesson
## ---------------------------------------------------------------------------------------------------------



## ---------------------------------------------------------------------------------------------------------
## Plotting quantification values for proteins of interest
## ---------------------------------------------------------------------------------------------------------

## Convert normalised protein-level data to long format, carrying across
## both sample-level and feature-level metadata for plotting.


## Plot abundance of three proteins of interest across groups
proteins_of_interest <- c('P02766', # TTR (Transthyretin)
                          'P18428',  # LBP (Lipopolysaccharide binding protein)
                          'P13796')  # LCP1 (Lymphocyte cytosolic protein 1)

# plot
long_form_protein %>%
  filter(UniprotID %in% proteins_of_interest) %>%
  ggplot(aes(x = group, y = value, fill = group)) +
  geom_point() +
  facet_wrap(~Genes, scales = 'free')


## ---------------------------------------------------------------------------------------------------------
## Principal Component Analysis (PCA)
## ---------------------------------------------------------------------------------------------------------

## PCA requires a complete data matrix, so we first remove proteins with
## any missing values using filterNA before calling prcomp.

## Scree plot

## PCA plot coloured by group and shaped by age group


## ---------------------------------------------------------------------------------------------------------
## The subsetByFeature function
## ---------------------------------------------------------------------------------------------------------

## subsetByFeature returns a new QFeatures object containing only the data
## for a specified feature across all assay levels.



## Visualise how precursor data was aggregated to protein level for TTR

## Centre the values per precursor to make profile similarity clearer

