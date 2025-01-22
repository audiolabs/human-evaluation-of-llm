
# Muster für alle Metriken
all_metrics_patterns <- c("Honesty_", "Correctness_", "ContextAdherent_", "Relevancy_", "Completeness_", 
                          "Comprehensible_", "Readability_", "Fluency_", "Understandability_", "NonRedundancy_")

# Funktion zum Erstellen der Tabelle
create_overview_table <- function(df, number, all_metrics_patterns) {
  # Sicherstellen, dass die Muster korrekt verwendet werden
  matched_columns <- df %>% 
    select(matches(paste0("^(", paste(all_metrics_patterns, collapse = "|"), ")", number, "$")))
  
  # Summieren der Antwortkategorien
  metrics_sum <- matched_columns %>%
    summarise(
      Yes = sum(. == "Yes", na.rm = TRUE),
      No = sum(. == "No", na.rm = TRUE),
      IDK = sum(. == "I don't know", na.rm = TRUE)
    )
  
  data.frame(
    Category = paste0("Category_", number),
    Yes = metrics_sum$Yes,
    No = metrics_sum$No,
    IDK = metrics_sum$IDK
  )
}

# Sicherstellen, dass `df_selected` existiert
df_selected <- df %>%
  select(matches(paste0("^(", paste(all_metrics_patterns, collapse = "|"), ")[1-8]$")))

# Tabelle für alle Kategorien (1-8) erstellen
overview_table_data <- lapply(1:8, function(i) {
  create_overview_table(df_selected, i, all_metrics_patterns)
}) %>%
  bind_rows()

# Tabelle anzeigen
print(overview_table_data)
