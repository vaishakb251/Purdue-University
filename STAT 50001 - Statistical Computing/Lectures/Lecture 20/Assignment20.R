y = c(17.6	,16.9	,21.4	,19.3,
      18.9	,15.3	,23.6	,21.1,
      16.3	,18.6	,19.4	,16.9,
      17.4	,17.1	,18.5	,17.5,
      20.1	,19.5	,20.5	,18.3,
      21.6	,20.3	,22.3	,19.8)
y
x = rep(c("I","II","III","IV"), 6)
x
data <- data.frame(y,x)
data
dim(data)
names(data)
attach(data)
# install.packages("PASWR")
library(PASWR)
# oneway.plots(y,x)
boxplot(y~x)
fit = aov(y~x)
summary(fit)
cat("for 0.05 alpha value level, no evidence to tell that mean of each category is different")
plot(fit,which =1)
bartlett.test(y~x)
cat("Here p value = 0.9661 > 0.05, fail to reject again i.e., no evidence to tell that the mean value of each category are different")
TukeyHSD(aov(y~x), data = data, conf.level = 0.99)
plot(TukeyHSD(aov(y~x), data = data, conf.level = 0.9), las = 2)

