texts <- 1:8
scores <- data.frame(Text = texts, Honesty_Score = 0, Comprehensibility_Score = 0, Total_Score = 0)

# Berechne die Scores für Honesty für alle BH1-BH14 und WH1-WH14
for (block in 1:14) {
  # Dynamisch die Spaltennamen erzeugen für Honesty
  best_column_honesty <- paste0("BH", block)
  worst_column_honesty <- paste0("WH", block)
  
  for (i in 1:nrow(df)) {
    # Best Text für Honesty: Punkte addieren
    best_text_honesty <- df[[best_column_honesty]][i]
    if (!is.na(best_text_honesty) && best_text_honesty %in% texts) {
      scores[scores$Text == best_text_honesty, "Honesty_Score"] <- 
        scores[scores$Text == best_text_honesty, "Honesty_Score"] + 1
    }
    
    # Worst Text für Honesty: Punkte subtrahieren
    worst_text_honesty <- df[[worst_column_honesty]][i]
    if (!is.na(worst_text_honesty) && worst_text_honesty %in% texts) {
      scores[scores$Text == worst_text_honesty, "Honesty_Score"] <- 
        scores[scores$Text == worst_text_honesty, "Honesty_Score"] - 1
    }
  }
}

# Berechne die Scores für Comprehensibility für alle BC1-BC14 und WC1-WC14
for (block in 1:14) {
  # Dynamisch die Spaltennamen erzeugen für Comprehensibility
  best_column_comprehensibility <- paste0("BC", block)
  worst_column_comprehensibility <- paste0("WC", block)
  
  for (i in 1:nrow(df)) {
    # Best Text für Comprehensibility: Punkte addieren
    best_text_comprehensibility <- df[[best_column_comprehensibility]][i]
    if (!is.na(best_text_comprehensibility) && best_text_comprehensibility %in% texts) {
      scores[scores$Text == best_text_comprehensibility, "Comprehensibility_Score"] <- 
        scores[scores$Text == best_text_comprehensibility, "Comprehensibility_Score"] + 1
    }
    
    # Worst Text für Comprehensibility: Punkte subtrahieren
    worst_text_comprehensibility <- df[[worst_column_comprehensibility]][i]
    if (!is.na(worst_text_comprehensibility) && worst_text_comprehensibility %in% texts) {
      scores[scores$Text == worst_text_comprehensibility, "Comprehensibility_Score"] <- 
        scores[scores$Text == worst_text_comprehensibility, "Comprehensibility_Score"] - 1
    }
  }
}

# Gesamtscore berechnen: Summe aus Honesty_Score und Comprehensibility_Score
scores$Total_Score <- scores$Honesty_Score + scores$Comprehensibility_Score


# Textlabels umbenennen
text_labels <- c("GPT Best", "GPT Worst", 
                 "LLaMA Best", "LLaMA Worst", 
                 "Mistral Best", "Mistral Worst", 
                 "Luminous Best", "Luminous Worst")

scores$Text_Label <- text_labels

# anking erstellen
scores_total <- scores[order(-scores$Total_Score), ]
scores_honesty <- scores[order(-scores$Honesty_Score), ]
scores_comprehensibility <- scores[order(-scores$Comprehensibility_Score), ]

library(ggplot2)

# Barplots
ggplot(scores_total, aes(x = reorder(Text_Label, Total_Score), y = Total_Score)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(title = "Ranking of Texts by Total Score",
       x = "Text",
       y = "Total Score") +
  theme_minimal() +
  coord_flip()  # Optional: for horizontal bars

ggplot(scores_honesty, aes(x = reorder(Text_Label, Honesty_Score), y = Honesty_Score)) +
  geom_bar(stat = "identity", fill = "darkgreen") +
  labs(title = "Ranking of Texts by Honesty Score",
       x = "Text",
       y = "Honesty Score") +
  theme_minimal() +
  coord_flip()  # Optional: for horizontal bars

ggplot(scores_comprehensibility, aes(x = reorder(Text_Label, Comprehensibility_Score), y = Comprehensibility_Score)) +
  geom_bar(stat = "identity", fill = "purple") +
  labs(title = "Ranking of Texts by Comprehensibility Score",
       x = "Text",
       y = "Comprehensibility Score") +
  theme_minimal() +
  coord_flip()  # Optional: for horizontal bars




# LLM Basierende Kalculation

# Textpaare erzeugen
pairs <- list(c(1, 2), c(3, 4), c(5, 6), c(7, 8))
pair_names <- c("GPT", "LLaMA", "Mistral", "LuminousBase")

combined_scores <- data.frame(
  Pair = pair_names,
  Combined_Honesty_Score = 0,
  Combined_Comprehensibility_Score = 0,
  Combined_Total_Score = 0
)

# Summe der Textpaare erstellen
for (i in 1:length(pairs)) {
  combined_scores$Combined_Honesty_Score[i] <- sum(scores$Honesty_Score[scores$Text %in% pairs[[i]]])
  combined_scores$Combined_Comprehensibility_Score[i] <- sum(scores$Comprehensibility_Score[scores$Text %in% pairs[[i]]])
  combined_scores$Combined_Total_Score[i] <- sum(scores$Total_Score[scores$Text %in% pairs[[i]]])
}

# Ranking erstellen
combined_scores <- combined_scores[order(-combined_scores$Combined_Total_Score), ]


# Barplots
ggplot(combined_scores, aes(x = reorder(Pair, Combined_Total_Score), y = Combined_Total_Score)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(title = "Combined Ranking of Text Pairs by Total Score",
       x = "Text Pair",
       y = "Combined Total Score") +
  theme_minimal() +
  coord_flip()  # Optional: for horizontal bars

ggplot(combined_scores, aes(x = reorder(Pair, Combined_Honesty_Score), y = Combined_Honesty_Score)) +
  geom_bar(stat = "identity", fill = "darkgreen") +
  labs(title = "Combined Ranking of Text Pairs by Honesty Score",
       x = "Text Pair",
       y = "Combined Honesty Score") +
  theme_minimal() +
  coord_flip()  # Optional: for horizontal bars

ggplot(combined_scores, aes(x = reorder(Pair, Combined_Comprehensibility_Score), y = Combined_Comprehensibility_Score)) +
  geom_bar(stat = "identity", fill = "purple") +
  labs(title = "Combined Ranking of Text Pairs by Comprehensibility Score",
       x = "Text Pair",
       y = "Combined Comprehensibility Score") +
  theme_minimal() +
  coord_flip()  # Optional: for horizontal bars


