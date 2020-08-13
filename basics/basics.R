library(gapminder)
library(dplyr)
library(ggplot2)

gapminder_2007 <- gapminder %>% filter(year==2007)

# we now want to plot for the year 2007, the scatterplot between lifeexp and gdp

gg<- ggplot(gapminder_2007, aes( x = gdpPercap, y = lifeExp))
pp<- gg + geom_point()
pp

#### geom refers to a geometric repsentation and geom_point means each datapoint will be
# represented by a single point

gapminder_1952 <- gapminder %>% filter(year==1952)

gg<- ggplot(gapminder_1952, aes( x = pop, y = gdpPercap))
pp<- gg + geom_point()
pp

# in this scatterplot, the axes should be on a log scale in order to better visualise the data

gg<- ggplot(gapminder_1952, aes( x = pop, y = gdpPercap))
pp<- gg + geom_point() + scale_x_log10() + coord_cartesian(ylim = c(0,20000))
pp


# if we want to use a third variable to visualise the same plot, we will use colour and size

# try to use colour for categorical data
gg<- ggplot(gapminder_1952, aes( x = pop, y = gdpPercap,colour=continent))
pp<- gg + geom_point() + scale_x_log10() + coord_cartesian(ylim = c(0,20000))
pp

# try to use size for numeric variables
gg<- ggplot(gapminder_1952, aes( x = pop, y = gdpPercap,colour=continent, size=pop))
pp<- gg + geom_point() + scale_x_log10() + coord_cartesian(ylim = c(0,20000))
pp



### we use facets to divide the plot into subplots based on variables
gg<- ggplot(gapminder_1952, aes( x = pop, y = gdpPercap, size=pop))
pp<- gg + geom_point() + scale_x_log10() + coord_cartesian(ylim = c(0,20000)) + facet_wrap(~ continent)
pp

### plotting summarised data

by_year_continent <- gapminder %>% group_by(year,continent) %>% summarise(totalPop=sum(pop),meanLifeExp=mean(lifeExp))

ggplot(by_year_continent,aes( x = year, y = totalPop,colour=continent)) + geom_point() + expand_limits(y = 0)


######### LINE PLOTS
# these are usually used when there is time on the x axis

by_year_continent <- gapminder %>% group_by(year,continent) %>% summarise(totalPop=sum(pop),meanLifeExp=mean(lifeExp))
ggplot(by_year_continent,aes( x = year, y = totalPop,colour=continent)) + geom_line() + expand_limits(y = 0)


######### BAR PLOTS
# these are usually used to compare stats of diff categories

by_continent<- gapminder %>% filter(year==2007) %>% group_by(continent) %>% summarise(meanlifeExp=mean(lifeExp))
ggplot(by_continent,aes(x=continent,y=meanlifeExp)) +geom_col()


######### HISTOGRAMS
# these are usually to compare distribution of a 1D numeric variable

gapminder_2007 <- gapminder %>% filter(year==2007)
ggplot(gapminder_2007,aes(x=lifeExp)) + geom_histogram()
# we can change bin width
ggplot(gapminder_2007,aes(x=lifeExp)) + geom_histogram(binwidth = 5)


######### BOX PLOTS
# these are usually used to compare distribution of numeric variables in several categories

ggplot(gapminder_2007,aes(x=continent,y=lifeExp)) +geom_boxplot()



####### adding title

ggplot(gapminder_1952, aes(x = continent, y = gdpPercap)) +
         geom_boxplot() +
         scale_y_log10() + labs( x = " continent" , y = "gdpPercap" , title = "Comparing GDP per capita across continents")