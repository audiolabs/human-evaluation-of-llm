library(cluster)
library(dendextend)  

# Für Texte
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

rownames(win_loss_matrix) <- colnames(win_loss_matrix) <- c(
  "Chat GPT Best", "Chat GPT Worst", 
  "LLaMA Best", "LLaMA Worst", 
  "Mistral Best", "Mistral Worst", 
  "Luminous Best", "Luminous Worst"
)

dist_matrix <- as.dist(1 - cor(win_loss_matrix))

hc <- hclust(dist_matrix, method = "complete")

plot(hc, main = "Hierarchical Cluster Analysis for Individual Texts", xlab = "Texts", sub = "", cex = 0.9)

# Für LLMs
combined_matrix <- matrix(c(
  27, 107, 100, 99,
  39, 50, 67, 70,
  44, 70, 50, 51,
  62, 78, 66, 43
), nrow = 4, byrow = TRUE)

rownames(combined_matrix) <- colnames(combined_matrix) <- c("GPT", "LLaMA", "Mistral", "Luminous")

dist_matrix_combined <- as.dist(1 - cor(combined_matrix))

hc_combined <- hclust(dist_matrix_combined, method = "complete")

plot(hc_combined, main = "Hierarchical Cluster Analysis for Combined Groups", xlab = "Groups", sub = "", cex = 0.9)
