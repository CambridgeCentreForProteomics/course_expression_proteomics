## ================================================
## Lesson 04: Normalisation and aggregation
## ================================================


## ---------------------------------------------------------------------------------------------------------
## Load R/Bioconductor libraries
## ---------------------------------------------------------------------------------------------------------
library("QFeatures")
library("tidyverse")



## ---------------------------------------------------------------------------------------------------------
## Loading data from previous lesson
## ---------------------------------------------------------------------------------------------------------

load("preprocessed/lesson03.rda", verbose = TRUE)


## ---------------------------------------------------------------------------------------------------------
## Examine the relative abundance of the untransformed data
## ---------------------------------------------------------------------------------------------------------

## Raw
cc_qf[["psms_filtered"]] %>%
  assay() %>%
  longFormat() %>%
  ggplot(aes(x = value)) +
  geom_histogram() + 
  theme_bw() +
  xlab("Abundance (raw)")

## Log2
cc_qf[["psms_filtered"]] %>%
  assay() %>%
  longFormat() %>%
  ggplot(aes(x = log2(value))) +
  geom_histogram() + 
  theme_bw() +
  xlab("(Log2) Abundance")


## ---------------------------------------------------------------------------------------------------------
## Feature aggregation
## ---------------------------------------------------------------------------------------------------------

## Aggregating PSM to peptides
cc_qf <- aggregateFeatures(cc_qf, 
                           i = "psms_filtered",    # data 
                           fcol = "Sequence",      # how do we want to aggregate?
                           name = "peptides",      # new assay name
                           fun = base::colSums,    # robust method (NAs excluded before fit)
                           na.rm = TRUE)           # ignore NA values when summarising 


## Aggregating peptides to proteins

cc_qf <- aggregateFeatures(cc_qf, 
                           i = "peptides", 
                           fcol = "Master.Protein.Accessions",
                           name = "proteins",
                           fun = base::colSums,
                           na.rm = TRUE)


## ---------------------------------------------------------------------------------------------------------
## Log transformation
## ---------------------------------------------------------------------------------------------------------

cc_qf <- logTransform(object = cc_qf, 
                      base = 2, 
                      i = "proteins", 
                      name = "log_proteins")


## ---------------------------------------------------------------------------------------------------------
## Normalisation
## ---------------------------------------------------------------------------------------------------------

cc_qf <- normalize(cc_qf, 
                   i = "log_proteins", 
                   name = "log_norm_proteins",
                   method = "center.median")



## ---------------------------------------------------------------------------------------------------------
## Challenge 2 
## ---------------------------------------------------------------------------------------------------------

# Create two boxplots pre- and post-normalisation to visualise the effect it has
# had on the data and add colour to distinguish between conditions.

