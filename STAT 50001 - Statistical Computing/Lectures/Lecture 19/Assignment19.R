#
# 0.0 30.0 1.0 30.0 0.0 30.0
# 0.0 31.0 0.0 32.0 0.0 33.0
# 1.0 34.0 0.0 35.0 0.0 35.0
# 1.0 35.0 1.0 36.0 0.0 37.0
# 0.0 38.0 1.0 39.0 0.0 40.0
# 1.0 40.0 1.0 40.0 0.0 41.0
# 1.0 42.0 1.0 43.0 1.0 44.0
# 0.0 45.0 1.0 45.0 1.0 45.0
# 0.0 46.0 1.0 47.0 1.0 48.0
# 0.0 49.0 1.0 50.0 1.0 50.0
# 
data = scan()
fdata = matrix(data, ncol = 2, byrow = T)
head(fdata)
y = fdata[,1]
x = fdata[,2]
plot(x,y)
model = glm(y~x, family = binomial)
model
cat("Beta0 = -4.8075, Beta1 = 0.1251")
cat("Fitted Logistic Model:
    pi_hat = [1 + exp(4.8075 - 0.1251*x)]^-1")
curve(predict(model, data.frame(x=x), type = 'resp'),add = T)
predict(model, data.frame(x=2)) # gives beta0 and beta1
predict(model, data.frame(x=2), type = "resp") # gives the probability

install.packages("popbio")
library(popbio)
logi.hist.plot(x,y,boxp=FALSE,type="hist",col="gray")

summary(model)

# use of minmax regression is suggested if 3 or more category in a single column


##########################################################################

#LAB 19

##########################################################################

file.choose()
# "C:\\Users\\PNW_checkout\\Downloads\\vaishak\\PNW_COURSE-WORK\\FALL24\\STATISTICAL COMPUTING\\Assignment\\Assignment 19\\Placekick.csv"
Q1 <- read.csv("C:\\Users\\PNW_checkout\\Downloads\\vaishak\\PNW_COURSE-WORK\\FALL24\\STATISTICAL COMPUTING\\Assignment\\Assignment 19\\Placekick.csv")
head(Q1)
dim(Q1)
names(Q1)
attach(Q1)
plot(distance, good)
# scatterplot appears like a logistic
model1 <- glm(good~distance, family = binomial)
model1
cat("Logisitc Regression Fitted Model:
    good = [1+exp(-5.812+0.115*distance)]^-1")
curve(predict(model1, data.frame(distance=x), type = "resp"), add = T)
cat("Inference: As distance increases, the likelihood that success happening decreases -> inverse logistic relation")

# or

# install.packages("popbio")
library(popbio)
logi.hist.plot(distance, good, type ="hist", col = "gray", boxp = F)

predict(model1, data.frame(distance = 37), type = "resp")
cat("Probability of success = 82.579%")

##############################################################

#Q2
Q2 <- read.table("https://media.pearsoncmg.com/aw/aw_sharpe_business_3/datasets/txt/Clinical%20Trials.txt", header = T, sep = "\t", na.strings = " ")
head(Q2, 15)
dim(Q2)
names(Q2)
data = na.omit(Q2)
dim(data)
attach(data)
model2 <- glm(DRP~AGE+HD2114, family = binomial, data = data)
model2
cat("Logisitc Regression Fitted Model:
    DRP = [1+exp(0.44197+0.03790*AGE - 0.04682*HD2114)]^-1")
summary(model2)
predict(model2, data.frame(AGE = 30, HD2114 = 30), type = "resp")
cat("Probablility of Success = 45.643%")
# also
# predict(model2, data.frame(AGE = 30, HD2114 = 30))
# -> -0.1745896
# exp(-0.1745896)/(1+exp(-0.1745896))
# -> 0.4564631