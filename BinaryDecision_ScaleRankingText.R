create_combined_table <- function(df, honesty_patterns, comprehensibility_patterns, category, number) {
  honesty_columns <- df %>%
    select(matches(paste0("^(", paste(honesty_patterns, collapse = "|"), ")", number, "$")))
  
  comprehensibility_columns <- df %>%
    select(matches(paste0("^(", paste(comprehensibility_patterns, collapse = "|"), ")", number, "$")))
  
  honesty_sum <- honesty_columns %>%
    summarise_all(~ sum(. == category, na.rm = TRUE)) %>%
    rowSums() %>% as.numeric()
  
  comprehensibility_sum <- comprehensibility_columns %>%
    summarise_all(~ sum(. == category, na.rm = TRUE)) %>%
    rowSums() %>% as.numeric()
  
  data.frame(
    Category = paste0("Category_", number),
    Honesty = honesty_sum,
    Comprehensibility = comprehensibility_sum
  )
}

# Zusammenfassung für alle Kategorien (1-8)
table_data <- lapply(1:8, function(i) {
  create_combined_table(df_selected, honesty_patterns, comprehensibility_patterns, "Yes", i)
}) %>%
  bind_rows()

# Tabelle anzeigen
print(table_data)
