#relative_abundance

#genus
data_genus<-read.csv("BD.z_genus_summary.txt", header=TRUE, sep="\t", check.names = FALSE)
data_genus <- data_genus[,-ncol(data_genus)] #remove column "all"

colnames(data_genus)[c(12, 18, 19, 20, 21, 22, 23, 24, 25)] <- c("BD01", "BD02", "BD03", "BD04", "BD05", "BD06", "BD07", "BD08", "BD09")

data_genus_top12 <- data_genus[c(2:13), ] #deleted Unassigned, leave top12

data_genus_top12 <- data_genus_top12[c('Genus', 'BD01', 'BD03', 'BD05', 'BD07', 'BD09', 'BD11', 'BD13', 'BD15', 'BD17', 'BD19', 'BD21', 'BD23', 'BD02', 'BD04', 'BD06', 'BD08', 'BD10', 'BD12', 'BD14', 'BD16', 'BD18', 'BD20', 'BD22', 'BD24')]


#separate data_genus_top12_FL and data_genus_top12_PA
genus_top12_FL <- data_genus_top12[c(1:13)]
genus_top12_PA <- data_genus_top12[c(1,14:25)]

#change format from wide to long
genus_top12_FL_long <- pivot_longer(
  genus_top12_FL, 
  cols = -Genus)

genus_top12_PA_long <- pivot_longer(
  genus_top12_PA, 
  cols = -Genus)



#top12 histogram
relative_abundance_genus_top12_FL <- ggplot(genus_top12_FL_long, aes(x = name, y = value, fill = Genus)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_fill_brewer(palette = "Paired") + # Добавляем палитру Paired
  labs(title = "Relative abundances of the FL bacterial genus (top12)", 
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

ggsave("relative_abundance_genus_top12_FL.jpeg", plot = relative_abundance_genus_top12_FL, width = 10, height = 6, dpi = 300)




relative_abundance_genus_top12_PA <- ggplot(genus_top12_PA_long, aes(x = name, y = value, fill = Genus)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_fill_brewer(palette = "Paired") + # Добавляем палитру Paired
  labs(title = "Relative abundances of the PA bacterial genus (top12)", 
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

ggsave("relative_abundance_genus_top12_PA.jpeg", plot = relative_abundance_genus_top12_PA, width = 10, height = 6, dpi = 300)

