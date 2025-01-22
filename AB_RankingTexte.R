library(readxl)
library(dplyr)


# Liste der Metriken für beide Skalen
scale_1_metrics <- c("Honesty", "Correctness", "ContextAdherent", "Relevancy", "Completeness")
scale_2_metrics <- c("Comprehensible", "Readability", "Fluency", "Understandability", "NonRedundancy")

# Funktion zur Zählung der Siege pro Metrik oder Skala
count_wins <- function(metric_columns, data) {
  win_counts <- rep(0, 8)  # Initialisiere den Zähler für die Siege für jeden Text (1 bis 8)
  for (i in 1:nrow(data)) {
    for (col in metric_columns) {
      value <- as.numeric(data[[col]][i])
      if (!is.na(value) && value > 0) {
        win_counts[value] <- win_counts[value] + 1
      }
    }
  }
  return(win_counts)
}

# 1. Metriken
metrics <- c(scale_1_metrics, scale_2_metrics)
for (metric in metrics) {
  metric_columns <- grep(metric, names(df), value = TRUE)
  win_counts <- count_wins(metric_columns, df)
  
  win_df <- data.frame(Text = 1:8, Wins = win_counts)
  win_df <- win_df %>% arrange(desc(Wins))
  
  # Ausgabe der Rangliste für diese Metrik
  cat("Ranking for", metric, ":\n")
  print(win_df)
  cat("\n")
}

# 2. Skala Honesty 
scale_1_columns <- grep(paste(scale_1_metrics, collapse="|"), names(df), value = TRUE)
scale_1_win_counts <- count_wins(scale_1_columns, df)

scale_1_df <- data.frame(Text = 1:8, Wins = scale_1_win_counts)
scale_1_df <- scale_1_df %>% arrange(desc(Wins))

cat("Ranking for Skala 1 (Honesty):\n")
print(scale_1_df)
cat("\n")

# 3. Skala Comprehensibility 
scale_2_columns <- grep(paste(scale_2_metrics, collapse="|"), names(df), value = TRUE)
scale_2_win_counts <- count_wins(scale_2_columns, df)

scale_2_df <- data.frame(Text = 1:8, Wins = scale_2_win_counts)
scale_2_df <- scale_2_df %>% arrange(desc(Wins))

cat("Ranking for Skala 2 (Comprehensibility):\n")
print(scale_2_df)
cat("\n")

#4. Total 

# Liste der Metriken, die analysiert werden sollen
metrics <- c("Honesty", "Correctness", "ContextAdherent", "Relevancy",
             "Completeness", "Comprehensible", "Readability", "Fluency",
             "Understandability", "NonRedundancy")

metric_columns <- grep(paste(metrics, collapse="|"), names(df), value = TRUE)

win_counts <- rep(0, 8)

for (i in 1:nrow(df)) {
  for (col in metric_columns) {
    value <- as.numeric(df[[col]][i])
    if (!is.na(value) && value > 0) {
      win_counts[value] <- win_counts[value] + 1
    }
  }
}

win_df <- data.frame(Text = 1:8, Wins = win_counts)
win_df <- win_df %>% arrange(desc(Wins))

print(win_df)
