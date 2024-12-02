#install.packages("XML",dependenciec=TRUE)
library(XML)
url <-"http://www.pogodaiklimat.ru/history/26702.htm"
table <- readHTMLTable(url, which = 2)
names(table)[13] <- "год"
for (i in colnames(table)){
  table[[i]]<-as.numeric(table[[i]])
}

for (i in 1:13){
  print(min(table[i]))
}
table[176, "окт"]<-0
table[176, "ноя"]<-0
table[176, "дек"]<-0
table[176, "год"]<-0
for (i in 1:13){
  print(max(table[i]))
}
for (i in colnames(table)){
  print(median(table[[i]]))
}
for (i in colnames(table)){
  print(mean(table[[i]]))
}
for (i in colnames(table)){
  print(sd(table[[i]]))
}

#install.packages("e1071",dependenciec=TRUE)
library(e1071)
for (i in colnames(table)){
  print(skewness(table[[i]]))
}

n<-nrow(table)
for (i in colnames(table)){
  print(sd(table[[i]])/sqrt(n))
}

for (i in colnames(table)){
  print(quantile(table[[i]],0.25))
}
for (i in colnames(table)){
  print(quantile(table[[i]],0.75))
}
for (i in colnames(table)){
  print(IQR(table[[i]]))
}
#par(mar=c(1,1,1,1))
boxplot(table$янв)
boxplot(table$фев)
boxplot(table$мар)
boxplot(table$апр)
boxplot(table$май)
boxplot(table$июн)
boxplot(table$июл)
boxplot(table$авг)
boxplot(table$сен)
boxplot(table$окт)
boxplot(table$ноя)
boxplot(table$дек)

for (i in colnames(table)){
  print(sd(table[[i]])/mean(table[[i]])*100)
}

boxplot.stats(table$янв)$out
print(which(table$янв==-13.2)+1848-1)
print(which(table$янв==-12.9)+1848-1)
print(which(table$янв==-13.7)+1848-1)
boxplot.stats(table$фев)$out
print(which(table$фев==-11.4)+1848-1)
print(which(table$фев==-10.6)+1848-1)
print(which(table$фев==-12.4)+1848-1)
print(which(table$фев==-11.5)+1848-1)
print(which(table$фев==-12.5)+1848-1)
print(which(table$фев==-10.5)+1848-1)
print(which(table$фев==-11.4)+1848-1)
boxplot.stats(table$апр)$out
print(which(table$апр==12.2)+1848-1)
boxplot.stats(table$май)$out
print(which(table$май==6.1)+1848-1)
print(which(table$май==7.0)+1848-1)
print(which(table$май==6.8)+1848-1)
print(which(table$май==16.4)+1848-1)
boxplot.stats(table$июн)$out
print(which(table$июн==11.2)+1848-1)
print(which(table$июн==20.5)+1848-1)
boxplot.stats(table$июл)$out
print(which(table$июл==21.3)+1848-1)
print(which(table$июл==21.2)+1848-1)
boxplot.stats(table$авг)$out
print(which(table$авг==21.2)+1848-1)
boxplot.stats(table$сен)$out
print(which(table$сен==18.6)+1848-1)
print(which(table$сен==17.0)+1848-1)
boxplot.stats(table$окт)$out
boxplot.stats(table$ноя)$out
print(which(table$ноя==-2.6)+1848-1)
print(which(table$ноя==-3.2)+1848-1)
print(which(table$ноя==-3.3)+1848-1)
print(which(table$ноя==-2.7)+1848-1)
print(which(table$ноя==-2.9)+1848-1)
boxplot.stats(table$дек)$out
print(which(table$дек==-9.4)+1848-1)
print(which(table$дек==-8.8)+1848-1)

#5
january <- rnorm(n,mean(table$янв),sd(table$янв))
hist(january)
february <- rnorm(n,mean(table$фев),sd(table$фев))
hist(february)
march <- rnorm(n,mean(table$мар),sd(table$мар))
hist(march)
april <- rnorm(n,mean(table$апр),sd(table$апр))
hist(april)
may <- rnorm(n,mean(table$май),sd(table$май))
hist(may)
june <- rnorm(n,mean(table$июн),sd(table$июн))
hist(june)
july <- rnorm(n,mean(table$июл),sd(table$июл))
hist(july)
august <- rnorm(n,mean(table$авг),sd(table$авг))
hist(august)
september <- rnorm(n,mean(table$сен),sd(table$сен))
hist(september)
october <- rnorm(n,mean(table$окт),sd(table$окт))
hist(october)
november <- rnorm(n,mean(table$ноя),sd(table$ноя))
hist(november)
december <- rnorm(n,mean(table$дек),sd(table$дек))
hist(december)




for (i in colnames(table)){
  print(i)
  print(shapiro.test(table[[i]]))
}

y = rnorm(50, 50, 20)
qqplot(table$янв, y, main = "Q-Q Plot") 
qqplot(table$фев, y, main = "Q-Q Plot")
qqplot(table$мар, y, main = "Q-Q Plot")
qqplot(table$апр, y, main = "Q-Q Plot")
qqplot(table$май, y, main = "Q-Q Plot")
qqplot(table$июн, y, main = "Q-Q Plot")
qqplot(table$июл, y, main = "Q-Q Plot")
qqplot(table$авг, y, main = "Q-Q Plot")
qqplot(table$сен, y, main = "Q-Q Plot")
qqplot(table$окт, y, main = "Q-Q Plot")
qqplot(table$ноя, y, main = "Q-Q Plot")
qqplot(table$дек, y, main = "Q-Q Plot")

find_mode <- function (x) {
  u <- unique(x)
  tab <- tabulate(match(x, u))
  u[tab == max(tab)]
}
for (i in colnames(table)){
  print(i)
  print(find_mode(table[[i]]))
}