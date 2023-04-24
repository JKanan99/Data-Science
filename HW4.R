library(tidyverse)
View(flights)

#Show the average arrival delay for all flights.
mean(flights$arr_delay)

#Show the average arrival delay for every departure city.
flights %>% summarise(mean(arr_delay, na.rm = TRUE))
flights %>% group_by(origin) %>% summarise(mean(arr_delay, na.rm = TRUE)) 

#Show the average arrival delay for every departure-arrival city pair.
flights %>% group_by(origin, dest) %>% summarise(mean(arr_delay, na.rm = TRUE))

#Draw the output table from the following operations (you should be able to calculate the output by hand though you may use R to check your answers).
#bands %>% inner_join(instruments)
bands %>% inner_join(instruments)
bands <- tibble(name=c("Mick", "John", "Paul", "Paul"), 
                lastname=c("Jagger","Lennon", "McCartney", "McCartney"), 
                band=c("Stones", "Beatles", "Beatles", "Wings"),
                year=c(1962,1960,1960,1971))

instruments <- tibble(artist=c("John", "Paul", "Keith", "Paul"), 
                      artistname=c("Lennon","McCartney", "Richards", "McCartney"), 
                      plays=c("guitar", "bass", "guitar", "bass"),
                      model=c("Gibson", "Hofner", "Fender", "Hofner"))

#Give the code to convert billboard to a tidy table and store it in a tibble called billboard_tidy.
View(billboard)
billboard_tidy <- billboard %>% pivot_longer(cols = starts_with("wk"), names_to = "week", values_to = "rank", values_drop_na = TRUE)

#Show for each track, how many weeks it spent on the chart                   
billboard_tidy %>% group_by(track) %>% summarise(n())

#Show for each track, how many weeks it spent on the chart
billboard_tidy %>% group_by(track) %>% summarise(n())

#List tracks in decreasing order of number of weeks spent on the chart
billboard_tidy %>% arrange(desc(week)) %>% select(track)

#Show for each track, its top rank
billboard_tidy %>% top_n(1, rank) %>% select(track,rank)

#List tracks in increasing order of its top rank
billboard_tidy %>% top_n(1, rank) %>% select(track,rank) %>% arrange(rank)

#Show for each artist, their top rank
billboard_tidy %>% top_n(1, rank) %>% select(artist,rank)

#List artists in increasing order of their top rank
billboard_tidy %>% top_n(1, rank) %>% select(artist,rank) %>% arrange(rank)

#List tracks that only spent one week in the charts
billboard_tidy %>% group_by(track) %>% filter(n() == 1) %>% select(track)

#List tracks that only spent one week in the charts along with its artist
billboard_tidy %>% filter(weeks == 1) %>% select(artist, track)

#Read the .csv file using read_csv (NOT read.csv) and store it in a table.
premiums <- read_csv("Downloads/insurance_premiums.csv")
insurance_premiums%>% 
  pivot_longer(cols = -Location, names_to= c("year", "type of contribution"), names_sep = "__", values_to = "premium" )

#Pivot_longer all columns except Location into two names_to columns. This requires a names_sep to be specified. Read the help for pivot_longer().
premiums %>% pivot_longer(cols = -Location, names_to= c("year", "type of contribution"), names_sep = "__", values_to = "premium" )

#Pivot_wider a pair of columns from the previous step. 
premiums %>% pivot_wider(names_from = "type of contribution", values_from = "premium")
     