library(readxl)
library(dplyr)


scale_1_metrics <- c("Honesty", "Correctness", "ContextAdherent", "Relevancy", "Completeness")
scale_2_metrics <- c("Comprehensible", "Readability", "Fluency", "Understandability", "NonRedundancy")

# Definieren der Gruppierung der Texte
groups <- list(
  GPT = c(1, 2),
  LLaMA = c(3, 4),
  Mistral = c(5, 6),
  Luminous = c(7, 8)
)

# Funktion zur Zählung der Siege pro Metrik oder Skala, aggregiert nach Gruppen
count_wins_grouped <- function(metric_columns, data, groups) {
  group_wins <- setNames(rep(0, length(groups)), names(groups))  
  for (i in 1:nrow(data)) {
    for (col in metric_columns) {
      value <- as.numeric(data[[col]][i])
      if (!is.na(value) && value > 0) {
        for (group_name in names(groups)) {
          if (value %in% groups[[group_name]]) {
            group_wins[group_name] <- group_wins[group_name] + 1
          }
        }
      }
    }
  }
  return(group_wins)
}

# 1. Einzelne Metriken auswerten
metrics <- c(scale_1_metrics, scale_2_metrics)
for (metric in metrics) {
  metric_columns <- grep(metric, names(df), value = TRUE)
  group_wins <- count_wins_grouped(metric_columns, df, groups)
  
  group_df <- data.frame(Group = names(group_wins), Wins = as.numeric(group_wins))
  group_df <- group_df %>% arrange(desc(Wins))

  cat("Ranking for", metric, ":\n")
  print(group_df)
  cat("\n")
}

# 2. Skala Honesty auswerten
scale_1_columns <- grep(paste(scale_1_metrics, collapse="|"), names(df), value = TRUE)
scale_1_group_wins <- count_wins_grouped(scale_1_columns, df, groups)

scale_1_df <- data.frame(Group = names(scale_1_group_wins), Wins = as.numeric(scale_1_group_wins))
scale_1_df <- scale_1_df %>% arrange(desc(Wins))

cat("Ranking for Skala 1 (Honesty):\n")
print(scale_1_df)
cat("\n")

# 3. Skala Comprehensibility auswerten
scale_2_columns <- grep(paste(scale_2_metrics, collapse="|"), names(df), value = TRUE)
scale_2_group_wins <- count_wins_grouped(scale_2_columns, df, groups)

scale_2_df <- data.frame(Group = names(scale_2_group_wins), Wins = as.numeric(scale_2_group_wins))
scale_2_df <- scale_2_df %>% arrange(desc(Wins))

cat("Ranking for Skala 2 (Comprehensibility):\n")
print(scale_2_df)
cat("\n")


total_wins <- setNames(rep(0, length(groups)), names(groups))


# 4. Gesamtrangliste (Total) erstellen
total_wins <- scale_1_group_wins + scale_2_group_wins

total_df <- data.frame(Group = names(total_wins), Wins = as.numeric(total_wins))
total_df <- total_df %>% arrange(desc(Wins))

cat("Overall Total Ranking:\n")
print(total_df)
cat("\n")