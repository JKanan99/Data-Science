#=================== DATA VISUALIZATION =======================

#--plots--
library(ggplot2)
ggplot(data=airquality) + geom_point(mapping=aes(x = Temp, y = Ozone))

#different aesthetics to map different parameters 
  #changes the color of the months (gradient)
ggplot(data=airquality) + geom_point(mapping=aes(x = Temp, y = Ozone, color = Month))

#hard code the color - when hardcoding the color do it outside the mapping parameter 
ggplot(data=airquality) + geom_point(mapping=aes(x = Temp, y = Ozone), color="red")

#map shape to the month (doesn't work)
ggplot(data=airquality) + geom_point(mapping=aes(x = Temp, y = Ozone, shape = Month))

#facet iris scatter plot by Species - ~ lets you map with different variables 
ggplot(data = iris) + geom_point(mapping=aes(x=Sepal.Length, y=Sepal.Width)) + facet_wrap(~Species)
ggplot(data = iris) + geom_point(mapping=aes(x=Sepal.Length, y=Sepal.Width)) + facet_grid(Petal.Width~Species)

#--Scales--
ggplot(data=airquality) + geom_point(mapping=aes(x = Temp, y = Ozone, color = Month)) + scale_x_continuous(name="temperature", limits=c(60,90))
ggplot(data=airquality) + geom_point(mapping=aes(x = Temp, y = Ozone, color = Month)) + scale_x_log10(name="temperature", limits=c(60,90))+theme_dark()
ggplot(data=airquality) + geom_point(mapping=aes(x = Temp, y = Ozone, color = Month)) + scale_x_log10(name="temperature", limits=c(60,90))+theme_bw()

#-------------Classwork---------------
#Create a scatter plot of Sepal.Length vs. Sepal.Width
ggplot(data=iris) + geom_point(mapping=aes(x = Sepal.Length, y = Sepal.Width))

#----------------------------

#Create a scatter plot of Sepal.Length vs. Sepal.Width but plot points in red
ggplot(data=iris) + geom_point(mapping=aes(x = Sepal.Length, y = Sepal.Width), color = "red")

#----------------------------

#Create a scatter plot of Sepal.Length vs. Sepal.Width and Species
ggplot(data=iris) + geom_point(mapping=aes(x = Sepal.Length, y = Sepal.Width, color = Species))

#----------------------------


#aesthetics - ggplot2 - size, color, shape, x & y locations- geometry
#columns/variables - assigning them is called mapping 
#scale 
