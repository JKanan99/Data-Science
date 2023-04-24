#----------------- K - NEAREST NEIGHBORS ----------------------
install.packages("class")
library(class)
library(tidyverse)

View(iris)

#---SUPERVISED LEARNING SLIDE (SETTING UP THE TABLE)---
#random sample so you get all of the species
#three random num
sample(1:10, 3)

#choose 100 for training instances
trainindex <- sample(1:150, 100)
trainfeatures <- iris[trainindex, 1:4]
#want to predict 5th column
trainlabels <- iris[trainindex, 5]

#test piece, don't want overlap?? what we test on is different than what we train on 
testindex <- setdiff(1:150, trainindex)
setdiff(1:10, 1:5) 
testfeatures <- iris[testindex, 1:4]
testlabels <- iris[testindex, 5]

#--traning w/ 50 predictions
knn(train = trainfeatures, cl=trainlabels, test = testfeatures, k=1)

#see how close predictions are 
predicted <- knn(train = trainfeatures, cl=trainlabels, test = testfeatures, k=1)
data.frame(testlabels=testlabels, predicted = predicted) %>% View()

#direct comparison- correct - sum of diagonals-  rest are errors 
#column going down are real, the ones across at top are predicted 
table(testlabels, predicted)

error <- 2
errorrate <- 2/50

#seeing if these predictions are better/worse
#Note: if there are only 2 classes, choosing k to be odd (1,3,5,…) avoids ties
#training instances in iris is 100 sqrt is of 100 is the best value for K
# k - the num of neighbors comparing 
predicted2 <- knn(train = trainfeatures, cl=trainlabels, test = testfeatures, k=2)
table(testlabels, predicted2)

predicted3 <- knn(train = trainfeatures, cl=trainlabels, test = testfeatures, k=3)
table(testlabels, predicted3)


#-------------- CLASSWORK ------------------
#sqrt(sum of (x-y)^2) - euclidean distance

sqrt((5-7)^2 + (0-3)^2 + (-1-5)^2)
#or
sqrt(sum(( c(5,0,-1) - c(7,3,5) )^2))

#---------------------------------------

#Using 1-NN, what is the predicted output for name “Chris”?
#chris = (5,0,1)

#chris and laura 
sqrt(sum(( c(5,0,1) - c(5,1,3) )^2)) 
#chris and carlos
sqrt(sum(( c(5,0,1) - c(6,0,2) )^2))
#chris and jose 
sqrt(sum(( c(5,0,1) - c(4,0,2) )^2))
#chris and maria 
sqrt(sum(( c(5,0,1) - c(5,1,3) )^2))
#chris and belen
sqrt(sum(( c(5,0,1) - c(5,0,2) )^2))
#closest neighbor of chris is belen(F), so chris is is F

#---------------------------------------

#Using 3-NN, what is the predicted output for name “Chris”?
#chris = (5,0,1)

#chris and laura 
sqrt(sum(( c(5,0,1) - c(5,1,3) )^2))
#chris and carlos
sqrt(sum(( c(5,0,1) - c(6,0,2) )^2))
#chris and jose 
sqrt(sum(( c(5,0,1) - c(4,0,2) )^2))
#chris and maria 
sqrt(sum(( c(5,0,1) - c(5,1,3) )^2))
#chris and belen
sqrt(sum(( c(5,0,1) - c(5,0,2) )^2))
#closest 3 neighbors of chris are carlos (M), jose(M), and belen(F) - majority are M so chris is M

#---------------------------------------
library(readr)
pima_indians_diabetes_resampled <- read_csv("Downloads/pima-indians-diabetes-resampled.csv")
View(pima_indians_diabetes_resampled)

#Which is the “class” variable? Which is/are the “feature” variables?
#class - has diabetes. features-everything else 

#Split the dataset into train and test datasets with the first 500 rows for training, and the remaining rows for test
#Do NOT randomly sample the data

trainindex <- 1:500
trainfeatures <- pima_indians_diabetes_resampled[trainindex, c("Preg","Pedigree")]
#want to predict HasDiabetes th column
trainlabels <- pima_indians_diabetes_resampled[trainindex, "HasDiabetes"]

trainlabels$HasDiabetes

#test piece, don't want overlap?? what we test on is different than what we train on 
testindex <- setdiff(1:nrow(pima_indians_diabetes_resampled), trainindex)
testfeatures <- pima_indians_diabetes_resampled[testindex, c("Preg","Pedigree")]
#column want to predict 
testlabels <- pima_indians_diabetes_resampled[testindex, 9]


#Train and test a 1-nearest neighbor (1-NN) classifier with this dataset
#What is the error rate (number of misclassifications)?
#k is a hyper parameter- change the nature of the algo, rest are parameters

knn(train = trainfeatures, cl=trainlabels, test = testfeatures, k=1)

predicted <- knn(train = trainfeatures, cl=trainlabels$HasDiabetes, test = testfeatures, k=1)
data.frame(testlabels=testlabels, predicted = predicted) %>% View()

table <- table(testlabels$HasDiabetes, predicted)

#gives the num of errors
sum(table) - sum(diag(table))






