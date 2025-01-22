library(readxl)
library(effectsize)
library(pwr)

calculate_cramers_v <- function(data, columns) {
  existing_columns <- columns[columns %in% names(data)]  # Nur existierende Spalten verwenden
  if (length(existing_columns) == 0) {
    return(list(cramers_v = NA, chi_test = NULL))
  }
  
  contingency_table <- table(unlist(data[existing_columns]))
  
  if (min(contingency_table) > 0) {
    chisq_test <- chisq.test(contingency_table, correct = FALSE)
    cramers_v <- sqrt(chisq_test$statistic / (sum(contingency_table) * (min(dim(contingency_table)) - 1)))
    return(list(cramers_v = as.numeric(cramers_v), chi_test = chisq_test))
  } else {
    return(list(cramers_v = NA, chi_test = NULL))
  }
}

perform_power_analysis_sample_size <- function(effect_size, df, desired_power = 0.80, sig_level = 0.05) {
  if (!is.na(effect_size)) {
    power_analysis <- pwr.chisq.test(w = effect_size, N = NULL, df = df, sig.level = sig_level, power = desired_power)
    return(list(sample_size = ceiling(power_analysis$N), power_analysis = power_analysis))  # Aufrunden auf die nächste ganze Zahl
  } else {
    return(list(sample_size = NA, power_analysis = NULL))
  }
}

# 1. Vergleich für 8 Texte: Berechnung für jede Metrik, Honesty, Comprehensibility und Total

# Metriken für Honesty (1-5) und Comprehensibility (6-10)
metrics <- c("Honesty_", "Correctness_", "ContextAdherent_", "Relevancy_", "Completeness_", 
             "Comprehensible_", "Readability_", "Fluency_", "Understandability_", "NonRedundancy_")

honesty_metrics <- paste0(c("Honesty_", "Correctness_", "ContextAdherent_", "Relevancy_", "Completeness_"), 1:8)
comprehensibility_metrics <- paste0(c("Comprehensible_", "Readability_", "Fluency_", "Understandability_", "NonRedundancy_"), 1:8)
total_metrics <- c(honesty_metrics, comprehensibility_metrics)

# Berechnung von Cramér's V und Chi-Quadrat-Tests für jede Metrik einzeln
metric_results <- lapply(metrics, function(metric_prefix) {
  metric_columns <- paste0(metric_prefix, 1:8)
  result <- calculate_cramers_v(data, metric_columns)
  df_8_texts <- 7  # Freiheitsgrade für 8 Texte
  power_result <- perform_power_analysis_sample_size(result$cramers_v, df = df_8_texts)
  
  list(chi_test = result$chi_test, cramers_v = result$cramers_v, sample_size = power_result$sample_size)
})

# Berechnung von Cramér's V und Chi-Quadrat-Tests für Honesty, Comprehensibility und Total
honesty_results <- calculate_cramers_v(data, honesty_metrics)
comprehensibility_results <- calculate_cramers_v(data, comprehensibility_metrics)
total_results <- calculate_cramers_v(data, total_metrics)

# Freiheitsgrade für den Chi-Quadrat-Test (n_groups - 1), für 8 Texte: df = 7
df_8_texts <- 7

# Berechnung der erforderlichen Stichprobengröße für Honesty, Comprehensibility und Total
sample_size_honesty <- perform_power_analysis_sample_size(honesty_results$cramers_v, df = df_8_texts)
sample_size_comprehensibility <- perform_power_analysis_sample_size(comprehensibility_results$cramers_v, df = df_8_texts)
sample_size_total <- perform_power_analysis_sample_size(total_results$cramers_v, df = df_8_texts)


cat("\nErgebnisse für einzelne Metriken (8 Texte):\n")
for (i in 1:length(metrics)) {
  cat("\nMetrik:", metrics[i], "\n")
  cat("Cramér's V:", metric_results[[i]]$cramers_v, "\n")
  cat("Chi-Quadrat-Test:\n")
  print(metric_results[[i]]$chi_test)
  cat("Benötigte Stichprobengröße:", metric_results[[i]]$sample_size, "\n")
}

# Ausgabe der Ergebnisse für die Skalen 
cat("\nErgebnisse für Skalen (8 Texte):\n")
cat("Honesty - Cramér's V:", honesty_results$cramers_v, "\nChi-Quadrat-Test:\n")
print(honesty_results$chi_test)
cat("Benötigte Stichprobengröße:", sample_size_honesty$sample_size, "\n")

cat("\nComprehensibility - Cramér's V:", comprehensibility_results$cramers_v, "\nChi-Quadrat-Test:\n")
print(comprehensibility_results$chi_test)
cat("Benötigte Stichprobengröße:", sample_size_comprehensibility$sample_size, "\n")

cat("\nTotal - Cramér's V:", total_results$cramers_v, "\nChi-Quadrat-Test:\n")
print(total_results$chi_test)
cat("Benötigte Stichprobengröße:", sample_size_total$sample_size, "\n")
