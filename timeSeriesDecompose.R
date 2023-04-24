#--------------- time series analysis-----------------
#temp ov every month starting at 1920
nottem
decompose(nottem)

plot(nottem)
plot(decompose(nottem))
class(nottem) #time series vs vector - both a set of num but ts has frequency 
              #                      - frequency num that tells after what num of instances does a pattern repeat
#why is the random data so big? -the scale of the y-axis

JohnsonJohnson
plot(decompose(JohnsonJohnson))

#if don;t have a time series 
mydata <- as.vector(nottem)
mydata.ts <- ts(mydata, frequency = 12) #12 bc its monthly data, find when data repeats by looking at it

#auto correlaton function- look for the second highest peak and look for the corresponding shift 
acf(mydata.ts)

plot(decompose(mydata.ts))

#---------------------------- CLASSWORK ----------------------------

#Read the text CSV file at https://raw.githubusercontent.com/jbrownlee/Datasets/master/daily-min-temperatures.csv 
#which describes the minimum daily temperatures over 10 years (1981-1990) in Melbourne, Australia. 
#The goal is to convert this to a R ts object with the appropriate frequency and then decompose it into trend, 
#seasonal, and random components. Write R code to do the following:

#Read the file into a R object
library(readr)
daily_min_temperatures <- read_csv("Desktop/daily-min-temperatures.csv")
View(daily_min_temperatures)

#Find the frequency of the seasonal component (Hint: use acf() with a large lag.max parameter value)
acf(daily_min_temperatures$Temp, lag.max = 1000)

#Convert to a ts object
daily_min_temperatures.ts <- ts(daily_min_temperatures$Temp, frequency = 390)

#Decompose the ts object
plot(decompose(daily_min_temperatures.ts))





