# reading data sets 
library(readr)
owid_covid_data <- read_csv("Desktop/owid-covid-data.csv")
View(owid_covid_data)

library(readr)
demographics <- read_csv("Downloads/demographics.csv")
View(demographics)

#loading libraries 
library(ggplot2)
library(tidyverse)
library(modelr)
library(Metrics)

#----------------------------- PART 1 -----------------------------
#Keep only country-level data by removing all rows where the country_code is not exactly 3 letters
owid_covid_data<-owid_covid_data %>% filter(nchar(iso_code) == 3)

#Remove countries whose total population is less than 1 million.
owid_covid_data <- owid_covid_data %>% filter(nchar(iso_code) == 3) %>% filter(population > 1000000)

#Remove columns that should not be used for linear modeling. Remove all “deaths” 
#columns other than new_deaths_smoothed and all “excess mortality” columns.
owid_covid_data <- owid_covid_data %>% filter(nchar(iso_code) == 3) %>% filter(population > 1000000) %>% select(-total_deaths, -total_deaths_per_million, -new_deaths, 
                                                                                             -new_deaths_per_million, -new_deaths_smoothed_per_million,
                                                                                             -excess_mortality_cumulative_absolute,-excess_mortality_cumulative, 
                                                                                             -excess_mortality, -excess_mortality_cumulative_per_million) %>% mutate(data = as.Date(date))

#Add a new column new_deaths_smoothed_2wk that has the same values as new_deaths_smoothed but two weeks ahead
#take a copy of the data, subtract 14 from the date column, and rename the deaths column. do a join with the orig table 
#note: our date column saved as a char data type not a date data type so need to use as.Date()
owid_covid_data_COPY <- owid_covid_data 

owid_covid_data_COPY <- owid_covid_data_COPY%>% mutate(date = as.Date(date) - 14) %>% rename(new_deaths_smoothed_2wk = new_deaths_smoothed) 

owid_covid_data_COPY <- owid_covid_data_COPY %>% select(iso_code, date, new_deaths_smoothed_2wk)

new_owid_data <- owid_covid_data %>% inner_join(owid_covid_data_COPY)

#tidy tables, as needed. (Hint: only the demographics data is not tidy.)
#pivot woder - take the names from series ccode and the values from YR2015
demographics2 <- demographics %>% pivot_wider(names_from = 'Series Code', values_from = YR2015) %>% view()

#Merge the tables (Hint: join using the 3-letter ISO code = country code)
new_owid_data <- new_owid_data %>% inner_join(demographics2, by=c("iso_code" = "Country Code"))


#--------------------------- PART 2 --------------------------------
#Generate some (at least 3) transformed variables. E.g., these could combine variables 
#(e.g., cardiovasc_deaths= cardiovasc_death_rate*population).
new_owid_data <- new_owid_data %>% mutate(cardiovasc_deaths = cardiovasc_death_rate*population)

new_owid_data <- new_owid_data %>% mutate(percent_vaccinated = people_vaccinated/population)

new_owid_data <- new_owid_data %>% mutate(total_cases_squared = total_cases^2)

#Split your dataset into train and test subsets: only data from 2022 should be used for building/training the 
#linear models in lm(). (Data from 2023 will be used for evaluation as described later). Note: each day is one data point.
#train using only data from 2022
train_subset <- new_owid_data %>% filter(date >= as.Date("2022-01-01"), date <= as.Date("2022-12-31"))

#test using data for 2023 
test_subset <- new_owid_data %>% filter(date >= as.Date("2023-01-01"), date <= as.Date("2023-12-31"))

#Run linear regression with at least 5 different combinations of predictor variables. Hint: each model will look like:
#new_deaths_smoothed_2wk~new_cases_smoothed+gdp_per_capita+diabetes_prevalence+icu_patients+SP.URB.TOTL
#-> calculate the LM with the train subset and the predictor variables then predict 
LM1 <- lm(data = train_subset, new_deaths_smoothed_2wk~new_cases_smoothed+gdp_per_capita+diabetes_prevalence+icu_patients+SP.URB.TOTL)
P1 <- predict(LM1, test_subset)

#LM2 gave us the best predictions
LM2 <- lm(data = train_subset, new_deaths_smoothed_2wk~new_cases+aged_70_older+aged_65_older+median_age)
P2 <- predict(LM2, test_subset)

LM3 <- lm(data = train_subset, new_deaths_smoothed_2wk~population_density+total_cases+extreme_poverty+cardiovasc_death_rate+diabetes_prevalence+female_smokers+male_smokers)
P3 <- predict(LM3, test_subset)

LM4 <- lm(data = train_subset, new_deaths_smoothed_2wk~total_cases+total_vaccinations+people_fully_vaccinated+people_vaccinated+total_boosters)
P4 <- predict(LM4, test_subset)

LM5 <- lm(data = train_subset, new_deaths_smoothed_2wk~new_cases_smoothed+hosp_patients+icu_patients+weekly_icu_admissions+weekly_hosp_admissions)
P5 <- predict(LM5, test_subset)

#----------- PART 3 -----------
#For each of your models, calculate the Root Mean Squared Error (RMSE) over all days in 2023 and all countries. Hint: use rmse() in library(modelr).
#need to remove all of the NA's so that we can calculate the RMSE 
test_subset <- na.omit(test_subset$new_deaths_smoothed_2wk)
P1 <- na.omit(P1)
P2 <- na.omit(P2)
P3 <- na.omit(P3)
P4 <- na.omit(P4)
P5 <- na.omit(P5)

rmse(actual=test_subset, predicted = P1)
rmse(actual=test_subset, predicted = P2)
rmse(actual=test_subset, predicted = P3)
rmse(actual=test_subset, predicted = P4)
rmse(actual=test_subset, predicted = P5)

#For only your best model, calculate the Root Mean Squared Error for every country (over all days in 2023). Hint: use group_by() and summarise(rmse(..)). 
#cur_data() gives the data in each group.
test_subset %>% group_by(iso_code) %>%
  summarise(rmse = rmse(actual = new_deaths_smoothed_2wk, predicted = P5))
  
#----------- Graphs -----------
#plot of most recently available new deaths per day two weeks ahead (new_deaths_smoothed_2wk) and the corresponding new cases per 
#day (new_cases_smoothed) for every country (i.e., one point per country)
smoothed2wk <- new_owid_data %>% top_n(1,date) %>% group_by(iso_code)
ggplot(data = smoothed2wk) + geom_point(mapping= aes(x=new_cases_smoothed, y= new_deaths_smoothed_2wk)) + labs(y="new_cases_smoothed", x="new_deaths_smoothed, 2 weeks away")


#a scatterplot of only the most recent new deaths (new_deaths_smoothed) and the urban population (SP.URB.POPL) 
#for every country (i.e., one point per country)
smoothed <- new_owid_data %>% top_n(1,date) %>% group_by(iso_code)
ggplot(data = smoothed) + geom_point(mapping= aes(x=SP.URB.TOTL, y= new_deaths_smoothed)) + labs(y="Urban Population (SP.URB.TOTL)", x="new_deaths_smoothed")


