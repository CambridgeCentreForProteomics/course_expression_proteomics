## ================================================
## Lesson 04: Normalisation and aggregation
## ================================================


## ---------------------------------------------------------------------------------------------------------
## Load R/Bioconductor libraries
## ---------------------------------------------------------------------------------------------------------
library("QFeatures")
library("NormalyzerDE")
library("limma")
library("factoextra")
library("org.Hs.eg.db")
library("clusterProfiler")
library("enrichplot")
library("patchwork")
library("tidyverse")



## ---------------------------------------------------------------------------------------------------------
## Loading data from previous lesson
## ---------------------------------------------------------------------------------------------------------

load("preprocessed/lesson03.rda", verbose = TRUE)


## ---------------------------------------------------------------------------------------------------------
## Examine the relative abundance of the untransformed data
## ---------------------------------------------------------------------------------------------------------

## Raw
cc_qf[["psms_imputed"]] %>%
  assay() %>%
  longFormat() %>%
  ggplot(aes(x = value)) +
  geom_histogram() + 
  theme_bw() +
  xlab("Abundance (raw)")

## Log2
cc_qf[["psms_imputed"]] %>%
  assay() %>%
  longFormat() %>%
  ggplot(aes(x = log2(value))) +
  geom_histogram() + 
  theme_bw() +
  xlab("(Log2) Abundance")



## ---------------------------------------------------------------------------------------------------------
## Using the log transforming
## ---------------------------------------------------------------------------------------------------------

cc_qf <- logTransform(object = cc_qf, 
                      base = 2, 
                      i = "psms_imputed", 
                      name = "log_psms_imputed")



## ---------------------------------------------------------------------------------------------------------
## Feature aggregation
## ---------------------------------------------------------------------------------------------------------

## Aggregating PSM to peptides
cc_qf <- aggregateFeatures(cc_qf, 
                           i = "log_psms_imputed", 
                           fcol = "Sequence",
                           name = "log_peptides",
                           fun = MsCoreUtils::robustSummary,
                           na.rm = TRUE)


## Aggregating peptides to proteins

cc_qf <- aggregateFeatures(cc_qf, 
                           i = "log_peptides", 
                           fcol = "Master.Protein.Accessions",
                           name = "log_proteins",
                           fun = MsCoreUtils::robustSummary,
                           na.rm = TRUE)


## ---------------------------------------------------------------------------------------------------------
## Normalyzer  
## ---------------------------------------------------------------------------------------------------------

# The NormalyzerDE package provides a function called normalyzer which is useful 
# for getting an overview of how different normalisation methods perform on a 
# dataset. The normalyzer function however requires a raw intensity matrix as 
# input, prior to any log transformation.
 
## ---------------------------------------------------------------------------------------------------------
## CHALLENGE 1
## ---------------------------------------------------------------------------------------------------------

# Taking the your data from the psms_imputed level, create a new assay in your 
# QFeatures object (cc_qf) that aggregates the data from this level directly to 
# protein level. Call this assay "proteins_direct".
# 
# Run the normalyzer function on the newly created (un-transformed) protein 
# level data using the below code,

# normalyzer(jobName = "normalyzer",
#            experimentObj = cc_qf[["proteins_direct"]],
#            sampleColName = "sample",
#            groupColName = "condition",
#            outputDir = ".",
#            requireReplicates = FALSE)

# If your job is successful a new folder will be created in your working 
# directory called normalyzer. Take a look at the PDF report. What method do you 
# think is appropriate?
  

## ---------------------------------------------------------------------------------------------------------
## CHALLENGE 2
## ---------------------------------------------------------------------------------------------------------

# For this biological question we are not interested in peptide level data and
# wish to avoid the intermediate summarisation step of aggreagting PSMs to
# peptides. Take the log PSM data and aggregate the data straight to the protein 
# level. 




## ---------------------------------------------------------------------------------------------------------
## Normalisation
## ---------------------------------------------------------------------------------------------------------

cc_qf <- normalize(cc_qf, 
                   i = "log_proteins", 
                   name = "log_norm_proteins",
                   method = "center.median")



## ---------------------------------------------------------------------------------------------------------
## Challenge 3 
## ---------------------------------------------------------------------------------------------------------

# Create two boxplots pre- and post-normalisation to visualise the effect it has
# had on the data and add colour to distinguish between conditions.

