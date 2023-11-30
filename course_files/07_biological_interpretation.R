## =============================================================
## Lesson 07: GO analysis
## =============================================================


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
## Loading data from lesson 6
## ---------------------------------------------------------------------------------------------------------

load("preprocessed/lesson06.rda", verbose = TRUE)


## ---------------------------------------------------------------------------------------------------------
## Adding metadata to our results using dplyr 
## ---------------------------------------------------------------------------------------------------------

## Add master protein descriptions to our data
protein_info <- all_proteins %>%
  rowData() %>%
  as_tibble() %>%
  select(protein = Master.Protein.Accessions, 
         protein_description = Master.Protein.Descriptions)

## Protein info
protein_info %>% head()

## Add to our data using left.join
M_Desynch_results <- M_Desynch_results %>% 
  left_join(protein_info, by = "protein")


## ---------------------------------------------------------------------------------------------------------
## Subset differentially abundant proteins
## ---------------------------------------------------------------------------------------------------------

# Let’s subset our results and only keep proteins which have been flagged as 
# exhibiting significant abundance changes

sig_changing <- M_Desynch_results %>% 
  as_tibble() %>%
  filter(significance == "sig")

sig_up <- sig_changing %>%
  filter(direction == "up")

sig_down <- sig_changing %>%
  filter(direction == "down")


## Look at descriptions of proteins upregulated in M relative to deysnchronized cells
sig_up %>%
  pull(protein_description) %>%
  head()




## ---------------------------------------------------------------------------------------------------------
## GO analysis with enrichGO
## ---------------------------------------------------------------------------------------------------------

## Perform analysis
ego_up <- enrichGO(gene = sig_up$protein,                 # list of up proteins
                   universe = M_Desynch_results$protein,  # all proteins 
                   OrgDb = org.Hs.eg.db,                  # database to query
                   keyType = "UNIPROT",                   # protein ID encoding
                   pvalueCutoff = 0.05, 
                   qvalueCutoff = 0.05, 
                   readable = TRUE)



## Generate a dot plot 
dotplot(ego_up, 
        x = "Count", 
        showCategory = 15, 
        font.size = 10,
        color = "p.adjust")

