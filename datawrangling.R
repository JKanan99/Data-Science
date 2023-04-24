#===================== DATA WRANGLING =====================

library(tidyverse)
View(mpg)

#-------- filter() --------
filter(mpg,cty > 27)

filter(mpg,cty > 27, hwy > 30)

filter(mpg,manufacturer == "honda")

#or
filter(mpg,manufacturer == "honda" | manufacturer == "toyota")
filter(mpg,manufacturer == "honda" | manufacturer == "toyota" | manufacturer == "audi" )
#shortcut
filter(mpg,manufacturer %in% c("honda", "toyota", "audi") )

# , =  &
filter(mpg,manufacturer == "honda" , manufacturer == "toyota") 

#-------- select() --------

#columns 1-4
select(mpg,1:4)

select(mpg,manufacturer)

select(mpg, manufacturer, model, cty)

#anything other than manufacturer 
select(mpg,-manufacturer)
select(mpg,-manufacturer, -cty)

#columns that start with m 
select(mpg, starts_with("m"))

#manufacturer and model with rows where city mileage is greater than 25- executes inside to out
select(filter(mpg, cty > 25), manufacturer, model)

#-------- data pipelines --------

#expected to write it in this style 
mpg %>% filter(cty > 25) %>% select(manufacturer, model)

#--------- arrange() -----------

mpg %>% arrange(cty)
mpg %>% arrange(model)

#decreasing order
mpg %>% arrange(-cty)
#string
mpg %>% arrange(desc(model))

#----------- mutate() -----------

#mutate creates a new column
mpg %>% mutate((cty+hwy)/2) %>% View()

#rename the column
mpg %>% mutate(aveMpg = (cty+hwy)/2) %>% View()

#----------- summarise() -----------

view(airquality)
mean(airquality$Wind)

#tidyverse style - creates a data frame with one column and one row
airquality %>% summarise(mean(Wind))
airquality %>% summarise(mean(Wind), min(Wind))

#name the column
airquality %>% summarise(meanWind = mean(Wind), minWind = min(Wind))

#counts rows
airquality %>% summarise(n())

#----------- group_by() -----------

View(mpg)

mpg %>% summarize(mean(cty)) 

#subgroups by manufacturer - calculate each manufacturer's mean
mpg %>% group_by(manufacturer) %>% summarize(mean(cty)) 

#How has the cty mileage changed over the years?
mpg %>% group_by(year) %>% summarize(mean(cty)) 

#How has the cty mileage changed over the years for every manufacturer?
mpg %>% group_by(year, manufacturer) %>% summarize(mean(cty)) 

#------------- other verbs ----------------

#first 5 rows
mpg[1:5]
mpg %>% slice(1:5)

#top values
airquality %>% top_n(1, Solar.R)
airquality %>% top_n(5, Solar.R)

#join 
library(tidyverse)
band_members

band_instruments
#inner matches the inner categories, left matches left category, right matches right category 
band_members %>% inner_join(band_instruments)
band_members %>% left_join(band_instruments)
band_members %>% right_join(band_instruments)
band_members %>% full_join(band_instruments)
#return all rows from LEFT where there are matching values in RIGHT, keeping just columns from LEFT
band_members %>% semi_join(band_instruments)
#return all rows from LEFT where there are not matching values in RIGHT, keeping just columns from LEFT. 
band_members %>% anti_join(band_instruments)


#---------------------- pivoting ------------------------

relig_income %>% 
  pivot_longer(cols = -religion, names_to= "income", values_to= "freq")

table4a %>% 
  pivot_longer(c(`1999`, `2000`), names_to = "year", values_to = "cases")

table4a %>% 
  pivot_longer(cols = -country, names_to = "year", values_to = "cases")

table4a %>% 
  pivot_longer(cols = c(2,3), names_to = "year", values_to = "cases")

table4a %>% 
  pivot_longer(cols = 2:3, names_to = "year", values_to = "cases")


#---------------------------------- classwork ---------------------------------

#From the iris dataset, show only Sepal.Length and Sepal.Width columns for those 
#flowers with Petal.Length > 3.0 and Petal.Width > 1.0

iris %>% filter(Petal.Length > 3.0, Petal.Width > 1.0) %>% select(Petal.Length, Petal.Width)
iris %>% filter(Petal.Length > 3.0, Petal.Width > 1.0) %>% select(Petal.Length, Petal.Width) %>% View()

#----------------------------

# Show only manufacturer and cty columns in increasing order of cty
mpg %>% select(manufacturer,cty) %>% arrange(cty)

#----------------------------

# Show only manufacturer,cty,hwy columns in increasing order of cty
mpg %>% select(manufacturer,cty,hwy) %>% arrange(cty)

#----------------------------

# Show only manufacturer,cty,hwy columns in increasing order of cty, break ties with hwy
mpg %>% select(manufacturer,cty,hwy) %>% arrange(cty, hwy)

#----------------------------

# Show only manufacturer,cty,hwy columns in decreasing order of cty
mpg %>% select(manufacturer,cty,hwy) %>% arrange(-cty)

#----------------------------

# Show only manufacturer,cty,hwy columns for cars made by audi in decreasing order of cty
mpg %>% filter(manufacturer == "audi") %>% select(manufacturer,cty,hwy) %>%  arrange(-cty)

#----------------------------

# Show only manufacturer,cty,hwy columns for cars made by honda in decreasing order of cty and cty > 25
mpg %>% filter(manufacturer == "honda", cty > 25) %>% select(manufacturer,cty,hwy) %>% arrange(-cty)

#----------------------------

# Show only models and city of cars made by honda in decreasing order of cty and cty > 25
mpg %>% filter(manufacturer == "honda", cty>25) %>% arrange(-cty) %>% select(model, cty)

#----------------------------

#From the iris dataset, calculate the mean Sepal.Length and mean Sepal.Width 
#for those flowers with Petal.Length > 3.0
iris %>% filter( Petal.Length > 3.0) %>% summarize(mean(Sepal.Length), mean(Sepal.Width))

#----------------------------

#show the 3 most efficient(mean city mileage) car manufacturers from the mpg data set 
View(mpg)
mpg %>% group_by(manufacturer) %>% summarise(meanCity=mean(cty)) %>% top_n(3, meanCity) %>% select(manufacturer)

#----------------------------

#Calculate the different joins for these two tables.First, do them by hand. Second, confirm your results with code
band_members_4rows <- band_members %>% add_row(name="Paul", band="Wings")
band_instruments_4rows <- band_instruments %>% add_row(name= "Paul", plays = "vocals")

band_members_4rows %>% inner_join(band_instruments_4rows)
band_members_4rows %>% left_join(band_instruments_4rows)
band_members_4rows %>% right_join(band_instruments_4rows)
band_members_4rows %>% full_join(band_instruments_4rows)

band_members_4rows %>% semi_join(band_instruments_4rows)
band_members_4rows %>% anti_join(band_instruments_4rows)

#-->column names are different so it gives an error that there are no common variables 
band_members_4rows %>% inner_join(band_instruments2)
#--->so need to use by 
band_members_4rows %>% inner_join(band_instruments2, by=c(name = "artist"))

#----------------------------

#Write code to “tidy” this dataset
grades <- tibble(CWID=c(1234567, 2356902, 5005667), NAME=c("Mary", "Lee", "Elena"), 
                 CPSC120=c(3,4,NA), CPSC121=c(3.3,3,2), CPSC131=c(3,4,3.7), MATH338=c(3,NA,3.3))

grades %>% pivot_longer(c(CPSC120, CPSC121, CPSC131, MATH338), names_to = "course", values_to = "grades")
grades %>% pivot_longer(cols = 3:6 , names_to = "course", values_to = "grades")



