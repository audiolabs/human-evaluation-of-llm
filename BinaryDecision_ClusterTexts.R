library(dplyr)
library(ggplot2)
library(cluster)

# Manuelle Eingabe der Total-Skalenwerte
cluster_data <- data.frame(
  Text = c("GPT best", "GPT worst", "LLaMA best", "LLaMA worst", 
           "mistral best", "mistral worst", "Luminousbase best", "Luminousbase worst"),
  Total_Scale = c(42, 35, 47, 6, 38, 8, 45, 6)
)

# Anzahl der eindeutigen Werte für die Clusteranalyse
num_unique_total <- n_distinct(cluster_data$Total_Scale)
num_clusters <- min(num_unique_total, 8)  # Maximal 4 Cluster

cat("Anzahl der einzigartigen Datenpunkte für Total Scale:", num_unique_total, "\n")

# K-Means-Clusteranalyse
set.seed(123)
kmeans_result <- kmeans(cluster_data$Total_Scale, centers = num_clusters)

# Cluster hinzufügen
cluster_data$Cluster <- as.factor(kmeans_result$cluster)

# Ergebnisse ausgeben
print(cluster_data)

# Hierarchische Clusteranalyse
dist_matrix <- dist(cluster_data$Total_Scale)
hc <- hclust(dist_matrix, method = "complete")

# Dendrogramm plotten
plot(hc, labels = cluster_data$Text, main = "Dendrogram of Texts")

# Cluster aus hierarchischer Analyse zuweisen
cluster_cut <- cutree(hc, k = num_clusters)
cluster_data$Hierarchical_Cluster <- as.factor(cluster_cut)

# Endergebnisse ausgeben
print(cluster_data)
