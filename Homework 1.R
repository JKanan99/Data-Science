#========= HOMEWORK 1 ============
#Get number of rows (Hint: nrow) in the data set airquality 
nrow(airquality)

#Get number of columns (Hint: ncol) in the data set airquality
ncol(airquality)

#Show first 10 rows
View(airquality[1:10, ])

#Show the mean Wind
mean(airquality[,3])
mean(airquality$Wind)

#show all rows where Month == 6
airquality[ airquality$Month == 6, ]

#What are the row indexes of the rows where Month==6? (Hint: which)
which(airquality$Month == 6)

#Show all rows where Species is “setosa”
airquality[ airquality$Species == 'setosa', ]

#Show all rows where Month == 6 and Day < 10
airquality[ airquality$Month == 6 & airquality$Day < 10, ]

#Get the largest value of Wind
max(airquality$Wind)

#On what Month and Day was this largest value of Wind observed?
airquality[ airquality$Wind == max(airquality$Wind), "Month"]
airquality[ airquality$Wind == max(airquality$Wind), "Day"]

#Generate the following graphs from the mpg dataset.
#Plot a scatterplot of variables displ and cty.
library(ggplot2)
ggplot(data=mpg) + geom_point(mapping=aes(x = displ, y = cty))

#Redraw the previous scatterplot but also add all these: more descriptive x and y-axis labels, a title that should be the names of all group members, and set cty limits to (0,40) and displ limits to (0,10).
ggplot(data=mpg) + geom_point(mapping=aes(x = displ, y = cty), color = "red") + ggtitle("Jahnvi Panchal, Dania Nasereddin, and Jennah Kanan") +  labs(y = "city miles per gallon", x = "engine displacement (liters)") + coord_cartesian(xlim =c(0, 10), ylim = c(0, 40))

#Plot a scatterplot of variables displ and cty. Show variable year also.
ggplot(data=mpg) + geom_point(mapping=aes(x = displ, y = cty, color=year)) + ggtitle("Jahnvi Panchal, Dania Nasereddin, and Jennah Kanan") +  labs(y = "city miles per gallon", x = "engine displacement (liters)") + coord_cartesian(xlim =c(0, 10), ylim = c(0, 40))

#Plot a scatterplot of variables displ and cty. Show variables year and class also.Hint: There are different ways of doing this using the multiple “aesthetics” of geom_point
ggplot(data=mpg) + geom_point(mapping=aes(x = displ, y = cty, color=class, size=year)) + ggtitle("Jahnvi Panchal, Dania Nasereddin, and Jennah Kanan") +  labs(y = "city miles per gallon", x = "engine displacement (liters)") + coord_cartesian(xlim =c(0, 10), ylim = c(0, 40))
