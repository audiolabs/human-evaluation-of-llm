# Load necessary libraries
library(dplyr)
library(pwr)

# Matrix fr Honesty
#combined_matrix_1_to_5 <- matrix(c(
#  27, 107, 100, 99,
#  39, 50, 67, 70,
#  44, 70, 50, 51,
#  62, 78, 66, 43
#), nrow = 4, byrow = TRUE)

# Matrix für Comprehensibility
#combined_matrix_6_to_10 <- matrix(c(
#  29, 99, 98, 91,
#  33, 51, 62, 63,
#  39, 65, 49, 48,
#  61, 77, 65, 41
#), nrow = 4, byrow = TRUE)

# Matrix für Total
combined_matrix <- matrix(c(
  56, 206, 198, 190,
  72, 101, 129, 133,
  83, 135, 99, 99,
  123, 155, 131, 84
), nrow = 4, byrow = TRUE)
rownames(combined_matrix) <- colnames(combined_matrix) <- c("Text_1+2", "Text_3+4", "Text_5+6", "Text_7+8")

# Berechnung der paarweisen Effektstärken (Cohen's h) und p-Werte für die kombinierten Texte
pairwise_results_combined <- list()
for (i in 1:(nrow(combined_matrix) - 1)) {
  for (j in (i + 1):ncol(combined_matrix)) {
    wins_i = combined_matrix[i, j]
    wins_j = combined_matrix[j, i]
    total_comparisons = wins_i + wins_j
    observed_proportion_i = wins_i / total_comparisons
    observed_proportion_j = wins_j / total_comparisons
    
    expected_proportion = 0.5
    
    effect_size_i = 2 * (asin(sqrt(observed_proportion_i)) - asin(sqrt(expected_proportion)))
    effect_size_j = 2 * (asin(sqrt(observed_proportion_j)) - asin(sqrt(expected_proportion)))
    
    p_value_i = 2 * (1 - pnorm(abs(effect_size_i), mean = 0, sd = sqrt(2 / total_comparisons)))
    p_value_j = 2 * (1 - pnorm(abs(effect_size_j), mean = 0, sd = sqrt(2 / total_comparisons)))
    
    pairwise_results_combined[[paste0(rownames(combined_matrix)[i], "_vs_", colnames(combined_matrix)[j])]] <- list(
      effect_size_i = effect_size_i,
      p_value_i = p_value_i,
      effect_size_j = effect_size_j,
      p_value_j = p_value_j
    )
  }
}

# Paarweise Vergleiche
for (comparison in names(pairwise_results_combined)) {
  result = pairwise_results_combined[[comparison]]
  cat(comparison, ":\n")
  cat("  Effect Size (", strsplit(comparison, "_vs_")[[1]][1], "):", result$effect_size_i, "\n")
  cat("  P-Value (", strsplit(comparison, "_vs_")[[1]][1], "):", result$p_value_i, "\n")
  cat("  Effect Size (", strsplit(comparison, "_vs_")[[1]][2], "):", result$effect_size_j, "\n")
  cat("  P-Value (", strsplit(comparison, "_vs_")[[1]][2], "):", result$p_value_j, "\n")
}


# Setze hier die Effektstärken ein, die gerade berechnet wurden!
effect_sizes <- c(0.5029524, 0.4216348, 0.2157269, -0.02272923, -0.07646338, -0.1395833)

# Mittelwert
mean_effect_size <- mean(abs(effect_sizes))  # Use absolute values

# Power Analyse
sample_size <- pwr.t.test(d = mean_effect_size, sig.level = 0.05, power = 0.8, type = "two.sample")$n

print(paste("Average Effect Size (Cohen's h):", round(mean_effect_size, 3)))
print(paste("Required Sample Size per Group:", ceiling(sample_size)))

