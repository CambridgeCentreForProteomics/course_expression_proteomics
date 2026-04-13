## =============================================================
## Lesson 05: Exploration and visualisation of protein data 
## =============================================================


## ---------------------------------------------------------------------------------------------------------
## Load R/Bioconductor libraries
## ---------------------------------------------------------------------------------------------------------
library("QFeatures")
library("tidyverse")
library("factoextra")

## ---------------------------------------------------------------------------------------------------------
## Loading data from previous lesson
## ---------------------------------------------------------------------------------------------------------

load("preprocessed/lesson04.rda", verbose = TRUE)

## Part 1 - assay links
## ---------------------------------------------------------------------------------------------------------
## Add explicit link between final protein data "log_norm_proteins"
## and raw PSM data "psms_raw", using "Master.Protein.Accessions"
## ---------------------------------------------------------------------------------------------------------

## Try plotting the object



## Use addAssayLink and re-plot the data




## Part 2 - 
## ---------------------------------------------------------------------------------------------------------
## Exploring the dimensions of our protein level data
## ---------------------------------------------------------------------------------------------------------

## Number of proteins
cc_qf[["log_norm_proteins"]] %>%
  nrow()






## ---------------------------------------------------------------------------------------------------------
## Challenge 1: Final PSM, peptide and protein count
## ---------------------------------------------------------------------------------------------------------

# Determine how many PSMs, peptides and proteins were lost 
# during processing of the raw data to our final list?

# Hint: 
# (i) start with calculating the number of PSMs, peptides 
# and proteins we have in "psms_raw". 
# (ii) Then examine the data level called "psms_filtered".

# e.g. to count peptides in "psms_raw"....

## proteins

## peptides ...

## PSMs ...





## Part 3 -
## ---------------------------------------------------------------------------------------------------------
## The .n column from aggreagtion of features
## ---------------------------------------------------------------------------------------------------------

# If we look at the names of the columns within our 
# "log_proteins" and "log_norm_proteins" assays we see 
# that there is a column called .n. 
# This column was not present in the PSM level assays.


## Check columns in the log normalised protein dataset
cc_qf[["log_norm_proteins"]] %>%
  rowData() %>%
  names()


## the .n column tells us how many peptides we have in 
## support of each protein in the final dataset. 




## ---------------------------------------------------------------------------------------------------------
## Challenge 2: Examining peptide support
## ---------------------------------------------------------------------------------------------------------

# (i)  Using the information we have in the .n column create a 
#      graph to visualise peptide support.



# (ii) What is,
#   - the maximum number of peptides we have available for 
#     one given protein?
#   - the most common number of peptides available for any
#     given protein?
#   - the median number of peptides available for any 
#     given protein?






## Part 4 - 
## ---------------------------------------------------------------------------------------------------------
## Subsetting by feature
## ---------------------------------------------------------------------------------------------------------

# The subsetByFeature function takes a QFeatures object as 
# its input and an additional argument specifying one or 
# more features of interest. The output is a new QFeatures 
# object with only data corresponding to the specified features.

## Protein O43583 



## We can use our new QFeatures object to create a plot 
## which displays how the PSM data was aggregated to protein 
## for this particular feature.

O43583[, , c("psms_filtered", "peptides", "proteins")] %>%
  longForm() %>%
  as_tibble() %>%
  mutate(assay_order = 
           factor(assay, levels = c("psms_filtered", 
                                    "peptides", 
                                    "proteins"))) %>%
  ggplot(aes(x = colname, y = log2(value), colour = assay)) + 
  geom_point() +
  geom_line(aes(group = rowname)) +
  theme(axis.text.x = element_text(angle = 45, size = 7)) +
  facet_wrap(~ assay_order)



## Part 5 -
## ---------------------------------------------------------------------------------------------------------
## Principal components analysis
## ---------------------------------------------------------------------------------------------------------

## Perform PCA using prcomp



## Scree plot



## Look at the PC matrix in "protein_pca$x"


## PCA plot





## ---------------------------------------------------------------------------------------------------------
## Challenge 3: PCA plot coloured by condition
## ---------------------------------------------------------------------------------------------------------

# 1. Generate a PCA plot of the data and colour by condition.
# 
#   Hint: To colour the points based on this condition we can use the tidyverse 
#   `mutate` function to add a column defining the condition of each sample and 
#   then use `colour = condition` within our ggplot aesthetics.</details>
#   
# 2. What does this plot tell us?
