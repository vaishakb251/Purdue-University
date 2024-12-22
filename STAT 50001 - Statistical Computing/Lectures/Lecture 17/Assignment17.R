file.choose()
data <- read.table("C:\\Users\\PNW_checkout\\Downloads\\vaishak\\PNW_COURSE-WORK\\FALL24\\STATISTICAL COMPUTING\\Assignment\\Assignment 17\\hospital.txt",header = T)
head(data)
dim(data)
attach(data)

#Forward Selection
add1(lm(y~1), scope = (~.+x1+x2+x3+x4+x5+x6+x7+x8), test = "F")
# x4 is the most significant, found out using the p value which is least
add1(lm(y~1+x4), scope = (~.+x1+x2+x3+x5+x6+x7+x8), test = "F")
# x8 is the most significant, found out using the p value which is least
add1(lm(y~1+x4+x8), scope = (~.+x1+x2+x3+x5+x6+x7), test = "F")
# x3 is the most significant, found out using the p value which is least
add1(lm(y~1+x4+x8+x3), scope = (~.+x1+x2+x5+x6+x7), test = "F")
add1(lm(y~1+x4+x8+x3+x2), scope = (~.+x1+x3+x5+x6+x7), test = "F")
add1(lm(y~1+x4+x8+x3+x2+x1), scope = (~.+x3+x5+x6+x7), test = "F")
# goes on adding till value < 0.05
# model choosened -> i.e.
modelf = lm(y~x4+x8+x3+x2+x1)
modelf
cat("Fitted Model: ")
summary(modelf)
# observed x4 not significant, -> as we chosened it first -> limitation of forward selection


# Backward Elimination
drop1(lm(y~x1+x2+x3+x4+x5+x6+x7+x8),test = "F")
# highest p>0.05 value will be dropped i.e. x7 dropped
drop1(lm(y~x1+x2+x3+x4+x5+x6+x8),test = "F")
drop1(lm(y~x1+x2+x3+x4+x5+x8),test = "F")
drop1(lm(y~x1+x2+x3+x4+x8),test = "F")
drop1(lm(y~x1+x2+x3+x8),test = "F")
cat("Fitted Model: ")
modelb <- lm(y~x1+x2+x3+x8)
summary(modelb)

# Stepwise Regression
install.packages("MASS")
library(MASS)
modelsr = lm(y~.,data = data) #all variables considered initially
step = stepAIC(modelsr, direction = "both")
cat("By stepwise regression: y ~ x1 + x2 + x3 + x4 + x8")

AIC(modelsr)
BIC(modelsr)

####### awesome ##########

install.packages("leaps")
library(leaps)
group = regsubsets(y~., data = data)
group
summary(group)
# it helps to ask the client how many variables to include in the model
plot(group)
# helps in choosing the model with min bic, using the plot -> x1 + x2 + x3 + x8 from the plot, using the bic criteria
plot(group, scale = "r2")
# helps in choosing the model with max r^2, using the plot -> all variable from the plot, using the r^2 criteria
plot(group, scale = "adjr2")
# helps in choosing the model with max adjusted r^2, using the plot -> except x5, x6, x7 variable from the plot, using the adjusted r^2 criteria
plot(group, scale = "Cp")
# helps in choosing the model with min Cp

##################################################

# ASSIGNMENT 17

##################################################

#Q1
install.packages("Lock5Data")
library(Lock5Data)
data(BodyFat)
head(BodyFat)
dim(BodyFat)
names(BodyFat)
attach(BodyFat)
model1 <- lm(Bodyfat~Weight+Height)
model1
cat("Fitted Model: Bodyfat = 71.4825 + 0.2316*Weight-1.3357*Height")
summary(model1)
cat("Both the Height as well as the Weight are significant")

model2 <- lm(Bodyfat~Weight+Height+Abdomen)
model2
cat("Fitted Model: Bodyfat = -56.1329 -0.1756*Weight+ 0.1018*Height + 1.0747*Abdomen")
summary(model2)
cat("Upon introduction of Abdomen, the Height variable becomes not significant")

cat("Comparing the co-efficient of the model2, it is found that, for abdomen change in 1 cm, the bodyfat increase by 1.0747%, provided other variable i.e. height and weight variable are kept constant")

###########################################

#Q2
Height <- scan()
# 30.00 26.25 25.00 27.00 27.50 24.50 27.75 25.00 28.00 27.25 26.00 27.25 27.00 28.25
Weight <- scan()
# 339 267 289 332 272 214 311 259 298 288 277 292 302 336
head_circumference <- scan()
# 47.0 42.0 43.0 44.5 44.0 40.5 44.0 41.5 46.0 44.0 44.0 44.5 42.5 44.5
Height; Weight; head_circumference
data <- data.frame(Height, Weight, head_circumference)
data
dim(data)
cor(data)
install.packages("car")
library(car)
model = lm(head_circumference~Height+Weight)
model
vif(model)
# no much collinearity
# model accepted
cat("Fitted Model: head_circumference = 18.82425+ 0.78634*Height + 0.01281*Weight ")
predict(model, data.frame(Height = 27.5, Weight = 285))
predict(model, data.frame(Height = 27.5, Weight = 285), interval = "conf", level = 0.95)
cat("conf interval range: [43.39962, 44.79834]")
predict(model, data.frame(Height = 27.5, Weight = 285), interval = "pred", level = 0.95)
cat("Prediction interval range: [42.05886, 46.1391]")

#residual
plot(model, 1)

#preform boxcox transformation (i.e. )
.................