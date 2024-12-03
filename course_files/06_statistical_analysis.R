## =============================================================
## Lesson 06: Statistical analysis
## =============================================================


## ---------------------------------------------------------------------------------------------------------
## Load R/Bioconductor libraries
## ---------------------------------------------------------------------------------------------------------
library("QFeatures")
library("tidyverse")
library("pheatmap")
library("limma")


## ---------------------------------------------------------------------------------------------------------
## Loading data from lesson 4
## ---------------------------------------------------------------------------------------------------------

load("preprocessed/lesson04.rda", verbose = TRUE)


## ---------------------------------------------------------------------------------------------------------
## Extracting the data
## ---------------------------------------------------------------------------------------------------------

## Extract protein list from our QFeatures object - remove sample 1 
all_proteins <- cc_qf[["log_norm_proteins"]]
all_proteins <- all_proteins[, all_proteins$condition %in% c("M", "G1")]

## Ensure that conditions are stored as levels of a factor 
## Explicitly define level order by cell cycle stage
all_proteins$condition <- factor(all_proteins$condition, 
                                 levels = c("M", "G1"))



## ---------------------------------------------------------------------------------------------------------
## Limma: setting up a design matrix
## ---------------------------------------------------------------------------------------------------------

## Design a matrix containing all factors that we wish to model
condition <- all_proteins$condition

m_design <- model.matrix(~ condition)



## ---------------------------------------------------------------------------------------------------------
## Limma: fitting a linear model
## ---------------------------------------------------------------------------------------------------------

## Fit linear model using the design matrix 
fit_model <- lmFit(object = assay(all_proteins), design = m_design)



## ---------------------------------------------------------------------------------------------------------
## Limma: updating using eBayes
## ---------------------------------------------------------------------------------------------------------

final_model <- eBayes(fit = fit_model, 
                      trend = TRUE,
                      robust = TRUE)



## ---------------------------------------------------------------------------------------------------------
## Limma: accessing the results
## ---------------------------------------------------------------------------------------------------------

# Using topTable to extracts the top-ranked proteins from model
# Note coef = NULL and ANOVA performed

limma_results <- topTable(fit = final_model,   
                          coef = "conditionG1", 
                          adjust.method = "BH",    # Method for multiple hypothesis testing
                          number = Inf) %>%        # Print results for all proteins
  rownames_to_column("Protein") 



## Plot a SA plot to display the residual SD (sigma) versus log abundance 
## for each protein to which our model was  fitted
plotSA(fit = final_model,
       cex = 0.5,
       xlab = "Average log2 abundance")


## Plot a histogram of the raw p-values (not BH-adjusted p-values).
limma_results %>%
  as_tibble() %>%
  ggplot(aes(x = P.Value)) + 
  geom_histogram()


## ---------------------------------------------------------------------------------------------------------
## Limma: Interpreting the results 
## ---------------------------------------------------------------------------------------------------------

## Take a look at the results of our tests
limma_results %>% head()

## ---------------------------------------------------------------------------------------------------------
## Adding significance thresholds
## ---------------------------------------------------------------------------------------------------------

## Define significance based on an adj.P.Val < 0.01.
limma_results <- 
  limma_results %>%
  mutate(direction = ifelse(logFC > 0, "up", "down"),
         significance = ifelse(adj.P.Val < 0.01, "sig", "not.sig"))




## ---------------------------------------------------------------------------------------------------------
## Visualisation - Volcano plots
## ---------------------------------------------------------------------------------------------------------

## Generate a volcano plot
limma_results %>%
  ggplot(aes(x = logFC, y = -log10(P.Value), fill = significance)) +
  geom_point(shape = 21, stroke = 0.25, size = 3) +
  theme_bw()


## ---------------------------------------------------------------------------------------------------------
## Challenge - Volcano plots: playing with thresholds
## ---------------------------------------------------------------------------------------------------------

# Re-generate your volcano plot defining significance based on an adjusted 
# P-value < 0.05 and a log2 fold-change of > 1.


## --------------------------------------------------------------------------------------------------------
## Fold-change thresholds 
## --------------------------------------------------------------------------------------------------------

## Use treat to specify fold change threshold for statistical testing
final_model_treat <- treat(final_model, 
                           lfc = 0.5,
                           trend = TRUE, 
                           robust = TRUE)

limma_results_treat <- topTreat(final_model_treat, 
                                coef = "conditionG1",
                                n = Inf) %>%
  rownames_to_column("Protein")

## ---------------------------------------------------------------------------------------------------------
## Challenge - Compare logFC thresholding post-hoc with LogFC null hypothesis
## ---------------------------------------------------------------------------------------------------------

# - Compare the overall results for each logFC thresholding approach by creating a 2 x 2 table
# with the number of proteins with increased/decreased abundance and significant/not significant change,
# for each approach.
# - Identify the proteins which are significant when thresholding on the logFC post-hoc, 
# but not when using the TREAT functions to define a logFC threshold for the null hypothesis. 
# - Re-make the volcano plots for the two logFC thresholding approaches, but this time with the proteins
# identified above highlighted by the point shape.


## --------------------------------------------------------------------------------------------------------
## Visualisation - heatmaps
## --------------------------------------------------------------------------------------------------------

## Extract significantly changing proteins
sig_proteins <- limma_results %>%
  filter(significance == "sig") %>%
  pull(Protein)

## Extract quant data for the significant proteins
quant_data <- cc_qf[["log_norm_proteins"]] 
quant_data <- quant_data[sig_proteins, ] %>% assay()

## Plot heatmap
pheatmap(mat = quant_data, 
         scale = "row",
         show_rownames = FALSE)
