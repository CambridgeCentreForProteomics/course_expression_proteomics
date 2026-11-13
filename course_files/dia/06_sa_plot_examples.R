# FOR COURSE AUTHORS ONLY. Participants should not run this script.
# It generates materials/_shared/figs/sa_plot_examples.png, which lesson 06
# displays; the lesson does not need it to be run.
#
# SA plots for the baseline analysis and two examples of poor preprocessing.
#
# Each scenario starts from the normalised protein-level data in
# preprocessed/lesson04.rda, applies one manipulation, refits the limma model
# and draws plotSA. Scenario 0 is the analysis from lesson 06. Scenarios 1 and 2
# replace missing or low values with imputed values that are not measurements.
#
# Usage (from course_files/dia):
#   Rscript 06_sa_plot_examples.R <output_directory>

suppressPackageStartupMessages({
  library("QFeatures")
  library("limma")
  library("MsCoreUtils")
})

args <- commandArgs(trailingOnly = TRUE)
out_dir <- if (length(args) >= 1) args[1] else "sa_plot_examples"
dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)

set.seed(42)

load("preprocessed/lesson04.rda", verbose = TRUE)

group <- factor(dia_qf$group, levels = c("control", "MPXV", "Covid19"))
design <- model.matrix(~ 0 + group)
colnames(design) <- levels(group)

contrasts_matrix <- makeContrasts(
  MPXV_control = MPXV - control,
  Covid19_control = Covid19 - control,
  levels = design
)

# --- Helpers ----------------------------------------------------------------

# Proteins quantified in at least `min_n` samples of every group
replicated <- function(x, min_n = 3) {
  keep <- rep(TRUE, nrow(x))
  for (g in levels(group)) {
    keep <- keep & rowSums(!is.na(x[, group == g, drop = FALSE])) >= min_n
  }
  x[keep, , drop = FALSE]
}

# limma fit with the settings used in lesson 06
fit_limma <- function(x) {
  fit <- lmFit(x, design)
  fit <- contrasts.fit(fit, contrasts_matrix)
  eBayes(fit, trend = TRUE, robust = TRUE)
}

# --- Scenarios ----------------------------------------------------------------

# Median-normalised log2 protein abundances in proteins quantified in at least
# 3 samples of every group
base <- replicated(assay(dia_qf[["norm_proteins"]]))

scenarios <- list()

# 0. Lesson 06 analysis
scenarios[["s0_baseline"]] <- list(
  title = "0. Baseline",
  fit = fit_limma(base)
)

# 1. Values below the 10th percentile of all abundances set to missing, then
# imputed with MinDet, which replaces missing values in each sample with a low
# quantile of that sample
decile_removed <- base
decile_removed[decile_removed < quantile(base, 0.1, na.rm = TRUE)] <- NA
scenarios[["s1_decile_mindet"]] <- list(
  title = "1. Bottom decile, MinDet",
  fit = fit_limma(impute_matrix(decile_removed, method = "MinDet"))
)

# 2. 10% of values set to missing at random, then replaced by zero on the
# log2 scale
random_na <- base
random_na[sample(length(random_na), round(0.1 * length(random_na)))] <- NA
scenarios[["s2_random_na_zero"]] <- list(
  title = "2. 10% random NA, zero",
  fit = fit_limma(impute_matrix(random_na, method = "zero"))
)

# --- Summary --------------------------------------------------------------------

summary_table <- do.call(rbind, lapply(names(scenarios), function(nm) {
  fit <- scenarios[[nm]]$fit
  data.frame(
    scenario = nm,
    n_proteins = nrow(fit),
    median_sqrt_sigma = median(sqrt(fit$sigma), na.rm = TRUE),
    median_df_prior = median(fit$df.prior),
    # Proteins whose prior degrees of freedom were reduced by robust eBayes
    n_downweighted = sum(fit$df.prior < max(fit$df.prior), na.rm = TRUE)
  )
}))
print(summary_table, row.names = FALSE, digits = 3)
write.csv(summary_table, file.path(out_dir, "sa_plot_examples_summary.csv"),
          row.names = FALSE)

# --- Plots ------------------------------------------------------------------------

draw_sa <- function(sc) {
  plotSA(sc$fit, cex = 0.5, xlab = "Average log2 abundance", main = sc$title)
}

# One file per scenario
for (nm in names(scenarios)) {
  png(file.path(out_dir, paste0(nm, ".png")),
      width = 5, height = 4, units = "in", res = 150)
  draw_sa(scenarios[[nm]])
  dev.off()
}

# All scenarios in one row
png(file.path(out_dir, "sa_plot_examples_grid.png"),
    width = 5 * length(scenarios), height = 4, units = "in", res = 150)
par(mfrow = c(1, length(scenarios)))
for (sc in scenarios) draw_sa(sc)
dev.off()

message("Wrote ", length(scenarios), " plots and a grid to ", out_dir)
