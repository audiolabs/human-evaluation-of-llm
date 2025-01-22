
library(dplyr)
library(pwr)

# Comprehensibility Matrix
win_loss_matrix <- matrix(c(
  0, 4, 2, 25, 3, 20, 0, 22,
  4, 0, 1, 25, 0, 24, 0, 23,
  5, 7, 0, 25, 6, 24, 0, 22,
  0, 0, 0, 0, 0, 1, 0, 1,
  6, 8, 1, 25, 0, 25, 0, 22,
  0, 0, 0, 1, 0, 0, 1, 0,
  0, 0, 0, 25, 1, 23, 0, 22,
  22, 23, 22, 1, 22, 23, 0, 0
), nrow = 8, byrow = TRUE)

# Honesty Matrix
win_loss_matrix <- matrix(c(
  0, 18, 4, 24, 2, 25, 3, 25,
  1, 0, 1, 25, 1, 25, 1, 25,
  8, 19, 0, 25, 3, 25, 12, 25,
  0, 0, 0, 0, 0, 8, 0, 10,
  5, 23, 11, 25, 0, 25, 3, 25,
  0, 0, 0, 0, 0, 0, 0, 0,
  17, 20, 11, 24, 11, 25, 0, 25,
  0, 0, 0, 0, 0, 0, 0, 0
), nrow = 8, byrow = TRUE)

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

# Berechnung der gesamten Gewinne für jeden Text
total_wins <- rowSums(win_loss_matrix)

# Berechnung der beobachteten Gewinnproportionen
total_comparisons <- sum(total_wins)
observed_win_proportions <- total_wins / total_comparisons

# Erwartete Proportion unter der Nullhypothese (gleichverteilte Präferenzen)
expected_proportion <- 1 / 8

effect_sizes <- 2 * (asin(sqrt(observed_win_proportions)) - asin(sqrt(expected_proportion)))

average_effect_size <- mean(abs(effect_sizes))

sample_size <- pwr.t.test(d = average_effect_size, sig.level = 0.05, power = 0.8, type = "two.sample")$n

print(paste("Durchschnittliche Effektstärke (Cohen's h):", round(average_effect_size, 3)))
print(paste("Benötigte Stichprobengröße pro Gruppe:", ceiling(sample_size)))
