library(ggplot2)
library(ggthemes)
library(dplyr)
library(tidyr)

# Get summarized data
summarizedData <- readRDS("summarizedData.rds")

# Calculate average for Mexico
averageForMexico <- summarizedData %>%
  filter(measure=="dollar_valuation", Country=="Mexico") %>%
  group_by(YEAR = as.factor(year(date))) %>%
  summarise(AVERAGE = mean(value, na.rm = TRUE))

# plot
ggplot(averageForMexico, aes(x=YEAR, y=AVERAGE, col=AVERAGE)) +
  geom_point(size=5) +
  scale_x_discrete(position = "top") +
  theme_economist() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1),
        legend.position = "right",
        legend.title = element_blank()) +
  labs(title = "México: sobrevaluación promedio (anual).") +
  labs(y = "Sobrevaluación (%)") + 
  labs(x = "Año")