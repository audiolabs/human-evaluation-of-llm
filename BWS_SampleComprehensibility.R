# Z-Wert für ein 95% Konfidenzniveau
Z <- 1.96 

E <- 0.05

# Comprehensibility Best and Worst Counts aus deinem Bild
comprehensibility_best_counts <- c(18, 14, 14, 0, 14, 0, 10, 0)
comprehensibility_worst_counts <- c(0, 0, 0, 19, 0, 24, 0, 27)

# Gesamtanzahl der Best- und Worst-Wahlen
total_best_comprehensibility <- sum(comprehensibility_best_counts)
total_worst_comprehensibility <- sum(comprehensibility_worst_counts)

# Berechnung der Proportionen für Best und Worst
best_proportions_comprehensibility <- comprehensibility_best_counts / total_best_comprehensibility
worst_proportions_comprehensibility <- comprehensibility_worst_counts / total_worst_comprehensibility

# Funktion zur Berechnung der Stichprobengröße basierend auf Proportionen
calculate_sample_size <- function(proportion, Z, E) {
  p <- proportion
  return((Z^2 * p * (1 - p)) / E^2)
}

# Berechnung der Stichprobengröße für jede Best- und Worst-Proportion
sample_sizes_best_comprehensibility <- sapply(best_proportions_comprehensibility, calculate_sample_size, Z = Z, E = E)
sample_sizes_worst_comprehensibility <- sapply(worst_proportions_comprehensibility, calculate_sample_size, Z = Z, E = E)

# Durchschnittliche Stichprobengröße für Best- und Worst-Proportionen bei Comprehensibility
average_sample_size_best_comprehensibility <- mean(sample_sizes_best_comprehensibility)
average_sample_size_worst_comprehensibility <- mean(sample_sizes_worst_comprehensibility)

cat("Durchschnittliche Stichprobengröße für 'Best'-Proportionen (Comprehensibility):", round(average_sample_size_best_comprehensibility), "\n")
cat("Durchschnittliche Stichprobengröße für 'Worst'-Proportionen (Comprehensibility):", round(average_sample_size_worst_comprehensibility), "\n")
