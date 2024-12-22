data(mtcars)
head(mtcars)
dim(mtcars)
str(mtcars)
attach(mtcars)
plot(wt, mpg, pch = 18, col = 5, cex = 2)
install.packages("car")
library(car)
scatterplot(wt,mpg,pch = 18, col= 5, cex = 2)
install.packages("scatterplot3d")
library(scatterplot3d)
scatterplot3d(wt,disp,mpg, pch = 18, type = "h", color = "red")


data = read.table("http://jse.amstat.org/datasets/babyboom.dat.txt",col.names = c("a","b","c","d") )
head(data)
dim(data)
weight = data[,3]
weight
hist(weight,col = rainbow(5),ylim = c(0,20), breaks = 3,main = "Histogram")


newb <- c(20,15,9,5)
names(newb) = c("Apartment" ,"Dorm" ,"House" ,"Sorority/Fraternity House")
pie(newb,col = c(1,2,3,4))


install.packages("haven")
library(haven)
data = read_dta("http://www.principlesofeconometrics.com/poe4/data/stata/homes.dta")
head(data)
dim(data)
attach(data)
summary(data)
fivenum(irate)
fivenum(homes)
plot(irate,homes,pch = 18,col = 6, cex = 1.5)
scatterplot(irate,homes)


install.packages("ggplot2")
library(ggplot2)
data("mpg")
head(mpg)
dim(mpg)
summary(mpg)
attach(mpg)
summary(cty)
summary(hwy)
ggplot(data = mpg, aes(x = displ, y = hwy, color = trans)) + geom_point(size = 2, pch = 17) + ggtitle("Scatterplot")
