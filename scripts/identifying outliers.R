pacman::p_load(tidyverse, gapminder, data.table)

data <- gapminder
data <- filter(data, year == 2007)
data <- filter(data, continent == "Africa")

options(scipen = 999)
data %>% 
  ggplot(aes(pop))+
  geom_boxplot()

data <- data %>% 
  mutate(is_outlier = pop>60000000)

data %>% 
  filter(is_outlier)


# Quantile method

IQR <- quantile(data$pop, 0.75) - quantile(data$pop, 0.25)

lower_threshold <-  quantile(data$pop, 0.25) - 1.5 * IQR
upper_threshold <- quantile(data$pop, 0.75) + 1.5 * IQR

data %>% 
  filter(pop < lower_threshold | pop > upper_threshold)




