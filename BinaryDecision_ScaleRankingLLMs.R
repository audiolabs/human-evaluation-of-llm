# Load necessary libraries
library(dplyr)
library(readxl)


df_numeric <- df %>%
  mutate(across(everything(), ~ case_when(
    . == "Yes" ~ "Yes",
    . == "No" ~ "No",
    . == "I don't know" ~ "I don't know"
  )))

# Honesty
calculate_honesty_yes_counts <- function() {
  summarized_df <- data.frame(
    Model = c("GPT", "LLaMA", "Mistral", "Luminous"),
    Yes_Total = c(
      sum(df_numeric$Honesty_1 == "Yes", df_numeric$Honesty_2 == "Yes", 
          df_numeric$Correctness_1 == "Yes", df_numeric$Correctness_2 == "Yes", 
          df_numeric$ContextAdherent_1 == "Yes", df_numeric$ContextAdherent_2 == "Yes", 
          df_numeric$Relevancy_1 == "Yes", df_numeric$Relevancy_2 == "Yes", 
          df_numeric$Completeness_1 == "Yes", df_numeric$Completeness_2 == "Yes", na.rm = TRUE),
      
      sum(df_numeric$Honesty_3 == "Yes", df_numeric$Honesty_4 == "Yes", 
          df_numeric$Correctness_3 == "Yes", df_numeric$Correctness_4 == "Yes", 
          df_numeric$ContextAdherent_3 == "Yes", df_numeric$ContextAdherent_4 == "Yes", 
          df_numeric$Relevancy_3 == "Yes", df_numeric$Relevancy_4 == "Yes", 
          df_numeric$Completeness_3 == "Yes", df_numeric$Completeness_4 == "Yes", na.rm = TRUE),
      
      sum(df_numeric$Honesty_5 == "Yes", df_numeric$Honesty_6 == "Yes", 
          df_numeric$Correctness_5 == "Yes", df_numeric$Correctness_6 == "Yes", 
          df_numeric$ContextAdherent_5 == "Yes", df_numeric$ContextAdherent_6 == "Yes", 
          df_numeric$Relevancy_5 == "Yes", df_numeric$Relevancy_6 == "Yes", 
          df_numeric$Completeness_5 == "Yes", df_numeric$Completeness_6 == "Yes", na.rm = TRUE),
      
      sum(df_numeric$Honesty_7 == "Yes", df_numeric$Honesty_8 == "Yes", 
          df_numeric$Correctness_7 == "Yes", df_numeric$Correctness_8 == "Yes", 
          df_numeric$ContextAdherent_7 == "Yes", df_numeric$ContextAdherent_8 == "Yes", 
          df_numeric$Relevancy_7 == "Yes", df_numeric$Relevancy_8 == "Yes", 
          df_numeric$Completeness_7 == "Yes", df_numeric$Completeness_8 == "Yes", na.rm = TRUE)
    )
  )
  return(summarized_df)
}

# Comprehensibility
calculate_comprehensibility_yes_counts <- function() {
  summarized_df <- data.frame(
    Model = c("GPT", "LLaMA", "Mistral", "Luminous"),
    Yes_Total = c(
      sum(df_numeric$Fluency_1 == "Yes", df_numeric$Fluency_2 == "Yes", 
          df_numeric$Understandability_1 == "Yes", df_numeric$Understandability_2 == "Yes", 
          df_numeric$NonRedundancy_1 == "Yes", df_numeric$NonRedundancy_2 == "Yes", 
          df_numeric$Readability_1 == "Yes", df_numeric$Readability_2 == "Yes", 
          df_numeric$Comprehensible_1 == "Yes", df_numeric$Comprehensible_2 == "Yes", na.rm = TRUE),
      
      sum(df_numeric$Fluency_3 == "Yes", df_numeric$Fluency_4 == "Yes", 
          df_numeric$Understandability_3 == "Yes", df_numeric$Understandability_4 == "Yes", 
          df_numeric$NonRedundancy_3 == "Yes", df_numeric$NonRedundancy_4 == "Yes", 
          df_numeric$Readability_3 == "Yes", df_numeric$Readability_4 == "Yes", 
          df_numeric$Comprehensible_3 == "Yes", df_numeric$Comprehensible_4 == "Yes", na.rm = TRUE),
  
      sum(df_numeric$Fluency_5 == "Yes", df_numeric$Fluency_6 == "Yes", 
          df_numeric$Understandability_5 == "Yes", df_numeric$Understandability_6 == "Yes", 
          df_numeric$NonRedundancy_5 == "Yes", df_numeric$NonRedundancy_6 == "Yes", 
          df_numeric$Readability_5 == "Yes", df_numeric$Readability_6 == "Yes",
          df_numeric$Comprehensible_5 == "Yes", df_numeric$Comprehensible_6 == "Yes", na.rm = TRUE),

      sum(df_numeric$Fluency_7 == "Yes", df_numeric$Fluency_8 == "Yes", 
          df_numeric$Understandability_7 == "Yes", df_numeric$Understandability_8 == "Yes", 
          df_numeric$NonRedundancy_7 == "Yes", df_numeric$NonRedundancy_8 == "Yes", 
          df_numeric$Comprehensible_7 == "Yes", df_numeric$Comprehensible_8 == "Yes",
          df_numeric$Readability_7 == "Yes", df_numeric$Readability_8 == "Yes", na.rm = TRUE)
    )
  )
  return(summarized_df)
}

honesty_yes_counts_df <- calculate_honesty_yes_counts()
comprehensibility_yes_counts_df <- calculate_comprehensibility_yes_counts()

# Basierend auf Ja-Antworten
ranked_honesty_df <- honesty_yes_counts_df %>%
  arrange(desc(Yes_Total)) %>%
  mutate(Rank = row_number())

ranked_comprehensibility_df <- comprehensibility_yes_counts_df %>%
  arrange(desc(Yes_Total)) %>%
  mutate(Rank = row_number())

ranked_honesty_df
ranked_comprehensibility_df
