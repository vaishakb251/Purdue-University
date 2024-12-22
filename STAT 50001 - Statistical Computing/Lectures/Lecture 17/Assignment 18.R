# data(mtcars)
# head(mtcars)
# dim(mtcars)
# names(mtcars)
# model <- lm(mpg~cyl+disp+hp+wt, data = mtcars)
# model
# dffits(model)
# influence.measures(model)
# install.packages("olsrr")
# library(olsrr)
# model <- lm(mpg~cyl+disp+hp+wt, data = mtcars)
# ols_regress(mpg~cyl+disp+hp+wt, data = mtcars)
# ols_aic(model)
# AIC(model)
# ols_plot_resid_fit(model)
# ols_plot_cooksd_bar(model, threshold = 0.2)
# ols_plot_cooksd_chart(model, threshold = 0.2)
# ols_plot_dffits(model)
# ols_plot_dfbetas(model)
# ols_plot_resid_lev(model)
# influence.measures(model)

####################################

# Assignment 18

####################################

#Q1
# file.choose()
Q1 <- read.table("C:\\Users\\PNW_checkout\\Downloads\\vaishak\\PNW_COURSE-WORK\\FALL24\\STATISTICAL COMPUTING\\Assignment\\Assignment 18\\Q1_Assignment18.txt", header = T)
head(Q1)
dim(Q1)
attach(Q1)
# note: ID is a not to be considered, its just like sl no
model1 <- lm(y~x1+x2+x3, data = Q1)
model1
cat("Fitted Model1: \n
    y = 158.491 -1.142*x1 - 0.442*x2 - 13.470*x3 ")
# Also
cat("Fitted Model1: \n
    patients satisfaction  = 158.491 -1.142*(age) - 0.442*(severity_Score) - 13.470*(anxiety_level)")
# install.packages("olsrr")
cat("b2 interpretation: as severity_score increase by 1 unit, the satisfcation resduces by 0.442 units")
library(olsrr)
model1a <- ols_regress(y~x1+x2+x3, data = Q1)
# model1a <- ols_regress(model1, data = Q1)
model1a
cat("R -> 0.826, Inference: ..........................")

influence.measures(model1)
# 2nd, 10th, 45th observations, seem to have outliers
ols_plot_cooksd_bar(model1)
# -----------------------------
ols_plot_dffits(model1)
# -----------------------------
# or
plot(model1, which = 4) #plots cooks plot

########################################################################

#Q2
file.choose()
Q2 = read.csv("C:\\Users\\PNW_checkout\\Downloads\\vaishak\\PNW_COURSE-WORK\\FALL24\\STATISTICAL COMPUTING\\Assignment\\Assignment 18\\profs.csv")
head(Q2,4)
dim(Q2)
names(Q2)
attach(Q2)
plot(beauty, eval, pch = 17, col = "red")
model2 <- lm(eval~beauty, data = Q2)
model2
cat("Fitted Model: \neval = 3.998+0.133*beauty\nComment: It's a weak model")
summary(model2)
# beauty_Score is not significant
abline(model2, lwd = 2, col = "green")

# install.packages("MASS")
# library(MASS)
# modelsr = lm(y~Q2$minority+Q2$age+Q2$gender+Q2$credits+Q2$beauty+Q2$division+Q2$native+Q2$tenure+Q2$students+Q2$allstudents,data = Q2) #all variables considered initially
# step = stepAIC(modelsr, direction = "both")
# cat("By stepwise regression: y ~ x1 + x3")
# cat("Thus x1 and x3 are significant")
