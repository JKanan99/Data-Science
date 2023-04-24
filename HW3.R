library(tidyverse)
library(nycflights13)
view(flights)

#List data only for flights that departed on March 12, 2013.
flights %>% filter(month == 3 , day == 12, year == 2013)

#List data only for flights that were delayed (both arrival and departure) by more than 2 hours.
flights %>% filter(dep_delay > 2 , arr_delay > 2)

#List data only for flights that were delayed (either arrival or departure) by more than 2 hours.
flights %>% filter(dep_delay > 2 | arr_delay > 2)

#List data only for flights that were operated by United, American, or Delta.
flights %>% filter(carrier == "UA" | carrier == "AA" | carrier == "DL")

#Sort data in order of fastest flights (air_time).
flights %>% arrange(air_time)

#Sort data in order of longest duration flights (air_time).
flights %>% arrange(-air_time)

#Show only the origin and destination of flights sorted by longest flights.
flights %>% arrange(-air_time) %>%  select(origin, dest)

