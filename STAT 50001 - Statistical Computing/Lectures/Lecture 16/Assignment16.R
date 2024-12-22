# data <- scan()
# data
# M = matrix(data, ncol = 3, byrow=T)
# M
# y = M[,1];y
# x1 = M[,2];x1
# x2 = M[,3];x2
# model = lm(y~x1+x2)
# model
# cat("Fitted Model is: y = 2.34 + 1.61*x1 + 0.014*x2")
# predict(model, data.frame(x1 = 7,x2 = 1400))
# predict(model, data.frame(x1 = 7,x2 = 1400),interval = "conf")
# confint(model) # defaulkt - 0.95 interval
# confint(model, level = 0.9)
# summary(model)
# 
# #to check which among x1 and x2 are significant
# cat("For x2(distance)- > p value less than alpha ->reject hypothesis -> therefore, x2 is significant (i.e beta2 != 0 is accepted)")
# cat("For x1(item count)- > p value less than alpha ->reject hypothesis -> therefore, x1 is significant (i.e beta1 != 0 is accepted)")
# plot(model,1)

#####################

# #multicollinearity
# x1 = scan()
# # 11 8 11 14 17 15 12 10 17 11 8 18 12 10 13 12
# x2 = scan()
# # 14.0 11.8 15.7 15.5 19.5 16.8 12.8 13.6 18.2 16.0 13.0 20.0 15.1 14.2 17.3 15.9
# y = scan()
# # 49.4 47.5 52.6 49.3 61.1 53.2 47.4 49.4 62.0 47.9 47.3 61.5 54.2 44.7 53.6 55.4
# x1;x2;y
# 
# m1 = lm(y~x1)
# summary(m1)
# #significant
# 
# m2 = lm(y~x2)
# summary(m2)
# #significant
# 
# model = lm(y~x1+x2)
# summary(model)
# # both are not significant -> as effect of one nullified by other.
# cat("Individually, both of them are significant, but together they are not significant -> x1 and x2 are correlated!!!")
# 
# install.packages("car")
# library(car)
# vif(model)
# cat("vif more than 10, it not at all accpeted -> inflated -> mulitcollinear")
# 
# vif: variance inflation factor

#####################

# Lab 16

#####################

#Q1
time = scan()
# 1   2 4       6 8	10	 12  14    16   18   20
bod = scan()
# 0.6 0.7 1.5   1.9     2.1     2.6   2.9   3.7   3.5     3.7     3.8
time;bod
plot(time, bod, pch = 17, col= 2, main = "BOD vs Time")
model1 <- lm(bod~time)
model1
cat("Fitted model: bod = 0.6578 + 0.1781*time")
abline(model1, col = "green",lwd = 2)


anova(model1)
cat("Estimated sigma square = 0.0825") # using mean square value under residuals in anova
#or
summary(model1)
# Residual standard error: 0.2873 -> square it -> 0.2873*0.2873

predict(model1, data.frame(time = 15))
cat("For time = 15 Days -> bod -> 3.328639 units")
# confidence interval
predict(model1, data.frame(time = 15), interval = "conf", level = 0.9)
cat("Predicted value for 15 days time for 90% conf int of (3.12, 3.53)")
# prediction interval
predict(model1, data.frame(time = 15), interval = "pred", level = 0.9)
cat("Predicted value for 15 days time for 90% conf int of (2.76, 3.89)")

cat("Change in mean BOD is expected when the time changes by three days: ", 3*0.1781)


########################

#Q2
install.packages("missMDA")
library(missMDA)
data(ozone)
head(ozone)
dim(ozone)
names(ozone)
newdata <- ozone[,c(-12,-13)]
dim(newdata)
names(newdata)
attach(newdata)
model = lm(maxO3~T9+T12+T15+Ne9+Ne12+Ne15+Vx9+Vx12+Vx15+maxO3v, data = newdata)
summary(model)
cat("Significant Variables is(are): maxO3v")
vif(model)
cat("Also, VIF of maxO3v is much lesser when compared to others! -> good!!")
# also
# model1 = lm(maxO3~., data = newdata)
# summary(model1)

###################################

#Q3
Q3 <- read.table("https://online.stat.psu.edu/stat462/sites/onlinecourses.science.psu.edu.stat462/files/data/birthsmokers/index.txt",header = T)
head(Q3)
dim(Q3)
names(Q3)
attach(Q3)
plot(Gest, Wgt, pch = ifelse(Smoke == "yes", 17, 16), col = ifelse(Smoke == "yes", "red", "green"), main = "Wgt vs Gest", col.main = "maroon",col.lab = "orange")
model3 <- lm(Wgt~Gest+Smoke)
model3
summary(model3)
cat("If Smoking:- "); cat("Fitted Model: Wgt = -2,634.1 + 143.1*Gest")
cat("If Not Smoking:- "); cat("Fitted Model: Wgt = -2389.6 + 143.1*Gest")
abline(-2634.1, 143.1, lwd = 2, col = "red")
abline(-2389.6, 143.1, lwd = 2, col = "green")
# predict(model3, data.frame(Gest =35, Smoke = "yes"))
predict(model3, data.frame(Gest =35, Smoke = "no"))

##########################################

#Q4
library(readxl)
Q4 <- read_excel("Q4.xlsx")
head(Q4)
dim(Q4)
attach(Q4)
names(Q4)
plot(y,X1, pch = ifelse(X2 == "Mutual", "m","s"), col = ifelse(X2 == "Mutual", "green","red"), main = "Size of the firm vs.  Number of month elapsed", xlab= "Size of the firm ",ylab = "Number of month elapsed",col.main = "maroon",col.lab = "orange")
model4 <- lm(y~X1+X2)
summary(model4)
model4
cat("If Stock:- "); cat("Fitted Model: y = 41.9296 - 0.1017*X1")
cat("If Mutual:- "); cat("Fitted Model: y = 33.8741 - 0.1017*X1")
