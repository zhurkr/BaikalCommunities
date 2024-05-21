#relative_abundance

#class
data_class<-read.csv("BD.z_class_summary.txt", header=TRUE, sep="\t", check.names = FALSE)
data_class <- data_class[,-ncol(data_class)] #remove column "all"

colnames(data_class)[c(12, 18, 19, 20, 21, 22, 23, 24, 25)] <- c("BD01", "BD02", "BD03", "BD04", "BD05", "BD06", "BD07", "BD08", "BD09")

data_class_top12 <- data_class[-c(1, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32), ] #deleted Unassigned, leave top12

data_class_top12 <- data_class_top12[c('Class', 'BD01', 'BD03', 'BD05', 'BD07', 'BD09', 'BD11', 'BD13', 'BD15', 'BD17', 'BD19', 'BD21', 'BD23', 'BD02', 'BD04', 'BD06', 'BD08', 'BD10', 'BD12', 'BD14', 'BD16', 'BD18', 'BD20', 'BD22', 'BD24')]


#separate data_family_top12_FL and data_family_top12_PA
class_top12_FL <- data_class_top12[c(1:13)]
class_top12_PA <- data_class_top12[c(1,14:25)]

#change format from wide to long
class_top12_FL_long <- pivot_longer(
  class_top12_FL, 
  cols = -Class)

class_top12_PA_long <- pivot_longer(
  class_top12_PA, 
  cols = -Class)



#top12 histogram
relative_abundance_class_top12_FL <- ggplot(class_top12_FL_long, aes(x = name, y = value, fill = Class)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_fill_brewer(palette = "Paired") + # Добавляем палитру Paired
  labs(title = "Relative abundances of the FL bacterial class (top12)", 
       x = "samples", 
       y = "abundance") +
  theme(
    plot.title = element_text(hjust = 0.5, size = 20), 
    axis.title.x = element_text(size = 15), 
    axis.title.y = element_text(size = 15), 
    axis.text.x = element_text(angle = 45, hjust = 1, size = 15), # Объединяем настройки для текста оси X
    legend.text = element_text(size = 16),
    theme_minimal() 
  )

ggsave("relative_abundance_class_top12_FL.jpeg", plot = relative_abundance_class_top12_FL, width = 10, height = 6, dpi = 300)


relative_abundance_class_top12_PA <- ggplot(class_top12_PA_long, aes(x = name, y = value, fill = Class)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_fill_brewer(palette = "Paired") + # Добавляем палитру Paired
  labs(title = "Relative abundances of the PA bacterial class (top12)", 
       x = "samples", 
       y = "abundance") +
  theme(
    plot.title = element_text(hjust = 0.5, size = 20), 
    axis.title.x = element_text(size = 15), 
    axis.title.y = element_text(size = 15), 
    axis.text.x = element_text(angle = 45, hjust = 1, size = 15), # Объединяем настройки для текста оси X
    legend.text = element_text(size = 16),
    theme_minimal() 
  )

ggsave("relative_abundance_class_top12_PA.jpeg", plot = relative_abundance_class_top12_PA, width = 10, height = 6, dpi = 300)

