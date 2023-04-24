library(ggplot2)
library(tidyverse)
library(modelr)
library(readr)

bodyfat <- read_csv("~/Downloads/bodyfat.csv")
View(bodyfat)

#Plot BodyFat vs. Height (code, plot) Which is the dependent variable? Which is the independent variable?
#The independent variable is Height and the dependent variable is BodyFat.
ggplot(bodyfat) + geom_point(mapping = aes(x = Height, y=BodyFat))

#here is one obvious outlier in the Height column. Remove the corresponding row from the data and plot again. 
#(Show: code to remove the row, plot). This will be the data used for the following questions. 
#Confirm that the mean Height is now 70.31076.
bodyfat_no_outlier <- bodyfat %>% filter(Height > 60)
ggplot(data = bodyfat_no_outlier) + geom_point(mapping = aes(x = Height, y=BodyFat))

summary(bodyfat_no_outlier)

#Create a linear model of BodyFat vs. Height. (code, output of summary(model))
#What is the R2 value?
m <- lm(data = bodyfat_no_outlier, BodyFat~Height)
summary(m)

#Create a linear model of BodyFat vs. Weight. (code, output of summary(model))
w <- lm(data = bodyfat_no_outlier, BodyFat~Weight)
summary(w)
coef(w)
mycf <- coef(w)
ggplot(data=bodyfat_no_outlier) + geom_point(mapping=aes(x = Weight, y = BodyFat))+ geom_abline(slope = mycf[2] , intercept = mycf[1], color = "red" )

#Plot the histogram of residuals (plot, code). Does this show an approximately normal distribution?
m <- lm(data = bodyfat_no_outlier, BodyFat~Weight)
residuals(j)
bodyfat2 <- bodyfat_no_outlier %>% add_residuals(j)
ggplot(data=bodyfat2) + geom_histogram(mapping = aes(x=resid))

#From the model, predict the BodyFat for two persons: Person A weighs 175 lbs, Person B weighs 
#250 lbs. Include the 99% confidence intervals for the predictions. 
#In which prediction (for Person A or B), are you more confident? Why?

m <- lm(data = bodyfat_no_outlier, BodyFat~Weight)
predx <-data.frame(Weight=c(175, 250))
predict(m, predx)

predict(m, predx, interval = "confidence", level = 0.99)

#Create a linear model of BodyFat vs. Weight and Height. (code, output of summary(model))
#What is the R2 value?
m2 <- lm(data=bodyfat_no_outlier, BodyFat~Weight + Height)
summary(m2)

#From the model, predict the BodyFat for two persons: Person A weighs 175 lbs, Person B weighs 250 lbs. Both persons have height=70”. Include the 99% confidence intervals for the predictions. 
#In which prediction (for Person A or B), are you more confident? Why?
m2 <- lm(data=bodyfat_no_outlier, BodyFat~Weight + Height)
predx2 <-data.frame(Weight=c(175, 250), Height = c(70,70))
predict(m2, predx2)

predict(m2, predx2, interval = "confidence", level = 0.99)

#Add a new transformed variable BMI = Weight/Height2 to the dataset. 
#Create a linear model of BodyFat vs. BMI. 
#Give R code, output of summary(model)
mydata5 <- bodyfat_no_outlier %>% mutate(BMI = Weight/Height^2)
newBMI <- lm(data = bodyfat, formula = BodyFat~BMI)
summary(newBMI)

#Plot BodyFat vs. BMI and overlay the best fit model as a straight line. (code, plot)
ggplot(data = mydata) + geom_point(mapping = aes(x = BMI, y = BodyFat)) 
  + geom_abline(intercept = newBMI$coefficients[1], slope = newBMI$coefficients[2], color = "blue")

#From the model, predict the BodyFat for two persons: Person A weighs 175 lbs, Person B weighs 250 lbs. Both persons have height=70”. Include the 99% confidence intervals for the predictions. 
mydata2 <- data.frame(Weight=c(175,250), Height=c(99,99)) %>% mutate(BMI=Weight/Height^2)
mydata2
predict(newBMI, mydata2, interval = "confidence", level=0.99)

#Add a new categorical variable (factor) AgeGroup to the dataset. AgeGroup should have three values: “Young” for Age<40, “Middle” for Age between 40 and 60, and “Older” for Age>60. 
#Show R code that adds the AgeGroup variable. 

mydata6 <- mydata5 %>% mutate(AgeGroup = cut(Age, breaks = c(-Inf,40,60,Inf), labels = c("Young", "Middle", "Older")))
m6 <- lm(data=mydata6, BodyFat ~ BMI + AgeGroup)
summary(m6)

bodyfat_w_predictions <- mydata6 %>% add_predictions(m6)
bodyfat_w_predictions %>% view
ggplot(data=bodyfat_w_predictions) + geom_point(mapping = aes(y=BodyFat, x=BMI)) + geom_line(mapping = aes(x=BMI, y=pred, color=AgeGroup))





