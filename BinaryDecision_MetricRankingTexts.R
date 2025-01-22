# Funktion zur Erstellung einer Frequenztabelle nur für "Yes"-Antworten
create_yes_frequency_table <- function(df, metric_patterns, number) {
  # Spaltenauswahl
  selected_columns <- df %>%
    select(matches(paste0("^(", paste(metric_patterns, collapse = "|"), ")", number, "$")))
  
  # Frequenzen berechnen
  frequencies_long <- selected_columns %>%
    summarise_all(~ sum(. == "Yes", na.rm = TRUE)) %>%
    pivot_longer(everything(), names_to = "Metric", values_to = "Count") %>%
    mutate(Metric = gsub("[0-9]", "", Metric)) 
  
  # Hinzufügen des Titels für die Kategorie
  frequencies_long <- frequencies_long %>%
    mutate(Title = titles[number])
  
  return(frequencies_long)
}

# Tabelle nur für "Yes"-Antworten erstellen
table_yes <- lapply(1:8, function(i) create_yes_frequency_table(df_selected, metric_patterns, i)) %>% bind_rows()

# Tabelle anzeigen
print("Table for 'Yes' responses:")
print(n=80, table_yes)
