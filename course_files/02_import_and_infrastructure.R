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
## subdirectory called output to store your analysis results

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
## Accessing and indexing SEs/datasets
## ---------------------------------------------------------------------------------------------------------



## ---------------------------------------------------------------------------------------------------------
## The quantitation data
## ---------------------------------------------------------------------------------------------------------



## ---------------------------------------------------------------------------------------------------------
## Challenge 1: Accessing information
##
## Explore the QFeatures object you have just created.
## 1. How many sets/SEs do we currently have in the QF object?
## 2. How many PSMs have been identified in the data?
## 3. How do you access and view the quantitation/abundance?
##
## ---------------------------------------------------------------------------------------------------------




## ---------------------------------------------------------------------------------------------------------
## The rowData container
## ---------------------------------------------------------------------------------------------------------

cc_qf[["psms_raw"]] %>% 
  rowData()



## ---------------------------------------------------------------------------------------------------------
## Challenge 2: Calculating the number of peptides
## and proteins of in the dataset
##
## Explore the information stored in the rowData from the 
## Proteome Discoverer search.
##
## 1. What class is the rowData container? 
##    How many rows and columns are in this data structure?
##
## 2. (i) Extract the rowData and convert it to a tibble or data.frame
##    (ii) Find a column that contains the peptide sequence.
##    (iii) Pull and find how many unique peptide sequences we have
##
## 3. How many protein groups (master proteins) are there?
## ---------------------------------------------------------------------------------------------------------




## ---------------------------------------------------------------------------------------------------------
## The colData slot
## ---------------------------------------------------------------------------------------------------------

cc_qf[["psms_raw"]] %>%
  colData()

## Read in coldata .csv
metadata_df <- read.csv("data/samples_meta_data.csv")

## Annotate the global colData with experiment info
colData(cc_qf) <- metadata_df

## Annotate the first SE/set with experiment info
colData(cc_qf[["psms_raw"]]) <- colData(cc_qf)



## ---------------------------------------------------------------------------------------------------------
## Change col names to represent the sample
## ---------------------------------------------------------------------------------------------------------

colnames(cc_qf[["psms_raw"]]) <- cc_qf$sample



## ---------------------------------------------------------------------------------------------------------
## Challenge 3: Miscleavages
##
## One of the pieces of information given by the 3rd party
## software used is the number of missed cleavages. This is 
## stored in a rowData column named "Number.of.Missed.Cleavages". 
##
## Can you count how many occurrences of missed cleavages 
## there are in our data?
## ---------------------------------------------------------------------------------------------------------



