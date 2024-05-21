#relative_abundance

#family
data_family<-read.csv("BD.z_family_summary.txt", header=TRUE, sep="\t", check.names = FALSE)
data_family <- data_family[,-ncol(data_family)] #remove column "all"

colnames(data_family)[c(12, 18, 19, 20, 21, 22, 23, 24, 25)] <- c("BD01", "BD02", "BD03", "BD04", "BD05", "BD06", "BD07", "BD08", "BD09")

data_family_top12 <- data_family[c(2:13), ] #deleted Unassigned, leave top12

data_family_top12 <- data_family_top12[c('Family', 'BD01', 'BD03', 'BD05', 'BD07', 'BD09', 'BD11', 'BD13', 'BD15', 'BD17', 'BD19', 'BD21', 'BD23', 'BD02', 'BD04', 'BD06', 'BD08', 'BD10', 'BD12', 'BD14', 'BD16', 'BD18', 'BD20', 'BD22', 'BD24')]


#separate data_family_top12_FL and data_family_top12_PA
family_top12_FL <- data_family_top12[c(1:13)]
family_top12_PA <- data_family_top12[c(1,14:25)]

#change format from wide to long
family_top12_FL_long <- pivot_longer(
  family_top12_FL, 
  cols = -Family)

family_top12_PA_long <- pivot_longer(
  family_top12_PA, 
  cols = -Family)



#top12 histogram
relative_abundance_family_top12_FL <- ggplot(family_top12_FL_long, aes(x = name, y = value, fill = Family)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_fill_brewer(palette = "Paired") + # Добавляем палитру Paired
  labs(title = "Relative abundances of the FL bacterial family (top12)", 
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

ggsave("relative_abundance_family_top12_FL.jpeg", plot = relative_abundance_family_top12_FL, width = 10, height = 6, dpi = 300)




relative_abundance_family_top12_PA <- ggplot(family_top12_PA_long, aes(x = name, y = value, fill = Family)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_fill_brewer(palette = "Paired") + # Добавляем палитру Paired
  labs(title = "Relative abundances of the PA bacterial family (top12)", 
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

ggsave("relative_abundance_family_top12_PA.jpeg", plot = relative_abundance_family_top12_PA, width = 10, height = 6, dpi = 300)
