# Benötigte Bibliotheken laden
library(readxl)
library(effectsize)
library(pwr)

# Funktion zur Berechnung von Cramér's V und Chi-Quadrat-Test
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

# Funktion zur Berechnung der Poweranalyse für die benötigte Stichprobengröße
perform_power_analysis_sample_size <- function(effect_size, df, desired_power = 0.80, sig_level = 0.05) {
  if (!is.na(effect_size)) {
    power_analysis <- pwr.chisq.test(w = effect_size, N = NULL, df = df, sig.level = sig_level, power = desired_power)
    return(list(sample_size = ceiling(power_analysis$N), power_analysis = power_analysis))  # Aufrunden auf die nächste ganze Zahl
  } else {
    return(list(sample_size = NA, power_analysis = NULL))
  }
}

# LLM-Gruppierung
llm_groups <- list(
  GPT = c(1, 2),
  LLaMA = c(3, 4),
  Mistral = c(5, 6),
  Luminous = c(7, 8)
)

# Funktion zur Gruppierung der Daten
group_data <- function(df, metric_prefixes, groups) {
  group_sums <- sapply(names(groups), function(group_name) {
    group_indices <- groups[[group_name]]
    existing_columns <- paste0(metric_prefixes, group_indices)
    existing_columns <- existing_columns[existing_columns %in% names(df)]  # Nur existierende Spalten verwenden
    if (length(existing_columns) > 0) {
      rowSums(df[, existing_columns] == "Yes", na.rm = TRUE)
    } else {
      NA
    }
  })
  group_sums
}

# Metriken für Honesty (1-5) und Comprehensibility (6-10)
metrics <- c("Honesty_", "Correctness_", "ContextAdherent_", "Relevancy_", "Completeness_", 
             "Comprehensible_", "Readability_", "Fluency_", "Understandability_", "NonRedundancy_")

grouped_honesty <- as.data.frame(group_data(data, "Honesty_", llm_groups))
grouped_comprehensibility <- as.data.frame(group_data(data, "Comprehensible_", llm_groups))
grouped_total <- as.data.frame(group_data(data, metrics, llm_groups))  # Alle Metriken kombiniert


grouped_honesty_results <- calculate_cramers_v(grouped_honesty, names(llm_groups))
grouped_comprehensibility_results <- calculate_cramers_v(grouped_comprehensibility, names(llm_groups))
grouped_total_results <- calculate_cramers_v(grouped_total, names(llm_groups))

grouped_metric_results <- lapply(metrics, function(metric_prefix) {
  grouped_metric_data <- as.data.frame(group_data(data, metric_prefix, llm_groups))
  result <- calculate_cramers_v(grouped_metric_data, names(llm_groups))
  df_4_llms <- 3  # Freiheitsgrade für 4 LLMs
  power_result <- perform_power_analysis_sample_size(result$cramers_v, df = df_4_llms)
  
  list(chi_test = result$chi_test, cramers_v = result$cramers_v, sample_size = power_result$sample_size)
})

# Freiheitsgrade für den Chi-Quadrat-Test (n_groups - 1), für 4 LLMs: df = 3
df_4_llms <- 3

# Berechnung der erforderlichen Stichprobengröße für die gruppierten Daten
sample_size_grouped_honesty <- perform_power_analysis_sample_size(grouped_honesty_results$cramers_v, df = df_4_llms)
sample_size_grouped_comprehensibility <- perform_power_analysis_sample_size(grouped_comprehensibility_results$cramers_v, df = df_4_llms)
sample_size_grouped_total <- perform_power_analysis_sample_size(grouped_total_results$cramers_v, df = df_4_llms)

cat("\nErgebnisse für LLMs (4 Modelle):\n")

cat("\nErgebnisse für einzelne Metriken (4 LLMs):\n")
for (i in 1:length(metrics)) {
  cat("\nMetrik:", metrics[i], "\n")
  cat("Cramér's V:", grouped_metric_results[[i]]$cramers_v, "\n")
  cat("Chi-Quadrat-Test:\n")
  print(grouped_metric_results[[i]]$chi_test)
  cat("Benötigte Stichprobengröße:", grouped_metric_results[[i]]$sample_size, "\n")
}

cat("\nErgebnisse für Skalen (4 LLMs):\n")
cat("Honesty - Cramér's V:", grouped_honesty_results$cramers_v, "\nChi-Quadrat-Test:\n")
print(grouped_honesty_results$chi_test)
cat("Benötigte Stichprobengröße:", sample_size_grouped_honesty$sample_size, "\n")

cat("\nComprehensibility - Cramér's V:", grouped_comprehensibility_results$cramers_v, "\nChi-Quadrat-Test:\n")
print(grouped_comprehensibility_results$chi_test)
cat("Benötigte Stichprobengröße:", sample_size_grouped_comprehensibility$sample_size, "\n")

cat("\nTotal - Cramér's V:", grouped_total_results$cramers_v, "\nChi-Quadrat-Test:\n")
print(grouped_total_results$chi_test)
cat("Benötigte Stichprobengröße:", sample_size_grouped_total$sample_size, "\n")
