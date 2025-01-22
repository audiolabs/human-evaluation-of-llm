library(readxl)
library(dplyr)
library(tidyr)
library(pwr)



df$T1_Honesty <- rowMeans(df[, c("Honesty_1", "Completeness_1", "Correctness_1", "AnswerRelevancy_1", "ContextAdherence_1", "Honesty_2", "Completeness_2", "Correctness_2", "AnswerRelevancy_2", "ContextAdherence_2")])

df$T3_Honesty <- rowMeans(df[, c("Honesty_3", "Completeness_3", "Correctness_3", "AnswerRelevancy_3", "ContextAdherence_3", "Honesty_4", "Completeness_4", "Correctness_4", "AnswerRelevancy _4", "ContextAdherence_4")])

df$T5_Honesty <- rowMeans(df[, c("Honesty_5", "Completeness_5", "Correctness_5", "AnswerRelevancy_5", "ContextAdherence_5", "Honesty_6", "Completeness_6", "Correctness_6", "AnswerRelevancy_6", "ContextAdherence_6")])

df$T7_Honesty <- rowMeans(df[, c("Honesty_7", "Completeness_7", "Correctness_7", "AnswerRelevancy_7", "ContextAdherence_7", "Honesty_8", "Completeness_8", "Correctness_8", "AnswerRelevancy_8", "ContextAdherence_8")])

df$T1_Comprehend <- rowMeans(df[, c("Comprehensibility_1", "Readability_1", "Fluency_1", "Understandability_1", "Non-Redundancy_1", "Comprehensibility_2", "Readability_2", "Fluency_2", "Understandability_2", "Non-Redundancy_2")])

df$T3_Comprehend <- rowMeans(df[, c("Comprehensibility_3", "Readability_3", "Fluency_3", "Understandability_3", "Non-Redundancy_3", "Comprehensibility_4", "Readability_4", "Fluency_4", "Understandability_4", "Non-Redundancy_4")])

df$T5_Comprehend <- rowMeans(df[, c("Comprehensibility_5", "Readability_5", "Fluency_5", "Understandability_5", "Non-Redundancy_5", "Comprehensibility_6", "Readability_6", "Fluency_6", "Understandability_6", "Non-Redundancy_6")])

df$T7_Comprehend <- rowMeans(df[, c("Comprehensibility_7", "Readability_7", "Fluency_7", "Understandability_7", "Non-Redundancy_7", "Comprehensibility_8", "Readability_8", "Fluency_8", "Understandability_8", "Non-Redundancy_8")])

df$T1_Total <- rowMeans(df[, c("Comprehensibility_1", "Readability_1", "Fluency_1", "Understandability_1", "Non-Redundancy_1", "Honesty_1", "Completeness_1", "Correctness_1", "AnswerRelevancy_1", "ContextAdherence_1",
                               "Honesty_2", "Completeness_2", "Correctness_2", "AnswerRelevancy_2", "ContextAdherence_2", "Comprehensibility_2", "Readability_2", "Fluency_2", "Understandability_2", "Non-Redundancy_2")])

df$T3_Total <- rowMeans(df[, c("Comprehensibility_3", "Readability_3", "Fluency_3", "Understandability_3", "Non-Redundancy_3","Honesty_3", "Completeness_3", "Correctness_3", "AnswerRelevancy_3", "ContextAdherence_3", 
                               "Honesty_4", "Completeness_4", "Correctness_4", "AnswerRelevancy _4", "ContextAdherence_4", "Comprehensibility_4", "Readability_4", "Fluency_4", "Understandability_4", "Non-Redundancy_4")])

df$T5_Total <- rowMeans(df[, c("Comprehensibility_5", "Readability_5", "Fluency_5", "Understandability_5", "Non-Redundancy_5", "Honesty_5", "Completeness_5", "Correctness_5", "AnswerRelevancy_5", "ContextAdherence_5", 
                               "Honesty_6", "Completeness_6", "Correctness_6", "AnswerRelevancy_6", "ContextAdherence_6", "Comprehensibility_6", "Readability_6", "Fluency_6", "Understandability_6", "Non-Redundancy_6")])

df$T7_Total <- rowMeans(df[, c("Comprehensibility_7", "Readability_7", "Fluency_7", "Understandability_7", "Non-Redundancy_7", "Honesty_7", "Completeness_7", "Correctness_7", "AnswerRelevancy_7", "ContextAdherence_7", 
                               "Honesty_8", "Completeness_8", "Correctness_8", "AnswerRelevancy_8", "ContextAdherence_8", "Comprehensibility_8", "Readability_8", "Fluency_8", "Understandability_8", "Non-Redundancy_8")])


#replace with other metrices:
mean_value <- mean(c(df$Honesty_1, df$Honesty_2), na.rm = TRUE)
print(mean_value)

mean_value <- mean(c(df$Honesty_3, df$Honesty_4), na.rm = TRUE)
print(mean_value)

mean_value <- mean(c(df$Honesty_5, df$Honesty_6), na.rm = TRUE)
print(mean_value)

mean_value <- mean(c(df$Honesty_7, df$Honesty_8), na.rm = TRUE)
print(mean_value)


#HONESTY:

library(rstatix)
test <- df %>%
  gather(key = "honesty", value = "score", T1_Honesty, T3_Honesty, T5_Honesty, T7_Honesty)%>%
  convert_as_factor(honesty)
View(test)

test %>%
  group_by(honesty) %>%
  get_summary_stats(score, type = "mean_sd")

library(ggpubr)

bxp <- ggboxplot(test, x = "honesty", y = "score", add = "point")
bxp


test_clean <- test %>%
  group_by(id, honesty) %>%
  summarise(score = mean(score), .groups = 'drop')

test_wide <- test_clean %>%
  pivot_wider(names_from = honesty, values_from = score)

#ANOVA
res.aov <- anova_test(data = test_clean, dv = score, wid = id, within = honesty)
res.aov

# Post-hoc paarweise Vergleiche (mit Bonferroni-Korrektur)
posthoc <- test_clean %>%
  pairwise_t_test(
    score ~ honesty, 
    paired = TRUE, 
    p.adjust.method = "bonferroni"
  )

# Ergebnisse anzeigen
posthoc



f <- 0.507  # Effektgröße 
alpha <- 0.05  # Signifikanzniveau
power <- 0.80  # Gewünschte Power
k <- 4  # Anzahl der Stufen der wiederholten Messungen bei LLMs

# Power-Analyse für wiederholte Messungen ANOVA
power_analysis <- pwr.anova.test(k = k, f = f, sig.level = alpha, power = power)

# Ergebnis anzeigen
power_analysis


#COMPREHENSIBILITY:

test <- df %>%
  gather(key = "comprehensibility", value = "score", T1_Comprehend, T3_Comprehend, T5_Comprehend, T7_Comprehend)%>%
  convert_as_factor(comprehensibility)
View(test)

test %>%
  group_by(comprehensibility) %>%
  get_summary_stats(score, type = "mean_sd")


bxp <- ggboxplot(test, x = "comprehensibility", y = "score", add = "point")
bxp

test_clean <- test %>%
  group_by(id, comprehensibility) %>%
  summarise(score = mean(score), .groups = 'drop')

test_wide <- test_clean %>%
  pivot_wider(names_from = comprehensibility, values_from = score)

# ANOVA 
res.aov <- anova_test(data = test_clean, dv = score, wid = id, within = comprehensibility)
res.aov

# Post-hoc paarweise Vergleiche (mit Bonferroni-Korrektur)
posthoc <- test_clean %>%
  pairwise_t_test(
    score ~ comprehensibility, 
    paired = TRUE, 
    p.adjust.method = "bonferroni"
  )

# Ergebnisse anzeigen
posthoc


f <- 0.775  # Effektgröße 
alpha <- 0.05  # Signifikanzniveau
power <- 0.80  # Gewünschte Power
k <- 8  # Anzahl der Stufen der wiederholten Messungen

# Power-Analyse für wiederholte Messungen ANOVA
power_analysis <- pwr.anova.test(k = k, f = f, sig.level = alpha, power = power)

# Ergebnis anzeigen
power_analysis



# TOTAL: 

test <- df %>%
  gather(key = "total", value = "score", T1_Total, T3_Total, T5_Total, T7_Total)%>%
  convert_as_factor(total)
View(test)

test %>%
  group_by(total) %>%
  get_summary_stats(score, type = "mean_sd")

bxp <- ggboxplot(test, x = "total", y = "score", add = "point")
bxp

test_clean <- test %>%
  group_by(id, total) %>%
  summarise(score = mean(score), .groups = 'drop')

test_wide <- test_clean %>%
  pivot_wider(names_from = total, values_from = score)

# ANOVA
res.aov <- anova_test(data = test_clean, dv = score, wid = id, within = total)
res.aov

# Post-hoc paarweise Vergleiche (mit Bonferroni-Korrektur)
posthoc <- test_clean %>%
  pairwise_t_test(
    score ~ total, 
    paired = TRUE, 
    p.adjust.method = "bonferroni"
  )

# Ergebnisse anzeigen
posthoc


f <- 0.664  # Effektgröße
alpha <- 0.05  # Signifikanzniveau
power <- 0.80  # Gewünschte Power
k <- 4  # Anzahl der Stufen der wiederholten Messungen

# Power-Analyse für wiederholte Messungen ANOVA
power_analysis <- pwr.anova.test(k = k, f = f, sig.level = alpha, power = power)

# Ergebnis anzeigen
power_analysis


