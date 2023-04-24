
View(esoph)

#Does the dataset contain any NAs? If so, which variables have NAs? What is the type of variable tobgp? [Hint: use str() and summary()]
is.na(esoph)

str(esoph)
summary(esoph)

#Visualize variable ncases. 
#Give a more descriptive name to the axis (Hint: help(esoph) to see a description of the dataset). 
#Doees this variable contain outliers? Are these outliers errors or legitimate values?
help(esoph)
library(ggplot2)
ggplot(data=esoph)+geom_histogram(mapping = aes(x=ncases)) + labs(x='number of cases')

#Visualize variable agegp. Give a more descriptive name to the axis. (Hint: use geom_bar() for discrete variables.)
ggplot(data=esoph)+geom_bar(mapping = aes(x=agegp)) + labs(x='Age Group')

#Visualize variables agegp and alcgp
ggplot(data = esoph) + geom_bar(mapping = aes(x = agegp, fill = alcgp))

#Visualize variables alcgp and ncontrols.
ggplot(data=esoph) + geom_boxplot(mapping = aes(x = alcgp, y = ncontrols))

#Visualize variables ncases and ncontrols.
ggplot(data = esoph) + geom_point(mapping = aes(x = ncases, y = ncontrols))

#Visualize variables ncases, ncontrols, and alcgp.
ggplot(data = esoph) + geom_point(mapping = aes(x = ncases, y = ncontrols, color = alcgp))


