iris_data <- iris
library(ggplot2)
# contains info about 3 species of flowers regarding their sepal and petal lengths and widths

ggplot(iris_data,aes(x=Sepal.Length,y=Sepal.Width)) + geom_point()   #1


ggplot(iris_data,aes( x = Sepal.Length , y = Sepal.Width , color = Species )) + geom_point()   #2
#or
ggplot(iris_data,aes( x = Sepal.Length , y = Sepal.Width )) + geom_point(aes(colour=Species))  


ggplot(iris_data,aes( x = Sepal.Length , y = Sepal.Width , color = Species )) + geom_point(alpha=0.5)  #3
# or we can use Species as a value setter of opacity
ggplot(iris_data,aes( x = Sepal.Length , y = Sepal.Width  )) + geom_point(aes(alpha=Species))   #33


ggplot(iris_data,aes( x = Sepal.Length , y = Sepal.Width , size = Species, color= Species )) + geom_point()  #4
#or
ggplot(iris_data,aes( x = Sepal.Length , y = Sepal.Width  )) + geom_point(aes(size=Species,colour=Species))


ggplot(iris_data,aes( x = Sepal.Length , y = Sepal.Width , shape= Species)) + geom_point()  #5


ggplot(iris_data,aes( x = Sepal.Length , y = Sepal.Width , color = Species )) + geom_point(shape=1,size=4)   #6


ggplot(iris_data,aes( x = Sepal.Length , y = Sepal.Width )) + geom_text(aes(label=Species))   #7


### it often happens that data points are overlapping
# this is taken care of by the position argument
# one way of doing it is by using position_jitter that gives a random noise ie. width so that
# points do not overlap

plot1 <- ggplot(iris_data,aes( x = Sepal.Length , y = Sepal.Width , color = Species )) + geom_point() 

pos <- position_jitter(0.1)
plot2<- ggplot(iris_data,aes( x = Sepal.Length , y = Sepal.Width , color = Species )) + geom_point(position = pos) 

library(cowplot)
plot_grid(plot1,plot2,labels=c("no jitter","jitter"))   #8

# we couldve just used this :

ggplot(iris_data,aes( x = Sepal.Length , y = Sepal.Width , color = Species )) + geom_point() + geom_jitter(width=0.1)



### using scales

plot3 <- ggplot(iris_data,aes( x = Sepal.Length , y = Sepal.Width , color = Species )) + geom_point() 

plot4 <- ggplot(iris_data,aes( x = Sepal.Length , y = Sepal.Width , color = Species )) + geom_point(position = pos)+
         scale_x_continuous("SEPAL LENGTH",limits=c(4.5,7.5)) +
         scale_y_continuous("SEPAL WIDTH", limits=c(2.5,4.0)) +
         scale_color_discrete("COLOUR BASED ON SPECIES")

plot_grid(plot3,plot4,labels=c("original","jitter+scales"))   #9

# we can add breaks to set the distance between 2 cons points on the x and y axes

plot5 <- ggplot(iris_data,aes( x = Sepal.Length , y = Sepal.Width , color = Species )) + geom_point() 

plot6 <- ggplot(iris_data,aes( x = Sepal.Length , y = Sepal.Width , color = Species )) + geom_point(position = pos)+
         scale_x_continuous("SEPAL LENGTH",limits=c(4.5,7.5),breaks=seq(4.5,7.5,by=0.5)) +
         scale_y_continuous("SEPAL WIDTH", limits=c(2.5,4.0),breaks = seq(2.5,4.0,by=0.5)) +
         scale_color_discrete("COLOUR BASED ON SPECIES")

plot_grid(plot5,plot6,labels=c("original","jitter+scales+breaks"))   #10


#### changing labels without using scales

ggplot(iris_data,aes( x = Sepal.Length , y = Sepal.Width , color = Species )) + geom_point()+
         labs(x="X LABEL HERE",y = "Y LABEL HERE" , title = "TITLE HERE", color = " COLOUR LABEL HERE") #11

#### setting axes limits without using scales

ggplot(iris_data,aes( x = Sepal.Length , y = Sepal.Width , color = Species )) + geom_point() + ylim(0,5) + xlim(4,7)



#### accessing another column of db and plotting on the same graph

library(dplyr)
iris_means <- iris_data %>% group_by(Species) %>% summarise_all(mean)

ggplot(iris_data,aes( x = Sepal.Length , y = Sepal.Width , color = Species )) + geom_point() +
         geom_point(data=iris_means,hape=15,size=5)        #12


##### HISTOGRAM

ggplot(iris_data,aes(x=Sepal.Width)) + geom_histogram()   #13


ggplot(iris_data,aes(x=Sepal.Width)) + geom_histogram(binwidth = 0.1, center=0.05)    # 14
# always keep center = binwidth/2

plot7<- ggplot(iris_data,aes(x=Sepal.Width,color=Species)) + geom_histogram(binwidth = 0.1, center=0.05)
plot8<- ggplot(iris_data,aes(x=Sepal.Width,fill=Species)) + geom_histogram(binwidth = 0.1, center=0.05)
plot_grid(plot7,plot8,labels=c("colour","fill"))   #15

# by default the position of bars is "stacked" ie on top of each other
# this may reduce the readability
ggplot(iris_data,aes(x=Sepal.Width,fill=Species)) + geom_histogram(binwidth = 0.1, center=0.05,position="dodge")   #16


plot9<- ggplot(iris_data,aes(x=Sepal.Width)) + geom_histogram(binwidth = 0.1, center=0.05)    
plot10<-ggplot(iris_data,aes(x=Sepal.Width,y=..density..)) + geom_histogram(binwidth = 0.1, center=0.05)    
plot_grid(plot9,plot10,labels=c("count","density"))   #17


#### histogram -> continius x axis is binned
#### bar plot -> discrete (categorical) x axis from start
### we use geom_bar for number of cases per x value (count)
### we use geom_col to plot actual value of y at a certain x

ggplot(iris_data,aes(x= Species))+ geom_bar()

iris_means <- iris_data %>% group_by(Species) %>% summarise_all(mean)
ggplot(iris_data,aes(x= Species,y=iris_means))+ geom_col()

#### geom_line is used to plot time series data

# for multiple time series:
# str(fish.tidy)
#'data.frame':	427 obs. of  3 variables:
#$ Species: Factor w/ 7 levels "Pink","Chum",..: 1 1 1 1 1 1 1 1 1 1 ...
#$ Year   : int  1950 1951 1952 1953 1954 1955 1956 1957 1958 1959 ...
#$ Capture: int  100600 259000 132600 235900 123400 244400 203400 270119 200798 200085 ...
#
#  ggplot(fish.tidy, aes(Year, Capture)) + geom_line(aes(group = Species))
#
# for only colour:
# ggplot(fish.tidy, aes(Year, Capture, color = Species)) + geom_line()



#### THEMES
#  text -> element_text() 
#  line -> element_line()   
#  rectangle -> element_rect()   

# theme(legend.position=c("0.6,0.1"))