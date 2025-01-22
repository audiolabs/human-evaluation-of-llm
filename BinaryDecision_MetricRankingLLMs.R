library(dplyr)
library(readxl)

df_numeric <- df %>%
  mutate(across(everything(), ~ case_when(
    . == "Yes" ~ "Yes",
    . == "No" ~ "No",
    . == "I don't know" ~ "I don't know"
  )))

calculate_metric_yes_counts <- function(metric_columns) {
  summarized_df <- data.frame(
    Model = c("GPT", "LLaMA", "Mistral", "Luminous"),
    Yes_Total = c(
      sum(df_numeric[metric_columns[1]] == "Yes", df_numeric[metric_columns[2]] == "Yes", na.rm = TRUE),
      sum(df_numeric[metric_columns[3]] == "Yes", df_numeric[metric_columns[4]] == "Yes", na.rm = TRUE),
      sum(df_numeric[metric_columns[5]] == "Yes", df_numeric[metric_columns[6]] == "Yes", na.rm = TRUE),
      sum(df_numeric[metric_columns[7]] == "Yes", df_numeric[metric_columns[8]] == "Yes", na.rm = TRUE)
    )
  )
  return(summarized_df)
}

honesty_columns <- c("Honesty_1", "Honesty_2", "Honesty_3", "Honesty_4", "Honesty_5", "Honesty_6", "Honesty_7", "Honesty_8")
comprehensibility_columns <- c("Comprehensible_1", "Comprehensible_2", "Comprehensible_3", "Comprehensible_4", "Comprehensible_5", "Comprehensible_6", "Comprehensible_7", "Comprehensible_8")
correctness_columns <- c("Correctness_1", "Correctness_2", "Correctness_3", "Correctness_4", "Correctness_5", "Correctness_6", "Correctness_7", "Correctness_8")
context_adherent_columns <- c("ContextAdherent_1", "ContextAdherent_2", "ContextAdherent_3", "ContextAdherent_4", "ContextAdherent_5", "ContextAdherent_6", "ContextAdherent_7", "ContextAdherent_8")
relevancy_columns <- c("Relevancy_1", "Relevancy_2", "Relevancy_3", "Relevancy_4", "Relevancy_5", "Relevancy_6", "Relevancy_7", "Relevancy_8")
completeness_columns <- c("Completeness_1", "Completeness_2", "Completeness_3", "Completeness_4", "Completeness_5", "Completeness_6", "Completeness_7", "Completeness_8")
fluency_columns <- c("Fluency_1", "Fluency_2", "Fluency_3", "Fluency_4", "Fluency_5", "Fluency_6", "Fluency_7", "Fluency_8")
understandability_columns <- c("Understandability_1", "Understandability_2", "Understandability_3", "Understandability_4", "Understandability_5", "Understandability_6", "Understandability_7", "Understandability_8")
non_redundancy_columns <- c("NonRedundancy_1", "NonRedundancy_2", "NonRedundancy_3", "NonRedundancy_4", "NonRedundancy_5", "NonRedundancy_6", "NonRedundancy_7", "NonRedundancy_8")
readability_columns <- c("Readability_1", "Readability_2", "Readability_3", "Readability_4", "Readability_5", "Readability_6", "Readability_7", "Readability_8")

honesty_yes_counts_df <- calculate_metric_yes_counts(honesty_columns)
comprehensibility_yes_counts_df <- calculate_metric_yes_counts(comprehensibility_columns)
correctness_yes_counts_df <- calculate_metric_yes_counts(correctness_columns)
context_adherent_yes_counts_df <- calculate_metric_yes_counts(context_adherent_columns)
relevancy_yes_counts_df <- calculate_metric_yes_counts(relevancy_columns)
completeness_yes_counts_df <- calculate_metric_yes_counts(completeness_columns)
fluency_yes_counts_df <- calculate_metric_yes_counts(fluency_columns)
understandability_yes_counts_df <- calculate_metric_yes_counts(understandability_columns)
non_redundancy_yes_counts_df <- calculate_metric_yes_counts(non_redundancy_columns)
readability_yes_counts_df <- calculate_metric_yes_counts(readability_columns)

ranked_honesty_df <- honesty_yes_counts_df %>%
  arrange(desc(Yes_Total)) %>%
  mutate(Rank = dense_rank(desc(Yes_Total)), Metric = "Honesty")

ranked_comprehensibility_df <- comprehensibility_yes_counts_df %>%
  arrange(desc(Yes_Total)) %>%
  mutate(Rank = dense_rank(desc(Yes_Total)), Metric = "Comprehensibility")

ranked_correctness_df <- correctness_yes_counts_df %>%
  arrange(desc(Yes_Total)) %>%
  mutate(Rank = dense_rank(desc(Yes_Total)), Metric = "Correctness")

ranked_context_adherent_df <- context_adherent_yes_counts_df %>%
  arrange(desc(Yes_Total)) %>%
  mutate(Rank = dense_rank(desc(Yes_Total)), Metric = "Context Adherence")

ranked_relevancy_df <- relevancy_yes_counts_df %>%
  arrange(desc(Yes_Total)) %>%
  mutate(Rank = dense_rank(desc(Yes_Total)), Metric = "Relevancy")

ranked_completeness_df <- completeness_yes_counts_df %>%
  arrange(desc(Yes_Total)) %>%
  mutate(Rank = dense_rank(desc(Yes_Total)), Metric = "Completeness")

ranked_fluency_df <- fluency_yes_counts_df %>%
  arrange(desc(Yes_Total)) %>%
  mutate(Rank = dense_rank(desc(Yes_Total)), Metric = "Fluency")

ranked_understandability_df <- understandability_yes_counts_df %>%
  arrange(desc(Yes_Total)) %>%
  mutate(Rank = dense_rank(desc(Yes_Total)), Metric = "Understandability")

ranked_non_redundancy_df <- non_redundancy_yes_counts_df %>%
  arrange(desc(Yes_Total)) %>%
  mutate(Rank = dense_rank(desc(Yes_Total)), Metric = "Non-Redundancy")

ranked_readability_df <- readability_yes_counts_df %>%
  arrange(desc(Yes_Total)) %>%
  mutate(Rank = dense_rank(desc(Yes_Total)), Metric = "Readability")

list(
  Honesty = ranked_honesty_df,
  Comprehensibility = ranked_comprehensibility_df,
  Correctness = ranked_correctness_df,
  Context_Adherence = ranked_context_adherent_df,
  Relevancy = ranked_relevancy_df,
  Completeness = ranked_completeness_df,
  Fluency = ranked_fluency_df,
  Understandability = ranked_understandability_df,
  Non_Redundancy = ranked_non_redundancy_df,
  Readability = ranked_readability_df
)
