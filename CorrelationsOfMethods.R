# Honesty Scale
data <- data.frame(
  Text = c('T1', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'T8'),
  Binary_Decision = c(3, 5, 1, 6, 4, 6, 2, 7),  
  Direct_Quality = c(4, 5, 1, 6, 2, 7, 3, 8),   
  BWS = c(4, 5, 3, 7, 2, 6, 1, 8),              
  AB_Testing = c(4, 5, 2, 6, 3, 7, 1, 7)        
)

#Comprehensibility Scale 
data <- data.frame(
  Text = c('T1', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'T8'),
  Binary_Decision = c(2, 3, 2, 5, 3, 4, 1, 4),  
  Direct_Quality = c(3, 2, 3, 5, 4, 6, 1, 5),   
  BWS = c(1, 4, 3, 6, 2, 7, 5, 8),              
  AB_Testing = c(5, 4, 2, 8, 3, 7, 1, 6)        
)

#Total 
data <- data.frame(
  Text = c('T1', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'T8'),
  Binary_Decision = c(3, 5, 1, 7, 4, 6, 2, 7),  
  Direct_Quality = c(4, 5, 2, 6, 3, 7, 1, 8),   
  BWS = c(4, 5, 3, 7, 2, 6, 1, 8),              
  AB_Testing = c(4, 5, 2, 6, 3, 8, 1, 7)        
)

#Honesty LLM
data <- data.frame(
  Text = c('T1', 'T2', 'T3', 'T4'),
  Binary_Decision = c(1, 2, 4, 3),  
  Direct_Quality = c(1, 2, 3, 4),   
  BWS = c(1, 4, 2, 3),              
  AB_Testing = c(1, 2, 4, 3)        
)

#Comprehensibility LLM 
data <- data.frame(
  Text = c('T1', 'T2', 'T3', 'T4'),
  Binary_Decision = c(1, 4, 3, 2),  
  Direct_Quality = c(1, 3, 4, 2),   
  BWS = c(1, 2, 3, 4),              
  AB_Testing = c(1, 4, 3, 2)        
)

# Kendall-Korrelation berechnen
kendall_corr <- cor(data[, 2:5], method = "kendall")
print("Kendall's Korrelationsmatrix:")
print(kendall_corr)

library(corrplot)
corrplot(kendall_corr, method = "number", type = "upper", title = "Kendall's Correlation")
