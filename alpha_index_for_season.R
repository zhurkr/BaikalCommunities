
#use data_merged from boxplot_script.R

# вектор с желаемым порядком для season
desired_order_season<- c("February 2022", "March 2022", "April 2022", "May 2022", "June 2022", "July 2022", "August 2022", "September 2022","October 2022", "November 2022", "December 2022", "February 2023")

# Преобразование 'Season' в фактор с уровнями в желаемом порядке
data_merged$Season <- factor(data_merged$Season, levels = desired_order_season)

data_merged$Lifestyle <- as.factor(data_merged$Lifestyle)

chao_m <- ggplot(data_merged, aes(x = Season, y = S.chao1, color = Lifestyle)) +
  geom_point(stat = "identity", position = position_dodge()) + # Используйте position_dodge с шириной для разделения точек по группам
  theme_minimal() +
  labs(title = "Значения chao по месяцам для групп FL и PA",
       x = "Season",
       y = "chao") +
  scale_color_brewer(palette = "Set1") + # Цветовая палитра для линий, а не для заливки
  theme(axis.text.x = element_text(angle = 45, hjust = 1)); # Поворот текста оси X для лучшей читаемости

ggsave("chao_m.jpeg", plot = chao_m, width = 10, height = 6, dpi = 300)


ACE_m <- ggplot(data_merged, aes(x = Season, y = S.ACE, color = Lifestyle)) +
  geom_point(stat = "identity", position = position_dodge()) + # Используйте position_dodge с шириной для разделения точек по группам
  theme_minimal() +
  labs(title = "Значения ACE по месяцам для групп FL и PA",
       x = "Season",
       y = "ACE") +
  scale_color_brewer(palette = "Set1") + # Цветовая палитра для линий, а не для заливки
  theme(axis.text.x = element_text(angle = 45, hjust = 1)); # Поворот текста оси X для лучшей читаемости

ggsave("ACE_m.jpeg", plot = ACE_m, width = 10, height = 6, dpi = 300)

simpson_m <- ggplot(data_merged, aes(x = Season, y = simpson, color = Lifestyle)) +
  geom_point(stat = "identity", position = position_dodge()) + # Используйте position_dodge с шириной для разделения точек по группам
  theme_minimal() +
  labs(title = "Значения simpson по месяцам для групп FL и PA",
       x = "Season",
       y = "simpson") +
  scale_color_brewer(palette = "Set1") + # Цветовая палитра для линий, а не для заливки
  theme(axis.text.x = element_text(angle = 45, hjust = 1)); # Поворот текста оси X для лучшей читаемости

ggsave("simpson_m.jpeg", plot = simpson_m, width = 10, height = 6, dpi = 300)


shannon_m <- ggplot(data_merged, aes(x = Season, y = shannon, color = Lifestyle)) +
  geom_point(stat = "identity", position = position_dodge()) + # Используйте position_dodge с шириной для разделения точек по группам
  theme_minimal() +
  labs(title = "Значения shannon по месяцам для групп FL и PA",
       x = "Season",
       y = "shannon") +
  scale_color_brewer(palette = "Set1") + # Цветовая палитра для линий, а не для заливки
  theme(axis.text.x = element_text(angle = 45, hjust = 1)); # Поворот текста оси X для лучшей читаемости

ggsave("shannon_m.jpeg", plot = shannon_m, width = 10, height = 6, dpi = 300)