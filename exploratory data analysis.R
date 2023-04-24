#=============== Exploratory Analysis ==================
#summary of statistics 
summary(iris)

mydata <- c(10,20,30,NA,50)
mydata

#check if each value is NA 
is.na(mydata)

View(airquality)

#check if there are any N/A in Solar.R
is.na(airquality$Solar.R)

#how many N/A's- works bc true is 1 and false is 0
sum(is.na(airquality$Solar.R))

#mean of solar - there are missing data so it won't find the mean
#philosophy- maybe you have the wrong data so the default is set to FASE
mean(airquality$Solar.R)

#ignore NA's and calculate mean of the data 
mean(airquality$Solar.R, na.rm = TRUE)

#--------histogram for airquality-------
library(ggplot2)
ggplot(data=airquality)+geom_histogram(mapping = aes(x=Ozone))

#can choose own bindwidth
ggplot(data=airquality)+geom_histogram(mapping = aes(x=Ozone), binwidth = 10)

#------box plots--------
x <- c(36,42,100,28,17,12,9,4,1)
sort(x)
median(x)
quantile(x)

IQR(x)
#upper outlier (choose closest value, in this case 42)
36 + 1.5*IQR(x)
#lower outlier (choose closest value, in this case 1) - 100 is the outlier 
9 - 1.5*IQR(x)

#has to be in a data frame 
data.frame(col1=x)
mydata = data.frame(col1=x)

ggplot(data = mydata) + geom_boxplot(mapping = aes(y=col1))

#------- 2 variables at a time ----------
#one numerical and one categorical variables- box plot 
library(ggplot2)
ggplot(data=iris) + geom_boxplot(mapping=aes(y=Sepal.Width, x=Species))

#2 categorial variables- bar graph 
str(mpg)

ggplot(data=mpg)+ geom_bar(mapping = aes(x=class))
ggplot(data=mpg)+ geom_bar(mapping = aes(x=class, fill=drv))

#same as above but not stacked
ggplot(data=mpg)+ geom_bar(mapping = aes(x=class, fill=drv), position = "dodge")


#--------------------------classwork-----------------------------
# how many rows, columns, and variable names
summary(airquality)

nrow(airquality)
ncol(airquality)

colnames(airquality)
names(airquality)
str(airquality)

#----------------------------

#NA's in column Ozone
sum(is.na(airquality))

#----------------------------

#How many NA's in column ozone
sum(is.na(airquality$Ozone))

#----------------------------

#which rows have NA's
which(is.na(airquality$Ozone))

#----------------------------

#Mean of ozone variable (contains NA's)
mean(airquality$Ozone, na.rm = TRUE)

#----------------------------

#Consider the data iris, Create a histogram of Petal.Length 
ggplot(data=iris)+geom_histogram(mapping = aes(x=Petal.Length))

#----------------------------

#Try different values of binwidth
ggplot(data=iris)+geom_histogram(mapping = aes(x=Petal.Length), binwidth = 0.5)
ggplot(data=iris)+geom_histogram(mapping = aes(x=Petal.Length), binwidth = 0.25)
ggplot(data=iris)+geom_histogram(mapping = aes(x=Petal.Length), binwidth = 0.1)
ggplot(data=iris)+geom_histogram(mapping = aes(x=Petal.Length), binwidth = 0.05)

#----------------------------

#Explore the airquality dataset: 	–	How many variables, size of the data, …
colnames(airquality)
ncol(airquality)
nrow(airquality)
ls(airquality)
str(airquality)

#----------------------------

#Summary statistics
summary(airquality)

#----------------------------

#Is there missing data? Which variables are most affected? - in summary
is.na(airquality)
which(is.na(airquality))

#----------------------------

#Visualize each variable individually
ggplot(data = airquality) + geom_boxplot(mapping = aes(y=Ozone))
ggplot(data = airquality) + geom_boxplot(mapping = aes(y=Solar.R))
ggplot(data = airquality) + geom_boxplot(mapping = aes(y=Wind))
ggplot(data = airquality) + geom_boxplot(mapping = aes(y=Temp))
ggplot(data = airquality) + geom_boxplot(mapping = aes(y=Month))
ggplot(data = airquality) + geom_boxplot(mapping = aes(y=Day))

#----------------------------

#which convert into factor - converting data types - coersion - explicit 
as.factor(airquality$Month)
airquality$Month <- as.factor(airquality$Month)
str(airquality)

#----------------------------

#big data - needs more than one computer to load the data - break up into multiple machines

#----------------------------

#in the airquality dataset, convert these variables into factors; month, day 
airquality$Month <- as.factor(airquality$Month)
airquality$Day <- as.factor(airquality$Day)
str(airquality)

#----------------------------
#visualize any 5 pairs of variables of the air quality dataset; choose the appropriate plot for each pair 
#month and day - bar graph 
ggplot(data=airquality)+ geom_bar(mapping = aes(x=Month, fill=Day))

#Temp and month - box plot 
ggplot(data=airquality) + geom_boxplot(mapping=aes(y=Temp, x=Month))

#ozone and temp - scatter plot 
ggplot(data=airquality) + geom_point(mapping=aes(x = Temp, y = Ozone))

#day and solar - box plot
ggplot(data=airquality) + geom_boxplot(mapping=aes(y=Solar.R, x=Month))

#wind and ozone - scatter plot 
ggplot(data=airquality) + geom_point(mapping=aes(x = Wind, y = Ozone))

#-------------------------------------------------------------------------------


