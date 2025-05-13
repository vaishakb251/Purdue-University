#### Lab 5

# a
data <- read.csv("C:/Users/PNW_checkout/Downloads/sem2/0. Coursework/Data science/Lab/Lab 5/insurance.csv")
head(data)
dim(data)
cat("There are 7 columns and 1338 rows in the given dataset")

# b
names(data)
attach(data)
# if we are mentioning the data=data, then attach is optional
model <- lm(charges~., data=data)
model
cat("Fitted Model Equation is:
charges = -11938.5+(256.9*age)-(131.3*sexmale)+(339.2*bmi)+(475.5* children)+(23848.5*smokeryes)-(353.0*regionnorthwest)-(1035.0*regionsoutheast)-(960.1*regionsouthwest)")

# c
summary(model)
cat("Here,sexmale and regionnorthwest found to be non-significant")
cat("R^2 squared value: 0.7509")
cat("Adjusted R^2 squared value: 0.7494")
AIC(model)
cat("AIC(model): 27115.51")
BIC(model)
cat("BIC(model): 27167.5")

install.packages("MPV")
library(MPV)
PRESS(model)
cat("PRESS(model): 49581319689")

# d
install.packages("MASS")
library(MASS)
stepAIC(model)
cat("Significant variables identified by StepAIC model are: age, bmi, children, smoker, region")

# e
plot(model,4)
install.packages("olsrr")
library(olsrr)
ols_plot_cooksd_chart(model)
# ols_plot_cooksd_chart(model, threshold = 0.002)
ols_plot_cooksd_bar(model)
# ols_plot_cooksd_bar(model, threshold = 0.002)
ols_plot_dffits(model)

# EXTRA
install.packages("leaps")
library(leaps)
subsets = regsubsets(charges~age+sex+bmi+children+smoker+region, data=data)
summary(subsets)
plot(subsets, main = "regsubsets plot using BIC")
plot(subsets, main = "regsubsets plot using Cp", scale = "Cp")
plot(subsets, main = "regsubsets plot using R^2", scale = "r2")
plot(subsets, main = "regsubsets plot using R^2 adjusted", scale = "adjr2")

# outliers
plot(model,4)
influence.measures(model)

# OLSRR
# install.packages("olsrr")
# library(olsrr)
ols_plot_dffits(model)
ols_plot_cooksd_bar(model)
ols_plot_dfbetas(model)
ols_regress(charges~., data=data)

# EXAMPLE DATASET:  data(swiss)
# extractAIC(model) # for AIC
# extractAIC(model, k = log(n)) # for BIC
