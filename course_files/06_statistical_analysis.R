## =============================================================
## Lesson 06: Statistical analysis
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
## Loading data from lesson 4
## ---------------------------------------------------------------------------------------------------------

load("preprocessed/lesson04.rda", verbose = TRUE)



## ---------------------------------------------------------------------------------------------------------
## Extracting the data
## ---------------------------------------------------------------------------------------------------------

## Extract protein list from our QFeatures object - remove sample 1 
all_proteins <- cc_qf[["log_norm_proteins"]][, -1]

## Ensure that conditions are stored as levels of a factor 
## Explicitly define level order by cell cycle stage
all_proteins$condition <- factor(all_proteins$condition, 
                                 levels = c("Desynch", "M", "G1"))



## ---------------------------------------------------------------------------------------------------------
## Limma: setting up a design matrix
## ---------------------------------------------------------------------------------------------------------

## Design a matrix containing all factors that we wish to model
m_design <- model.matrix(~ 0 + all_proteins$condition)
colnames(m_design) <- levels(all_proteins$condition)



## ---------------------------------------------------------------------------------------------------------
## Limma: setting up contrasts of interest
## ---------------------------------------------------------------------------------------------------------

## Specify contrasts of interest
contrasts <- makeContrasts(G1_M = G1 - M, 
                           M_Des = M - Desynch, 
                           G1_Des = G1 - Desynch,
                           levels = m_design)



## ---------------------------------------------------------------------------------------------------------
## Limma: fitting a linear model
## ---------------------------------------------------------------------------------------------------------

## Fit linear model using the design matrix and desired contrasts
fit_model <- lmFit(object = assay(all_proteins), design = m_design)
fit_contrasts <- contrasts.fit(fit = fit_model, contrasts = contrasts)


## ---------------------------------------------------------------------------------------------------------
## Limma: updating using eBayes
## ---------------------------------------------------------------------------------------------------------

final_model <- eBayes(fit = fit_contrasts, 
                      trend = TRUE,
                      robust = TRUE)



## ---------------------------------------------------------------------------------------------------------
## Limma: accessing the results
## ---------------------------------------------------------------------------------------------------------

# Using topTable to extracts the top-ranked proteins from model
# Note coef = NULL and ANOVA performed

limma_results <- topTable(fit = final_model,   
                          coef = NULL, 
                          adjust.method = "BH",    # Method for multiple hypothesis testing
                          number = Inf) %>%        # Print results for all proteins
  rownames_to_column("Protein") 



## Plot a histogram of the raw p-values (not BH-adjusted p-values).
limma_results %>%
  as_tibble() %>%
  ggplot(aes(x = P.Value)) + 
  geom_histogram()



## Plot a SA plot to display the residual SD (sigma) versus log abundance 
## for each protein to which our model was  fitted
plotSA(fit = final_model,
       cex = 0.5,
       xlab = "Average log2 abundance")


## ---------------------------------------------------------------------------------------------------------
## Limma: Interpreting the results of a SINGLE contrast
## ---------------------------------------------------------------------------------------------------------

## We can look at individual contrasts by passing the contrast name to 
## the coef argument in the topTable function.
M_Desynch_results <- topTable(fit = final_model, 
                              coef = "M_Des", 
                              number = Inf,
                              adjust.method = "BH",
                              confint = TRUE) %>%
  rownames_to_column("protein")



## ---------------------------------------------------------------------------------------------------------
## Limma: Interpreting the results of ALL contrasts
## ---------------------------------------------------------------------------------------------------------
decideTests(object = final_model,
            adjust.method = "BH", 
            p.value = 0.01, 
            method = "separate") %>%
  summary()



M_Desynch_results %>%
  as_tibble() %>%
  filter(adj.P.Val < 0.01) %>% 
  nrow()


decideTests(object = final_model,
            adjust.method = "BH", 
            p.value = 0.01, 
            method = "global") %>%
  summary()



## Determine global significance using decideTests
global_sig <- decideTests(object = final_model, 
                          adjust.method = "BH", 
                          p.value = 0.01, 
                          method = "global") %>%
  as.data.frame() %>% 
  rownames_to_column("protein")


## Change column names to avoid conflict when binding
colnames(global_sig) <- paste0("sig_", colnames(global_sig))

## Add the results of global significance test to overall ANOVA results
limma_results <- dplyr::left_join(limma_results, 
                                  global_sig, 
                                  by = c("Protein" = "sig_protein"))

## Verify
limma_results %>% head()

## ---------------------------------------------------------------------------------------------------------
## Adding significance thresholds
## ---------------------------------------------------------------------------------------------------------

## Define significance based on an adj.P.Val < 0.01.
M_Desynch_results <- 
  M_Desynch_results %>%
  as_tibble() %>%
  mutate(direction = ifelse(logFC > 0, "up", "down"),
         significance = ifelse(adj.P.Val < 0.01, "sig", "not.sig"))




## ---------------------------------------------------------------------------------------------------------
## Visualisation - Volcano plots
## ---------------------------------------------------------------------------------------------------------

## Generate a volcano plot
M_Desynch_results %>%
  ggplot(aes(x = logFC, y = -log10(P.Value), fill = significance)) +
  geom_point(shape = 21, stroke = 0.25, size = 3) +
  theme_bw()


## ---------------------------------------------------------------------------------------------------------
## Challenge - playing with thresholds
## ---------------------------------------------------------------------------------------------------------

# Re-generate your table of results defining significance based on an adjusted 
# P-value < 0.05 and a log2 fold-change of > 1.

