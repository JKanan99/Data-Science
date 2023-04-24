
#---------------------- LINEAR REGRESSION -----------------------------
library(tidyverse)

#draws a line 
?geom_abline(slope = 2, intercept = 10)
ggplot() + geom_abline(slope = 2, intercept = 10)
ggplot() + geom_abline(slope = 2, intercept = 1)
ggplot() + geom_abline(slope = 2, intercept = 0)


#How does Petal.Length change with  Petal.Width? Draw a scatterplot, Draw any straight line that fits the data well
# Length is dependent 
library(ggplot2)
view(iris)
ggplot(data=iris) + geom_point(mapping=aes(x = Petal.Width, y = Petal.Length)) + geom_abline(slope = 2.5, intercept = 0.9)

#lm finds the optimal line 
lm(data = iris, Petal.Length~Petal.Width) 
ggplot(data=iris) + geom_point(mapping=aes(x = Petal.Width, y = Petal.Length)) + geom_abline(slope = 2.230, intercept = 1.084)

#another way to do it
m <- lm(data = iris, Petal.Length~Petal.Width) 
coef(m)
mycf <- coef(m)
mycf[1]  
ggplot(data=iris) + geom_point(mapping=aes(x = Petal.Width, y = Petal.Length)) + geom_abline(slope = mycf[2] , intercept = mycf[1] )

#residual analysis visualized using a histogram - outlier if residual > 2
m <- lm(data = iris, Petal.Length~Petal.Width)
library(modelr)
iris %>% add_residuals(m) %>% view()
iris <- iris %>% add_residuals(m)
ggplot(data=iris) + geom_histogram(mapping = aes(x=resid))

class(m)

#----- residual analysis visualized using a plot -----

rstandard(m)
iris %>% mutate(rstd=rstandard(m)) %>% view()
#|standard value| > 2
iris %>% mutate(rstd=rstandard(m)) %>% filter(abs(rstd) > 2) %>% view()
#without absolute function 
iris %>% mutate(rstd=rstandard(m)) %>% filter(rstd > 2 | rstd < -2) %>% view()

irisOutliers <- iris %>% mutate(rstd=rstandard(m)) %>% filter(rstd > 2 | rstd < -2)
view(irisOutliers)
ggplot(data=iris) + geom_point(mapping=aes(x = Petal.Width, y = Petal.Length))+geom_point(data = irisOutliers, mapping=aes(x = Petal.Width, y = Petal.Length), color = "red")

#with best fit line
coef(m)
mycf <- coef(m)
ggplot(data=iris) + geom_point(mapping=aes(x = Petal.Width, y = Petal.Length))+geom_point(data = irisOutliers, mapping=aes(x = Petal.Width, y = Petal.Length), color = "red") +geom_abline(slope = mycf[2] , intercept = mycf[1] )

#----- making predictions -----
# creates a dataframe with 3 columns, 3 rows
predx <-data.frame(Petal.Width=c(0.5, 1.0, 2.0))
predict(m, predx)
m
#prediction and how confident with 95% confidence (lower and upper bounds)
# prediction is basically asking to predict one- error in a single prediction
predict(m, predx, interval = "prediction", level = 0.95)

#confidence has tighter bounds- basically asking for the average of all - error in mean prediction
predict(m, predx, interval = "confidence", level = 0.99)
predict(m, predx, interval = "confidence", level = 0.95)

#multiple linear regression, 
m2 <- lm(data=iris, Petal.Length~Petal.Width+Sepal.Width)
m2 

#check R^2 to see what is more accurate - higher the number, the more accurate
#the more columns, the more accurate
#the adjusted R^2 - punishing you for being more complex 

#runif gives random numbers 
iris %>% mutate (x3 = runif(150))
m3 <- lm(data = iris, petal.Length~Petal.Width+Sepal.Width)

#--- categoreal variables ---
#limitations- cant find optimial exponent - has to be hard coded 
#the data looks curved already so having the transformation curved its more accurate

m <- lm(data=iris, Petal.Length~Petal.Width + Species)
summary(m)

iris <- iris %>% add_predictions(m) 
iris
ggplot(data=iris) + geom_point(mapping = aes(x=Petal.Width, y=Petal.Length, color = Species)) + geom_line(mapping=aes(x=Petal.Width, y=pred, color=Species))

coef(m)
m

#--- non linear transformaion --- 

#adds new column - pw2 
iris <- iris %>% mutate(PW2= Petal.Width^2)

lm(data=iris, Petal.Length~PW2)
iris.PW2.model <- lm(data=iris, Petal.Length~PW2)
iris %>% add_predictions(iris.PW2.model) %>% view()
iris <- iris %>% add_predictions(iris.PW2.model) 

ggplot(data=iris) + 
  geom_point(mapping = aes(x=Petal.Width, y=Petal.Length)) + 
  geom_line(mapping = aes(x=Petal.Width, y=pred), color="red")

#-------------------------- classwork ------------------------------------

#Consider the “Auto MPG” dataset which “concerns city-cycle fuel consumption in miles per gallon, 
#to be predicted in terms of 3 multivalued discrete and 5 continuous attributes.” 
#The goal is to model mpg given engine displacement. 

#Plot mpg vs. displacement (code, plot)
#Overlay best fit line over the dataset (code, plot)

ggplot(data=autompg) + geom_point(mapping=aes(x = displacement, y = mpg))
lm(data = autompg, mpg~displacement) 
m <- lm(data = autompg, mpg~displacement) 
summary(m)
ggplot(data=autompg) + geom_point(mapping=aes(x = displacement, y = mpg)) + geom_abline(slope = mycf[2] , intercept = mycf[1] )


#Write down the linear model equation relating the three variables from
#Petal.Width ~ Petal.Length + Sepal.Length

#Petal.Width = 2.258 + 2.156 * Petal.Length + (-0.355) * Sepal.Length
  