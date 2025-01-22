library(ggcorrplot)
library(factoextra)
library(FactoMineR)
library(corrplot)

# Daten manuell eingeben 
data <- data.frame(
  Pair = c("GPT", "Mistral", "LLaMA", "LuminousBase"),
  Combined_Honesty_Score = c(12, 4, -10, -6),
  Combined_Comprehensibility_Score = c(32, -10, -5, -17),
  Combined_Total_Score = c(44, -6, -15, -23)
)

# Entferne die "Pair"-Spalte für numerische Analysen
numeric_data <- data[, -1]

# Setze die LLM-Namen als Zeilen- und Spaltennamen
rownames(numeric_data) <- data$Pair

# 1. Clusteranalyse
hc <- hclust(dist(numeric_data), method = "ward.D2")

fviz_dend(hc, k = 2, rect = TRUE, main = "Cluster Analysis Dendrogram", 
          cex = 1.2,  
          labels_track_height = 1.5,  
          horiz = TRUE)  

# 2. PCA-Analyse
pca_result <- PCA(numeric_data, scale.unit = TRUE, ncp = 2, graph = FALSE)

# Plot 
library(ggplot2)
fviz_pca_biplot(pca_result, repel = TRUE, title = "PCA based on Combined Scores", label = "var") +
  geom_text(aes(x = pca_result$ind$coord[, 1], 
                y = pca_result$ind$coord[, 2], 
                label = data$Pair), vjust = 1, color = "black")


# 3. Korrelationsmatrix zwischen den Metriken (Honesty, Comprehensibility, Total)
metric_data <- data[, c("Combined_Honesty_Score", "Combined_Comprehensibility_Score", "Combined_Total_Score")]
cor_matrix <- cor(metric_data)

# Plot
ggcorrplot(cor_matrix, 
           method = "circle", 
           type = "upper", 
           lab = TRUE, 
           lab_size = 5, 
           colors = c("red", "white", "blue"), 
           title = "Correlation Matrix between Metrics", 
           ggtheme = theme_minimal(),
           tl.cex = 12, 
           tl.col = "black", 
           tl.srt = 45 
)