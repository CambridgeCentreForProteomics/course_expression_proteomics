## ================================================
## Lesson 03: Data cleaning
## ================================================


## ---------------------------------------------------------------------------------------------------------
## Load R/Bioconductor libraries
## ---------------------------------------------------------------------------------------------------------
library("QFeatures")
library("tidyverse")



## ---------------------------------------------------------------------------------------------------------
## Loading data from previous lesson
## ---------------------------------------------------------------------------------------------------------

load("preprocessed/lesson02.rda", verbose = TRUE)


## ---------------------------------------------------------------------------------------------------------
## Add a new data level for filtering
## ---------------------------------------------------------------------------------------------------------

## Extract a copy of the raw PSM-level data
raw_data_copy <- cc_qf[["psms_raw"]] 

## Re-add the assay to our QFeatures object with a new name
cc_qf <- addAssay(x = cc_qf, 
                  y = raw_data_copy, 
                  name = "psms_filtered")



## ---------------------------------------------------------------------------------------------------------
## Challenge 1 - contaminants
## ---------------------------------------------------------------------------------------------------------

# Use the `filterFeatures` function to filter out common contaminants that have 
# been flagged during the identification search. How many PSMs are left after
# this step?



## ---------------------------------------------------------------------------------------------------------
## Challenge 2 - PSM ranking
## ---------------------------------------------------------------------------------------------------------

# Since individual spectra can have multiple candidate PSMs, Proteome Discoverer
# uses a scoring algorithm to determine the probability of a PSM being incorrect.
# Once each candidate PSM has been given a score, the one with the lowest score
# (lowest probability of being incorrect) is allocated rank 1. The PSM with the
# second lowest probability of being incorrect is rank 2, and so on. For the
# analysis, we only want rank 1 PSMs to be retained. The majority of search
# engines, including SequestHT (used in this analysis), also provide their own PSM
# rank. To be conservative and ensure accurate quantitation, we also only retain
# PSMs that have a search engine rank of 1.
# 
# 1. Find the columns `Rank` and `Search.Engine.Rank` in the dataset and tabulate 
# how many PSMs we have at each level
# 
# 2. Use `filterFeatures` and keep,
# * PSMs with a `Rank` of 1
# * PSMs with a `Search.Engine.Rank` of 1
# * High confidence PSMs that have been unambiguously assigned



## ---------------------------------------------------------------------------------------------------------
## Filtering in one go
## ---------------------------------------------------------------------------------------------------------

cc_qf <- cc_qf %>% 
  filterFeatures(~ Master.Protein.Accessions != "", i = "psms_filtered") %>% 
  filterFeatures(~ Contaminant != "True", i = "psms_filtered") %>% 
  filterFeatures(~ Rank == 1, i = "psms_filtered") %>%
  filterFeatures(~ Search.Engine.Rank == 1, i = "psms_filtered") %>%
  filterFeatures(~ PSM.Ambiguity == "Unambiguous", i = "psms_filtered") %>% 
  filterFeatures(~ Number.of.Protein.Groups == 1, i = "psms_filtered") %>% 
  filterFeatures(~ Average.Reporter.SN >= 10, na.rm = TRUE, i = "psms_filtered") %>%
  filterFeatures(~ Isolation.Interference.in.Percent <= 75, na.rm = TRUE, i = "psms_filtered") %>%
  filterFeatures(~ SPS.Mass.Matches.in.Percent >= 65, na.rm = TRUE, i = "psms_filtered")


## ---------------------------------------------------------------------------------------------------------
## Protein FDR: Import and add protein level FDR information
## ---------------------------------------------------------------------------------------------------------

## Import protein output from database search
protein_data_PD <- read.delim(file = "data/cell_cycle_total_proteome_analysis_Proteins.txt")


## Extract the rowData and convert to a data.frame
psm_data_QF <- 
  cc_qf[["psms_filtered"]] %>% 
  rowData() %>% 
  as.data.frame()


## Select only the Accession and FDR info
protein_data_PD <- 
  protein_data_PD %>% 
  select(Accession, Protein.FDR.Confidence.Combined)


## Use left.join from dplyr to add the FDR data to PSM rowData data.frame 
fdr_confidence <- left_join(x = psm_data_QF,  
                            y = protein_data_PD,
                            by = c("Master.Protein.Accessions" = "Accession")) %>% 
  pull("Protein.FDR.Confidence.Combined")


## Now add this data to the QF object
rowData(cc_qf[["psms_filtered"]])$Protein.FDR.Confidence <- fdr_confidence


## ---------------------------------------------------------------------------------------------------------
## Filter on FDR
## ---------------------------------------------------------------------------------------------------------

cc_qf <- cc_qf %>%
  filterFeatures(~ Protein.FDR.Confidence == "High", 
                 i = "psms_filtered")




## ---------------------------------------------------------------------------------------------------------
## Missing values
## ---------------------------------------------------------------------------------------------------------

## Using the nNA function
nNA(cc_qf, i = "psms_filtered")

## Examining missing values in each data level
mv_raw <- nNA(cc_qf, i = "psms_raw")
mv_filtered <- nNA(cc_qf, i = "psms_filtered")


## Plotting missing data
mv_raw$nNAcols %>%
  as_tibble() %>%
  mutate(condition = colData(cc_qf)$condition) %>%
  ggplot(aes(x = name, y = pNA, group = condition, fill = condition)) +
  geom_bar(stat = "identity") +
  labs(x = "Sample", y = "Proportion missing values") + 
  theme_bw()


mv_filtered$nNAcols %>%
  as_tibble() %>%
  mutate(condition = colData(cc_qf)$condition) %>%
  ggplot(aes(x = name, y = pNA, group = condition, fill = condition)) +
  geom_bar(stat = "identity") +
  labs(x = "Sample", y = " Proportion missing values") +
  theme_bw()


## ---------------------------------------------------------------------------------------------------------
## Challenge 3 - missing values
## ---------------------------------------------------------------------------------------------------------

# How many PSMs do we have with (i) 0 missing values, (ii) 1 missing value, (iii) 
# 2 or more missing values, across samples, before and after filtering?



## ---------------------------------------------------------------------------------------------------------
## Using filterNA 
## ---------------------------------------------------------------------------------------------------------

cc_qf <- cc_qf %>%
  filterNA(pNA = 0, i = "psms_filtered")


