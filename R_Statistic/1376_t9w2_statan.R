#-------------------task-1.1
#1857
df<- c(-3.3, -3.9, 0.9, 5.4, 9.7, 14.7, 16.4, 18.9, 14.4, 9.6, 2.0, 2.7, 7.3) #создаём отдельный массив со значениями года
n <- 12
print(shapiro.test(df)) #проверяем с помощью критерия Шапиро-Уилка

year1857 <- rnorm(n,mean(df),sd(df)) # считаем значения
hist(year1857) #рисуем гистограмму

#-------------------task-1.2
#alfa = 0.095, 1-0.095 = 0.905

# Построение доверительного интервала
confidence_level <- 0.905
t_interval <- t.test(df, conf.level = confidence_level)

# Создание графика
ggplot(data.frame(x = 1), aes(x = x)) +
geom_errorbar(aes(ymin = t_interval$conf.int[1], ymax = t_interval$conf.int[2]), width = 0.1) +
geom_point(aes(y = mean(df)), color = "red", size = 3) +
labs(title = "Доверительный интервал", y = "Среднее значение") +
theme_minimal()

#---------------------task-1.3
# Уровень доверия
df<- c(-3.3, -3.9, 0.9, 5.4, 9.7, 14.7, 16.4, 18.9, 14.4, 9.6, 2.0, 2.7, 7.3)
confidence_level <- 0.95


# Вычисляем доверительный интервал для медианы
median_ci <- quantile(df, probs = c((1 - confidence_level) / 2, 1 - (1 - confidence_level) / 2))

# Предполагаемое значение медианы (гипотеза)
hypothetical_median <- median(df)#считаем медиану

# Проверяем, содержится ли предполагаемое значение в доверительном интервале
if (hypothetical_median >= median_ci[1] && hypothetical_median <= median_ci[2]) {
  cat("Гипотеза о равенстве медианы", hypothetical_median, "содержится в доверительном интервале:", median_ci[1], "-", median_ci[2], "\n")
} else {
  cat("Гипотеза о равенстве медианы", hypothetical_median, "не содержится в доверительном интервале:", median_ci[1], "-", median_ci[2], "\n")
}

#-------------------task-1.4
# Заданное стандартное отклонение
sigma <- 10

# Рассчитываем выборочное стандартное отклонение
sample_sd <- sd(df)

# Рассчитываем степени свободы (n - 1, где n - размер выборки)
df_degrees_of_freedom <- length(df) - 1

# Рассчитываем статистику хи-квадрат
chi_square_statistic <- ((df_degrees_of_freedom * sample_sd^2) / sigma^2)

# Задаем уровень значимости (например, 0.05)
alpha <- 0.05

# Вычисляем критическое значение хи-квадрат
critical_value <- qchisq(1 - alpha, df_degrees_of_freedom)

# Сравниваем статистику хи-квадрат с критическим значением и выводим результат
if (chi_square_statistic < critical_value) {
  cat("Принимаем гипотезу: Стандартное отклонение не превышает 10\n")
} else {
  cat("Отвергаем гипотезу: Стандартное отклонение превышает 10\n")
}




#----------------------------task 2.2

# Загрузка необходимых библиотек
library(XML)
library(moments)
library("writexl")
library("ggplot2")

# Ссылка на источник данных
url <- "http://www.pogodaiklimat.ru/history/26702.htm"

# Чтение таблиц со страницы
years <- readHTMLTable(url, which = 1)
table <- readHTMLTable(url, which = 2)

# Замена на NaN значений, которые не содержат информации (999.9)
table[table == 999.9] <- NA

# Удаление из таблицы строк со значениями NaN
table <- na.omit(table)

# Извлечение данных за июнь, июль и август
june <- as.numeric(table[,6])
july <- as.numeric(table[,7])
august <- as.numeric(table[,8])

# Создание векторов меток для группировки данных
groups <- c(rep("June", length(june)), rep("July", length(july)), rep("August", length(august)))

# Уровень значимости
alpha <- 0.05

# Множественный t-тест с коррекцией Бонферрони
t_test_result <- pairwise.t.test(c(june, july, august), g = groups, p.adjust.method = "bonferroni")

# Вывод результатов теста
print(t_test_result)

# Принятие или отвержение гипотезы
if (all(t_test_result$p.value > alpha)) {
  cat("Гипотеза о равенстве средних всех выборок не отвергается.")
} else {
  cat("Гипотеза о равенстве средних всех выборок отвергается.")
}
