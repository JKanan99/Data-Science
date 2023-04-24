#--------------------------- K MEANS ---------------------------

library(tidyverse)
#3 groups bc there are 3 different species 
km<-kmeans(iris[, 3:4], centers = 3)

km$centers
ggplot(data=iris) + geom_point(mapping = aes(x = Petal.Length, y = Petal.Width, color = Species)) + geom_point(data = as.data.frame(km$centers),mapping = aes(Petal.Length, y = Petal.Width), color = "red", size = 5) 

km$cluster

#correct is the diagonal, rest of them are errors
table(iris$Species, km$cluster)



#-------------------------- CLASSWORK ------------------------------

#Cluster the iris dataset into 3 clusters using all four Petal/Sepal columns
km<-kmeans(iris[, 1:4], centers = 3)
km$centers
ggplot(data=iris) + geom_point(mapping = aes(x = Petal.Length, y = Petal.Width, color = Species)) + geom_point(data = as.data.frame(km$centers),mapping = aes(Petal.Length, y = Petal.Width), color = "red", size = 5) 

#Compare the clusters with the true labels (Species)
km$cluster
table(iris$Species, km$cluster)

#Check if increasing random restarts increases clustering accuracy


