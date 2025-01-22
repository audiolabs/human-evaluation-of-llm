# Z-Wert für ein 95% Konfidenzniveau
Z <- 1.96


E <- 0.05

# Honesty Best and Worst Counts
honesty_best_counts <- c(9, 6, 15, 0, 17, 0, 23, 0)
honesty_worst_counts <- c(2, 1, 0, 25, 1, 12, 2, 27)

# Comprehensibility Best and Worst Counts
comprehensibility_best_counts <- c(18, 14, 14, 0, 14, 0, 10, 0)
comprehensibility_worst_counts <- c(0, 0, 0, 19, 0, 24, 0, 27)

# Kombinierte Best- und Worst-Zählungen
combined_best_counts <- honesty_best_counts + comprehensibility_best_counts
combined_worst_counts <- honesty_worst_counts + comprehensibility_worst_counts

# Gesamtanzahl der kombinierten Best- und Worst-Wahlen
total_combined_best <- sum(combined_best_counts)
total_combined_worst <- sum(combined_worst_counts)

# Berechnung der Proportionen für die kombinierten Best- und Worst-Wahlen
combined_best_proportions <- combined_best_counts / total_combined_best
combined_worst_proportions <- combined_worst_counts / total_combined_worst

# Funktion zur Berechnung der Stichprobengröße basierend auf Proportionen
calculate_sample_size <- function(proportion, Z, E) {
  p <- proportion
  return((Z^2 * p * (1 - p)) / E^2)
}

# Berechnung der Stichprobengröße für jede kombinierte Best- und Worst-Proportion
sample_sizes_combined_best <- sapply(combined_best_proportions, calculate_sample_size, Z = Z, E = E)
sample_sizes_combined_worst <- sapply(combined_worst_proportions, calculate_sample_size, Z = Z, E = E)

# Durchschnittliche Stichprobengröße für kombinierte Best- und Worst-Proportionen
average_sample_size_combined_best <- mean(sample_sizes_combined_best)
average_sample_size_combined_worst <- mean(sample_sizes_combined_worst)

cat("Durchschnittliche Stichprobengröße für kombinierte 'Best'-Proportionen:", round(average_sample_size_combined_best), "\n")
cat("Durchschnittliche Stichprobengröße für kombinierte 'Worst'-Proportionen:", round(average_sample_size_combined_worst), "\n")
