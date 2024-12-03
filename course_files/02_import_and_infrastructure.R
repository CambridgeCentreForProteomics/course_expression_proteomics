## ================================================
## Lesson 02: Import and infrastructure
## ================================================


## ---------------------------------------------------------------------------------------------------------
## Load R/Bioconductor libraries
## ---------------------------------------------------------------------------------------------------------

library("QFeatures")
library("tidyverse")




## ---------------------------------------------------------------------------------------------------------
## Create a directory to store your analysis results
## ---------------------------------------------------------------------------------------------------------

## Please check you are in the correct working directory and create a
## subdirectory called ouptut to store your analysis results

dir.create("output", showWarnings = FALSE)



## ---------------------------------------------------------------------------------------------------------
## Import data into QF object
## ---------------------------------------------------------------------------------------------------------

df <- read.delim("data/cell_cycle_total_proteome_analysis_PSMs.txt")

df %>%
  names()

cc_qf <- readQFeatures(assayData = df,
                       quantCols = 47:56, 
                       name = "psms_raw")


## ---------------------------------------------------------------------------------------------------------
## Extract the rowData and find information
## ---------------------------------------------------------------------------------------------------------

rd <- cc_qf[["psms_raw"]] %>% 
  rowData()

rd %>%
  as_tibble() %>%
  pull(Sequence) %>%
  unique() %>%
  length() 



## ---------------------------------------------------------------------------------------------------------
## Read in some information to add to the empty colData
## ---------------------------------------------------------------------------------------------------------

## Read in coldata .csv
metadata_df <- read.csv("data/samples_meta_data.csv")

## Annotate colData with sample, replicate, condition and tag nformation
cc_qf$sample <- metadata_df$sample
cc_qf$rep <- metadata_df$rep
cc_qf$condition <- metadata_df$condition
cc_qf$tag <- metadata_df$tag

## Apply this to the first assay so that it is carried up
colData(cc_qf[["psms_raw"]]) <- colData(cc_qf)



## ---------------------------------------------------------------------------------------------------------
## Change col names to represent the sample
## ---------------------------------------------------------------------------------------------------------

colnames(cc_qf[["psms_raw"]]) <- cc_qf$sample




