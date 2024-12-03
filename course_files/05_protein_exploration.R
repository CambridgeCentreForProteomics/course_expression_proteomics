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


## ---------------------------------------------------------------------------------------------------------
## Add explicit link between final protein data and raw PSM data
## ---------------------------------------------------------------------------------------------------------

cc_qf <- addAssayLink(object = cc_qf, 
                      from = "psms_raw", 
                      to = "log_norm_proteins",
                      varFrom = "Master.Protein.Accessions",
                      varTo = "Master.Protein.Accessions")

## Verify
assayLink(x = cc_qf,
          i = "log_norm_proteins")

## ---------------------------------------------------------------------------------------------------------
## Exploring the dimensions of our protein level data
## ---------------------------------------------------------------------------------------------------------

## Number of proteins
cc_qf[["log_norm_proteins"]] %>%
  nrow()



## ---------------------------------------------------------------------------------------------------------
## Challenge 1: Final PSM, peptide and protein count
## ---------------------------------------------------------------------------------------------------------

# Determine how many PSMs, peptides and proteins were lost during processing of 
# the raw data to our final protein list?

# Hint: start with calculating the number of PSMs, peptides and proteins we
# have in "psms_raw". Then examine the data level called "psms_filtered".

# e.g. to count peptides in "psms_raw"....
peptide_count <- 
  cc_qf[["psms_raw"]] %>%
  rowData() %>%
  as_tibble() %>%
  pull(Sequence) %>%
  unique() %>%
  length() 




## ---------------------------------------------------------------------------------------------------------
## The .n column from aggreagtion of features
## ---------------------------------------------------------------------------------------------------------

# If we look at the names of the columns within our "log_proteins" and 
# "log_norm_proteins" assays we see that there is a column called .n. 
# This column was not present in the PSM level assays.


## Check columns in the log normalised protein assay
cc_qf[["log_norm_proteins"]] %>%
  rowData() %>%
  names()


## the .n column tells us how many peptides we have in support of each protein 
## in the final dataset. 
cc_qf[["log_norm_proteins"]] %>%
  rowData() %>%
  as_tibble() %>%
  pull(.n) %>%
  table()



## ---------------------------------------------------------------------------------------------------------
## Challenge 2: Examining peptide support
## ---------------------------------------------------------------------------------------------------------

# (i)  Using the information we have in the .n column create a graph to 
#      visualise peptide support.

# (ii) What is,
#   - the maximum number of peptides we have available for one given protein?
#   - the most common number of peptides available for any given protein?
#   - the median number of peptides available for any given protein?



## ---------------------------------------------------------------------------------------------------------
## Subsetting by feature
## ---------------------------------------------------------------------------------------------------------

# The subsetByFeature function take a QFeatures object as its input and an 
# additional argument specifying one or more features of interest.The output is
# a new QFeatures object with only data corresponding to the specified features.

O43583 <- subsetByFeature(cc_qf, "O43583")

experiments(O43583)


## We can use our new QFeatures object to create a plot which displays how the 
## PSM data was aggregated to protein for this particular feature.

O43583[, , c("psms_filtered", "peptides", "proteins")] %>%
  longFormat() %>%
  as_tibble() %>%
  mutate(assay_order = 
           factor(assay, levels = c("psms_filtered", "peptides", 
                                    "proteins"))) %>%
  ggplot(aes(x = colname, y = log2(value), colour = assay)) + 
  geom_point() +
  geom_line(aes(group = rowname)) +
  theme(axis.text.x = element_text(angle = 45, size = 7)) +
  facet_wrap(~ assay_order)



## ---------------------------------------------------------------------------------------------------------
## Principal components analysis
## ---------------------------------------------------------------------------------------------------------

## Perform PCA
protein_pca <- cc_qf[["log_norm_proteins"]] %>%
  assay() %>%
# filterNA() %>%
  t() %>%
  prcomp(scale = TRUE, center = TRUE)

summary(protein_pca)


## Scree plot
fviz_screeplot(protein_pca)


## PCA plot
protein_pca$x %>%
  as_tibble() %>%
  ggplot(aes(x = PC1, y = PC2)) +
  geom_point(size = 3) + 
  theme_bw()


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
