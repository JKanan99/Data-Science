
library(readr)
owid_covid_data <- read_csv("Desktop/owid-covid-data.csv")
View(owid_covid_data)

library(readr)
demographics <- read_csv("Downloads/demographics.csv")
View(demographics)

library(ggplot2)
library(tidyverse)
library(modelr)

#----------- PART 1 -----------

#Keep only country-level data by removing all rows where the country_code is not exactly 3 letters
owid_covid_data %>% filter(nchar(iso_code) == 3)

#Remove countries whose total population is less than 1 million.
owid_covid_data %>% filter(nchar(iso_code) == 3) %>% filter(population > 1000000)

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

class(owid_covid_data_COPY$date)

owid_covid_data_COPY%>% mutate(date = as.Date(date) - 14) %>% rename(new_deaths_smoothed_2wk = new_deaths_smoothed)

new_owid_data <- owid_covid_data %>% inner_join(owid_covid_data_COPY)

#tidy tables, as needed. (Hint: only the demographics data is not tidy.)
demographics2 <- demographics %>% pivot_wider(names_from = 'Series Code', values_from = YR2015) %>% view()

#Merge the tables (Hint: join using the 3-letter ISO code = country code)

new_owid_data %>% inner_join(newdemographics, by=c(iso_code = "Country Code"))


#----------- PART 2 -----------

#Make a list of all predictor variables that are available. The challenge is to identify which combination 
#of these predictors will give the best predictive model. Note: all “deaths” columns and all “excess mortality” 
#columns should not be used as independent variables as this is essentially what you are predicting.


#Generate some (at least 3) transformed variables. E.g., these could combine variables 
#(e.g., cardiovasc_deaths= cardiovasc_death_rate*population).


#Split your dataset into train and test subsets: only data from 2022 should be used for building/training the 
#linear models in lm(). (Data from 2023 will be used for evaluation as described later). Note: each day is one data point.


#Run linear regression with at least 5 different combinations of predictor variables. Hint: each model will look like:
#new_deaths_smoothed_2wk~new_cases_smoothed+gdp_per_capita+diabetes_prevalence+icu_patients+SP.URB.TOTL


#----------- PART 3 -----------


#For each of your models, calculate the Root Mean Squared Error (RMSE) over all days in 2023 and all countries. Hint: use rmse() in library(modelr).


#For only your best model, calculate the Root Mean Squared Error for every country (over all days in 2023). Hint: use group_by() and summarise(rmse(..)). 
#cur_data() gives the data in each group.







