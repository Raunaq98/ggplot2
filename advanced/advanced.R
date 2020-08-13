#### STATISTICS LAYERS

#can be called from within or called independently 
library(ggplot2)

data<- iris

ggplot(data, aes(x=Sepal.Length, y=Sepal.Width,colour=Species)) +
         geom_point() +
         geom_smooth(method="lm")+
         labs( title = "iris dataset with linear regression and standard error") #1

ggplot(data, aes(x=Sepal.Length, y=Sepal.Width,colour=Species)) +
         geom_point() +
         geom_smooth(method="lm", fullrange=TRUE)+
         labs( title = "iris dataset with linear regression and standard error over entire range") #2

## adding quantile
library(quantreg)
ggplot(data, aes(x=Sepal.Length, y=Sepal.Width,colour=Species)) +
         geom_point() +
         geom_quantile(quantiles= 0.5)+
         labs( title = "iris dataset with median") #3

ggplot(data, aes(x=Sepal.Length, y=Sepal.Width,colour=Species)) +
         geom_point() +
         geom_quantile(quantiles= 0.9)+
         labs( title = "iris dataset with 90% of data") #4

ggplot(data, aes(x=Sepal.Length, y=Sepal.Width,colour=Species)) +
         geom_point() +
         geom_quantile(quantiles= c(0.1,0.5,0.9))+
         labs( title = "iris dataset with different quantiles") #5


## adding mean and sd

mean_sdl(iris$Sepal.Width,mult=1)
# mult = 1 means 1 sd
#         y     ymin   ymax
#  1 3.057333 2.621467 3.4932
# y = mean
# y min = y - sd
# y max = y + sd

ggplot(data,aes(x=Species,y=Sepal.Width)) +
         stat_summary(fun=mean,geom="point")+
         stat_summary(fun.data = mean_sdl, fun.args = list(mult=1),  geom = "errorbar") #6


### WORKING WITH COORDINATES

iris.smooth <- ggplot(data, aes(x=Sepal.Length, y=Sepal.Width,colour=Species)) +
         geom_point() +
         geom_smooth()+
         labs( title = "iris dataset with standard error") 
iris.smooth # 7

## zooming in
iris.smooth.zoom <- ggplot(data, aes(x=Sepal.Length, y=Sepal.Width,colour=Species)) +
         geom_point() +
         geom_smooth()+
         xlim (4.5,5.5) +
         labs( title = "ZOOMED IN iris dataset with standard error")
iris.smooth.zoom # 7-1

#this filters the data and makes a new graph from scratch

# what if we actually want to zoom
iris.smooth.zoom.actual <- ggplot(data, aes(x=Sepal.Length, y=Sepal.Width,colour=Species)) +
         geom_point() +
         geom_smooth()+
         coord_cartesian(xlim = c(4.5 , 5.5)) +
         labs( title = "ACTUAL ZOOMED IN iris dataset with standard error")
iris.smooth.zoom.actual # 7-2

library(cowplot)
plot_grid(iris.smooth.zoom,iris.smooth.zoom.actual) # 7-1-2


### ASPECT RATIO

iris_unkn <- iris.smooth + labs( title = "aspect ratio = original")
iris_1.0<- iris.smooth + coord_fixed(1) + labs( title = "aspect ratio =1.0")
iris_0.25<- iris.smooth + coord_fixed(0.25)+ labs( title = "aspect ratio =0.25")
iris_0.5<- iris.smooth + coord_fixed(0.5)+ labs( title = "aspect ratio =0.5")
iris_0.75<- iris.smooth + coord_fixed(0.75)+ labs( title = "aspect ratio =0.75")

plot_grid(iris_unkn,iris_1.0,iris_0.25,iris_0.5,iris_0.75) # 8


### scales and coordinates

wt1<- ggplot(msleep,aes(x=bodywt,y=1))+
         geom_point(position="jitter") +
         labs(title = "bodyweight plot") # 9

wt2<- ggplot(msleep,aes(x=bodywt,y=1))+
         geom_point(position="jitter") +
         labs(title = "bodyweight plot with adjusted limits") +
         scale_x_continuous(limits = c(0,7000)) # 9-1

wt3<- ggplot(msleep,aes(x=bodywt,y=1))+
         geom_point(position="jitter") +
         labs(title = "bodyweight plot with adjusted limits and breaks of x axis") +
         scale_x_continuous(limits = c(0,7000) , breaks = seq(0,7000,by=1000)) # 9-2

plot_grid(wt1,wt2,wt3) # 9-1-2

### LOG SCALES

wt_log<- ggplot(msleep,aes(x=bodywt,y=1))+
         geom_point(position="jitter") +
         labs(title = "bodyweight plot with log x scale")+
         scale_x_log10()
wt_log 

plot_grid(wt1,wt_log) #10


### FLIPPED AXES

temp1<- ggplot(data, aes(x=Sepal.Length, y=Sepal.Width,colour=Species)) +
         geom_point() +
         geom_smooth(method="lm",se=FALSE)+
         labs( title = "iris dataset")
temp2<- ggplot(data, aes(x=Sepal.Length, y=Sepal.Width,colour=Species)) +
         geom_point() +
         geom_smooth(method="lm",se=FALSE)+
         labs( title = "iris dataset with flipped axes") +
         coord_flip()
plot_grid(temp1,temp2) #11


### FACETS

ggplot(data,aes(x=Sepal.Length,y=Sepal.Width,colour= Sepal.Width>3))+
         geom_point()+
         facet_wrap(~Species) # 12

ggplot(data,aes(x=Sepal.Length,y=Sepal.Width,colour= Sepal.Width>3))+
         geom_point()+
         facet_wrap(~Species) 

## best way to facet with proper labels :
ggplot(mtcars,aes(x=hp,y=mpg))+
         geom_point() +
         facet_grid(rows=vars(gear),cols =vars(cyl) ,labeller = label_both) #13

## renaming levels within the data:

library(forcats)
data123<- mtcars
data123$cyl<- as.factor(data123$cyl)
data123$cyl<- data123$cyl %>% fct_recode("FOUR" = "4",
                                     "SIX" = "6",
                                     "EIGHT" = "8")

## releveling the factors

data123$cyl <- data123$cyl %>% fct_relevel(c("EIGHT","SIX","FOUR"))

car1<- ggplot(mtcars,aes(x=hp,y=mpg))+
         geom_point() +
         facet_grid(rows=vars(gear),cols =vars(cyl) ,labeller = label_both)

car2<- ggplot(data123,aes(x=hp,y=mpg))+
         geom_point() +
         facet_grid(rows=vars(gear),cols =vars(cyl) ,labeller = label_both)

plot_grid(car1,car2) #14

## freeing up scales

car3<- ggplot(mtcars,aes(x=hp,y=mpg))+
         geom_point() +
         facet_grid(rows=vars(gear),cols =vars(cyl) ,labeller = label_both , scales = "free")

plot_grid(car1,car3,labels = c("fixed scales","freescales"))  # 15       

######## facet_grid keeps uniform scale by default
######## facet_wrap uses individual scales
######## try to use facet_grid through rows and columns


#### MARGIN PLOTS : SHOW FACETS + COMBINED PLOT

car4<- ggplot(mtcars,aes(x=hp,y=mpg))+
         geom_point() +
         facet_grid(rows=vars(gear),cols =vars(cyl) ,labeller = label_both )
car5<- ggplot(mtcars,aes(x=hp,y=mpg))+
         geom_point() +
         facet_grid(rows=vars(gear),cols =vars(cyl) ,labeller = label_both ,  margins = TRUE)

plot_grid(car4,car5) #16
