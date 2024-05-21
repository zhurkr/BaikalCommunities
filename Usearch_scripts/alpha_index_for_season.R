
#use data_merged from boxplot_script.R

# РІРµРєС‚РѕСЂ СЃ Р¶РµР»Р°РµРјС‹Рј РїРѕСЂСЏРґРєРѕРј РґР»СЏ season
desired_order_season<- c("February 2022", "March 2022", "April 2022", "May 2022", "June 2022", "July 2022", "August 2022", "September 2022","October 2022", "November 2022", "December 2022", "February 2023")

# РџСЂРµРѕР±СЂР°Р·РѕРІР°РЅРёРµ 'Season' РІ С„Р°РєС‚РѕСЂ СЃ СѓСЂРѕРІРЅСЏРјРё РІ Р¶РµР»Р°РµРјРѕРј РїРѕСЂСЏРґРєРµ
data_merged$Season <- factor(data_merged$Season, levels = desired_order_season)

data_merged$Lifestyle <- as.factor(data_merged$Lifestyle)

chao_m <- ggplot(data_merged, aes(x = Season, y = S.chao1, color = Lifestyle)) +
  geom_point(stat = "identity", position = position_dodge()) + # РСЃРїРѕР»СЊР·СѓР№С‚Рµ position_dodge СЃ С€РёСЂРёРЅРѕР№ РґР»СЏ СЂР°Р·РґРµР»РµРЅРёСЏ С‚РѕС‡РµРє РїРѕ РіСЂСѓРїРїР°Рј
  theme_minimal() +
  labs(title = "Р—РЅР°С‡РµРЅРёСЏ chao РїРѕ РјРµСЃСЏС†Р°Рј РґР»СЏ РіСЂСѓРїРї FL Рё PA",
       x = "Season",
       y = "chao") +
  scale_color_brewer(palette = "Set1") + # Р¦РІРµС‚РѕРІР°СЏ РїР°Р»РёС‚СЂР° РґР»СЏ Р»РёРЅРёР№, Р° РЅРµ РґР»СЏ Р·Р°Р»РёРІРєРё
  theme(axis.text.x = element_text(angle = 45, hjust = 1)); # РџРѕРІРѕСЂРѕС‚ С‚РµРєСЃС‚Р° РѕСЃРё X РґР»СЏ Р»СѓС‡С€РµР№ С‡РёС‚Р°РµРјРѕСЃС‚Рё

ggsave("chao_m.jpeg", plot = chao_m, width = 10, height = 6, dpi = 300)


ACE_m <- ggplot(data_merged, aes(x = Season, y = S.ACE, color = Lifestyle)) +
  geom_point(stat = "identity", position = position_dodge()) + # РСЃРїРѕР»СЊР·СѓР№С‚Рµ position_dodge СЃ С€РёСЂРёРЅРѕР№ РґР»СЏ СЂР°Р·РґРµР»РµРЅРёСЏ С‚РѕС‡РµРє РїРѕ РіСЂСѓРїРїР°Рј
  theme_minimal() +
  labs(title = "Р—РЅР°С‡РµРЅРёСЏ ACE РїРѕ РјРµСЃСЏС†Р°Рј РґР»СЏ РіСЂСѓРїРї FL Рё PA",
       x = "Season",
       y = "ACE") +
  scale_color_brewer(palette = "Set1") + # Р¦РІРµС‚РѕРІР°СЏ РїР°Р»РёС‚СЂР° РґР»СЏ Р»РёРЅРёР№, Р° РЅРµ РґР»СЏ Р·Р°Р»РёРІРєРё
  theme(axis.text.x = element_text(angle = 45, hjust = 1)); # РџРѕРІРѕСЂРѕС‚ С‚РµРєСЃС‚Р° РѕСЃРё X РґР»СЏ Р»СѓС‡С€РµР№ С‡РёС‚Р°РµРјРѕСЃС‚Рё

ggsave("ACE_m.jpeg", plot = ACE_m, width = 10, height = 6, dpi = 300)

simpson_m <- ggplot(data_merged, aes(x = Season, y = simpson, color = Lifestyle)) +
  geom_point(stat = "identity", position = position_dodge()) + # РСЃРїРѕР»СЊР·СѓР№С‚Рµ position_dodge СЃ С€РёСЂРёРЅРѕР№ РґР»СЏ СЂР°Р·РґРµР»РµРЅРёСЏ С‚РѕС‡РµРє РїРѕ РіСЂСѓРїРїР°Рј
  theme_minimal() +
  labs(title = "Р—РЅР°С‡РµРЅРёСЏ simpson РїРѕ РјРµСЃСЏС†Р°Рј РґР»СЏ РіСЂСѓРїРї FL Рё PA",
       x = "Season",
       y = "simpson") +
  scale_color_brewer(palette = "Set1") + # Р¦РІРµС‚РѕРІР°СЏ РїР°Р»РёС‚СЂР° РґР»СЏ Р»РёРЅРёР№, Р° РЅРµ РґР»СЏ Р·Р°Р»РёРІРєРё
  theme(axis.text.x = element_text(angle = 45, hjust = 1)); # РџРѕРІРѕСЂРѕС‚ С‚РµРєСЃС‚Р° РѕСЃРё X РґР»СЏ Р»СѓС‡С€РµР№ С‡РёС‚Р°РµРјРѕСЃС‚Рё

ggsave("simpson_m.jpeg", plot = simpson_m, width = 10, height = 6, dpi = 300)


shannon_m <- ggplot(data_merged, aes(x = Season, y = shannon, color = Lifestyle)) +
  geom_point(stat = "identity", position = position_dodge()) + # РСЃРїРѕР»СЊР·СѓР№С‚Рµ position_dodge СЃ С€РёСЂРёРЅРѕР№ РґР»СЏ СЂР°Р·РґРµР»РµРЅРёСЏ С‚РѕС‡РµРє РїРѕ РіСЂСѓРїРїР°Рј
  theme_minimal() +
  labs(title = "Р—РЅР°С‡РµРЅРёСЏ shannon РїРѕ РјРµСЃСЏС†Р°Рј РґР»СЏ РіСЂСѓРїРї FL Рё PA",
       x = "Season",
       y = "shannon") +
  scale_color_brewer(palette = "Set1") + # Р¦РІРµС‚РѕРІР°СЏ РїР°Р»РёС‚СЂР° РґР»СЏ Р»РёРЅРёР№, Р° РЅРµ РґР»СЏ Р·Р°Р»РёРІРєРё
  theme(axis.text.x = element_text(angle = 45, hjust = 1)); # РџРѕРІРѕСЂРѕС‚ С‚РµРєСЃС‚Р° РѕСЃРё X РґР»СЏ Р»СѓС‡С€РµР№ С‡РёС‚Р°РµРјРѕСЃС‚Рё

ggsave("shannon_m.jpeg", plot = shannon_m, width = 10, height = 6, dpi = 300)