library(dplyr)
library(ggplot2)
library(cluster)

# Manuelle Eingabe der Total-Skalenwerte (Ja-Antworten)
cluster_data <- data.frame(
  Text = c("GPT", "LLaMA", "mistral", "Luminousbase"),
  Total_Scale = c(77, 53, 46, 51)
)

# Berechnung der Nein-Antworten
cluster_data$No_Scale <- 100 - cluster_data$Total_Scale

# Ausgabe der berechneten Nein-Antworten
print(cluster_data)

# Anzahl der eindeutigen Werte für die Clusteranalyse
num_unique_total <- n_distinct(cluster_data$Total_Scale)
num_clusters <- min(num_unique_total, 3)  # Maximal 3 Cluster, 4 gehen aus irgendeinem grund nicht

cat("Anzahl der einzigartigen Datenpunkte für Total Scale:", num_unique_total, "\n")

# K-Means-Clusteranalyse (auf Basis von Ja- und Nein-Antworten)
set.seed(123)

# K-Means ausführen mit Ja- und Nein-Antworten
kmeans_result <- kmeans(cluster_data[, c("Total_Scale", "No_Scale")], centers = num_clusters)

# Cluster hinzufügen
cluster_data$Cluster <- as.factor(kmeans_result$cluster)

# Ergebnisse ausgeben
print(cluster_data)

# Hierarchische Clusteranalyse
dist_matrix <- dist(cluster_data[, c("Total_Scale", "No_Scale")])
hc <- hclust(dist_matrix, method = "complete")

# Dendrogramm plotten
plot(hc, labels = cluster_data$Text, main = "Dendrogram of Texts")

# Cluster aus hierarchischer Analyse zuweisen
cluster_cut <- cutree(hc, k = num_clusters)
cluster_data$Hierarchical_Cluster <- as.factor(cluster_cut)

# Endergebnisse ausgeben
print(cluster_data)
