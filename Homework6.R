library(readr)
mydata <- read_csv("Downloads/breast-cancer-wisconsin.csv")
View(breast_cancer_wisconsin)

nrow(mydata)
length(which(mydata$Class == "M"))

km<-kmeans(mydata[, c(2,3,7)], centers = 2)
km$centers
km$cluster
table(mydata$Class, km$cluster)
