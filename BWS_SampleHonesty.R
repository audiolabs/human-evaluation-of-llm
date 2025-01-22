# Z-Wert für ein 95% Konfidenzniveau
Z <- 1.96

E <- 0.05

# Honesty Best and Worst Counts aus deinem Bild
honesty_best_counts <- c(9, 6, 15, 0, 17, 0, 23, 0)
honesty_worst_counts <- c(2, 1, 0, 25, 1, 12, 2, 27)

# Gesamtanzahl der Best- und Worst-Wahlen
total_best_honesty <- sum(honesty_best_counts)
total_worst_honesty <- sum(honesty_worst_counts)

# Berechnung der Proportionen für Best und Worst
best_proportions_honesty <- honesty_best_counts / total_best_honesty
worst_proportions_honesty <- honesty_worst_counts / total_worst_honesty

# Funktion zur Berechnung der Stichprobengröße basierend auf Proportionen
calculate_sample_size <- function(proportion, Z, E) {
  p <- proportion
  return((Z^2 * p * (1 - p)) / E^2)
}

# Berechnung der Stichprobengröße für jede Best- und Worst-Proportion
sample_sizes_best_honesty <- sapply(best_proportions_honesty, calculate_sample_size, Z = Z, E = E)
sample_sizes_worst_honesty <- sapply(worst_proportions_honesty, calculate_sample_size, Z = Z, E = E)

# Durchschnittliche Stichprobengröße für Best- und Worst-Proportionen bei Honesty
average_sample_size_best_honesty <- mean(sample_sizes_best_honesty)
average_sample_size_worst_honesty <- mean(sample_sizes_worst_honesty)

cat("Durchschnittliche Stichprobengröße für 'Best'-Proportionen (Honesty):", round(average_sample_size_best_honesty), "\n")
cat("Durchschnittliche Stichprobengröße für 'Worst'-Proportionen (Honesty):", round(average_sample_size_worst_honesty), "\n")
