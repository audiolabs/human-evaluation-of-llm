
library(dplyr)
library(pwr)

#Total
win_loss_matrix <- matrix(c(
  0, 22, 6, 49, 5, 45, 3, 47,
  5, 0, 2, 50, 1, 49, 1, 48,
  13, 26, 0, 50, 9, 49, 12, 47,
  0, 0, 0, 0, 0, 9, 0, 11,
  11, 31, 12, 50, 0, 50, 3, 47,
  1, 1, 1, 7, 0, 0, 1, 0,
  32, 28, 18, 49, 18, 46, 0, 42,
  1, 1, 1, 10, 1, 1, 1, 0
), nrow = 8, byrow = TRUE)


rownames(win_loss_matrix) <- colnames(win_loss_matrix) <- paste0("Text_", 1:8)

# Berechnung der paarweisen Effektstärken (Cohen's h) und p-Werte
pairwise_results <- list()
for (i in 1:(nrow(win_loss_matrix) - 1)) {
  for (j in (i + 1):ncol(win_loss_matrix)) {
    wins_i = win_loss_matrix[i, j]
    wins_j = win_loss_matrix[j, i]
    total_comparisons = wins_i + wins_j
    observed_proportion_i = wins_i / total_comparisons
    observed_proportion_j = wins_j / total_comparisons
    
    expected_proportion = 0.5 
    
    effect_size_i = 2 * (asin(sqrt(observed_proportion_i)) - asin(sqrt(expected_proportion)))
    effect_size_j = 2 * (asin(sqrt(observed_proportion_j)) - asin(sqrt(expected_proportion)))
    
    p_value_i = 2 * (1 - pnorm(abs(effect_size_i), mean = 0, sd = sqrt(2 / total_comparisons)))
    p_value_j = 2 * (1 - pnorm(abs(effect_size_j), mean = 0, sd = sqrt(2 / total_comparisons)))

    pairwise_results[[paste0("Text_", i, "_vs_Text_", j)]] <- list(
      effect_size_i = effect_size_i,
      p_value_i = p_value_i,
      effect_size_j = effect_size_j,
      p_value_j = p_value_j
    )
  }
}

# Ausgabe der paarweisen Vergleichsergebnisse
for (comparison in names(pairwise_results)) {
  result = pairwise_results[[comparison]]
  cat(comparison, ":\n")
  cat("  Effect Size (Text ", sub(".*_(.)_.*", "\\1", comparison), "):", result$effect_size_i, "\n")
  cat("  P-Value (Text ", sub(".*_(.)_.*", "\\1", comparison), "):", result$p_value_i, "\n")
  cat("  Effect Size (Text ", sub(".*_(.)$", "\\1", comparison), "):", result$effect_size_j, "\n")
  cat("  P-Value (Text ", sub(".*_(.)$", "\\1", comparison), "):", result$p_value_j, "\n")
}
