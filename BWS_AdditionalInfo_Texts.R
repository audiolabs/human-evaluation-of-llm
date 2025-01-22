library(factoextra)

# Dataframe
value_scores <- data.frame(
  Text = c("GPT Best", "GPT Worst", "LLaMA Best", "LLaMA Worst", 
           "Mistral Best", "Mistral Worst", "Luminous Best", "Luminous Worst"),
  Honesty_Score = c(7, 5, 15, -25, 16, -12, 21, -27),
  Comprehensibility_Score = c(18, 14, 14, -19, 14, -24, 10, -27),
  Total_Score = c(25, 19, 29, -44, 30, -36, 31, -54)
)


#Clusteranalyse
dist_matrix <- dist(value_scores[, c("Honesty_Score", "Comprehensibility_Score", "Total_Score")], method = "euclidean")

clusters <- hclust(dist_matrix, method = "ward.D2")

clusters$labels <- value_scores$Text
fviz_dend(clusters, rect = TRUE, show_labels = TRUE, main = "Cluster Analysis based on Value Scores")



library(factoextra)
# Durchführung der PCA auf mehreren Variablen
fa_result <- PCA(value_scores[, c("Honesty_Score", "Comprehensibility_Score")], scale.unit = TRUE, ncp = 2)

# Plot
fviz_pca_biplot(fa_result, label = "var", habillage = "none", 
                addEllipses = TRUE, 
                title = "PCA based on Honesty and Comprehensibility Scores",
                repel = TRUE) + 
  geom_text(aes(label = value_scores$Text), vjust = -0.5, hjust = 0.5)  # Textlabels hinzufügen


# Berechnung der Korrelationen 
cor_matrix <- cor(value_scores[, c("Honesty_Score", "Comprehensibility_Score", "Total_Score")], method = "spearman")
print(cor_matrix)
library(corrplot)
corrplot(cor_matrix, method = "color", type = "upper", order = "hclust", tl.col = "black")
