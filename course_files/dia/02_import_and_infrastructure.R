## ================================================
## Lesson 02: Import and infrastructure
## ================================================


## ---------------------------------------------------------------------------------------------------------
## Load R/Bioconductor libraries
## ---------------------------------------------------------------------------------------------------------

library("arrow")
library("readxl")
library("QFeatures")
library("tidyr")
library("dplyr")
library("ggplot2")
library("patchwork")


## ---------------------------------------------------------------------------------------------------------
## Read the DIA-NN parquet report
## ---------------------------------------------------------------------------------------------------------

## Inspect the dimensions and column names


## ---------------------------------------------------------------------------------------------------------
## Import sample metadata
## ---------------------------------------------------------------------------------------------------------


## ---------------------------------------------------------------------------------------------------------
## Clean Run names
## ---------------------------------------------------------------------------------------------------------

## DIA-NN pastes the .wiff2 folder and .wiff.scan filenames together in the Run column.
## We strip everything from the first "." onwards to match the metadata sample_id field.

print(head(unique(diann_df$Run), 2))

## Merge the runCol label from the metadata into the DIA-NN data frame



dim(diann_df)
names(diann_df)


## ---------------------------------------------------------------------------------------------------------
## Read into a QFeatures object
## ---------------------------------------------------------------------------------------------------------



## ---------------------------------------------------------------------------------------------------------
## Exploring the QFeatures object
## ---------------------------------------------------------------------------------------------------------


## ---------------------------------------------------------------------------------------------------------
## Challenge 1: Precursors per sample
##
## 1. Find a function to determine how many precursors are quantified in each
##    sample. Use it to plot a histogram of precursor counts across samples.
##
## 2. Create a bar plot showing the number of precursors identified in each
##    sample, coloured by group. Which group tends to have the most precursors
##    identified? Is there any sample that looks like an outlier?
##
## Hint: Browse the QFeatures documentation with ?QFeatures to find a suitable
## function for obtaining per-sample feature counts.
## ---------------------------------------------------------------------------------------------------------




## ---------------------------------------------------------------------------------------------------------
## Exploring rowData quality metrics
## ---------------------------------------------------------------------------------------------------------

## rbindRowData collects rowData from all per-sample sets into a single data frame.
## Merge with colData to get group information for plotting.



## Plot FWHM distribution per sample, coloured by group

rdata %>%
  ggplot(aes(FWHM, group = Run, colour = group)) +
  geom_density() +
  theme_classic()


## ---------------------------------------------------------------------------------------------------------
## Challenge 2: Exploring rowData quality metrics
##
## The rdata object contains many columns from the DIA-NN rowData beyond FWHM.
##
## 1. Use str(rdata) to identify other numerical quality metric columns.
## 2. Choose one metric and create a plot to visualise its distribution
##    across samples, coloured by group.
## 3. Do any metrics appear to differ systematically between groups, or
##    between individual samples?
## ---------------------------------------------------------------------------------------------------------



