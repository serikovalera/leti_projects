#Задание 1
library(XML)
library(utils)
library(dplyr)

url1<-"http://www.pogodaiklimat.ru/history/26702.htm"
yearsforKaliningrad <- readHTMLTable(url1, which = 1)
kaliningrad<-readHTMLTable(url1,which=2)
names(kaliningrad)[13] <- "год"
kaliningradTable <- cbind(yearsforKaliningrad, kaliningrad$год)

url2<-"http://www.pogodaiklimat.ru/history/37171.htm"
yearsForAdler <- readHTMLTable(url2, which = 1)
adler<-readHTMLTable(url2,which=2)
names(adler)[13] <- "год"
adlerTable <- cbind(yearsForAdler, adler$год)


url3<-"http://www.pogodaiklimat.ru/history/30758.htm"
yearsForChita <- readHTMLTable(url3, which = 1)
chita<-readHTMLTable(url3,which=2)
names(chita)[13] <- "год"
chitaTable <- cbind(yearsForChita, chita$год)


rezTable <- full_join(kaliningradTable, adlerTable, by = "год") %>%
  full_join(., chitaTable, by = "год")

tableOfCities <- rezTable %>%
  arrange(год)
tableOfCities <- tail(tableOfCities, 64)
tableOfCities <- head(tableOfCities, 63)

citys <- c("Год", "Калининград", "Адлер", "Чита")
colnames(tableOfCities) <- citys

#Задание 2
tableOfCities$Год <- as.integer(tableOfCities$Год)
tableOfCities$Калининград <- as.double(tableOfCities$Калининград)
tableOfCities$Адлер <- as.double(tableOfCities$Адлер)
tableOfCities$Чита <- as.double(tableOfCities$Чита)
summary_data <- summary(tableOfCities)

#tableOfCities <- tableOfCities %>% select(-1)
stacked_data <- stack(tableOfCities)

dotplot(values ~ ind, data = stacked_data, main = 'Диаграмма рассеивания без эффекта дрожания')
aggregat <- aggregate(values ~ ind, data = stacked_data,
                      function(x) round(c(mean = mean(x), sd = sd(x)), 2))

library(ggplot2)
stacked_data <- stack(tableOfCities)
ggplot(stacked_data) +
  aes(x = ind, y = values, color = ind) +
  geom_jitter() +
  theme(legend.position = "none") + 
  labs(subtitle="Диаграмма рассеивания с эффектом дрожания")

stacked_data <- stack(tableOfCities)
aggregat <- aggregate(values ~ ind, data = stacked_data,
                      function(x) round(c(mean = mean(x), sd = sd(x)), 2))

res_aov <- aov(values ~ ind, data = stacked_data)

par(mfrow = c(1, 2)) # объединяем 2 графика

# гистограмма
hist(res_aov$residuals)

# QQ-plot
library(car)
car::qqPlot(res_aov$residuals, id = FALSE) # id = FALSE to remove 						         # point identification


boxplot(values ~ ind, data = stacked_data, main = "ГРАФИЧЕСКАЯ ПРОВЕРКА ОДНОРОДНОСТИ ДИСПЕРСИИ") 


#Задание 3
cor_matrix <- cor(tableOfCities[, c("Калининград", "Адлер", "Чита")])
corrplot(cor_matrix, method = "color")

# Нормальность
#Графическая проверка на нормальность
par(mfrow = c(2, 2))

for (city in colnames(tableOfCities)) {
  res_aov <- aov(tableOfCities[[city]] ~ 1, data = stacked_data)
  hist(res_aov$residuals, main = city)
  qqPlot(res_aov$residuals, id = FALSE, main = city)
}

for (i in colnames(tableOfCities)){
  print(i)
  print(shapiro.test(tableOfCities[[i]]))
}


#Проверка однородности дисперсии и критерий Левенэ
leven_test <- leveneTest(values ~ ind, data = stacked_data)

#Задание 4
# Стандартный однофакторный дисперсионный анализ:
oneway.test (values ~ ind, data = stacked_data,
             var.equal = TRUE)

#Задание 5
res_aov <- aov(values ~ ind, data = stacked_data)
TukeyHSD(res_aov)
# Визуализация результатов:
plot(TukeyHSD(res_aov, conf.level=.95), las = 2)

