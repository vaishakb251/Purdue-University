# x<-c( 65, 63, 47, 54, 60, 44, 59, 64, 51, 49, 57, 56, 63, 41, 43)
# y<-c(164,220,133,146,162,144,166,152,140,145,135,150,170,122,120)
# model=lm(y~x)
# model
# plot(x,y)
# abline(model)
# res = residuals(model)
# res
# sum(res)
# predict(model)
# predict(model, data.frame(x = 56))
# predict(model, data.frame(x = c(56,46,51)))
# summary(model)
# predict(model, data.frame(x = 56), interval = "conf") 
# #Therefore, for the entire set
# predict(model, data.frame(x = 56), interval = "pred") 
# #Therefore, for the value age = 56-> usually wider than conf interval
# predict(model, data.frame(x = 56), interval = "conf", level = 0.9)
# predict(model, data.frame(x = 56), interval = "conf",level = 0.95)
# predict(model, data.frame(x = 56), interval = "conf",level = 0.99)
# # getting more narrow
# 
# # Example
# x<-c(0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4)
# y<-c(13.44, 12.84, 11.91, 20.09, 15.60, 10.11, 11.38, 10.28, 8.96, 8.59,
#      9.83, 9.00, 8.65, 7.85, 8.88, 7.94, 6.01, 5.14, 6.90, 6.77, 4.86,
#      5.10, 5.67, 5.75,6.23)
# m1 = lm(y~x)
# m1
# summary(m1)
# plot(m1)
# plot(m1,1)
# par(mfrow = c(2,2))
# plot(m1)
# library(MASS)
# B = boxcox(m1)
# # lambda - 0 - log
# # 1 - no transformtion
# # 0.5- square root
# B
# y1 <- y^(-0.5)
# m11 = lm(y1~x)
# m11
# summary(m11)
# # note: r square value increased -> good!!
# plot(m11)
# plot(m11, 1)
# plot(m1,1)


##################################################

# LAB 15

##################################################

# Q1
beers <- scan()
# 5 2  9 	   8	  3 	  7 	   3	    5	   3 	  5
bal <- scan()
# 0.10 	0.03 	0.19 	0.12 	0.04 	0.095	 0.07	 0.06 	0.02 	0.05
beers; bal
plot(beers, bal, pch = 17, col = 2, main = "Beers VS BAL")
model1 <- lm(bal~beers)
model1
abline(model1, lwd = 2, col = "blue")
cat("Fitter Model:  BAL = -0.0185 + 0.0912 * Beers")
confint(model1, level = 0.9)
summary(model1)
cat("Beta < alpha -> reject the null hypothesis, we conclude that BAL value is dependent on the beers variable")
predict(model1, data.frame(x = 7))

#Q2
x <- scan()
# 0 	1	 2 	3	 4	 5 	6 	7	 8	 9
y <- scan()
# 98 	135 	162 	178 	221 	232 	283 	300 	374	 395
x;y
plot(x,y,pch = 17, col = 2, main = "X vs Y")
model2 <- lm(y~x)
model2
cat("Fitted Model: y = 91.56 + 32.50 * x")
abline(model2, lwd = 2, col = "green")
# ALSO: abline(91.56, 32.50 , lwd = 2, col = "green")
predict(model2, data.frame(x = 10))
cat("For x = 10, y -> 416.5333")
predict(model2, data.frame(x = 10),interval = "conf", level = 0.95) # 95%
predict(model2, data.frame(x = 10),interval = "conf", level = 0.9) # 90%

#Q3
X <- scan()
# 0.5	0.7	2.5	4.1	5.9	6.1	7	8.2	10	10.1	10.9	11.5	12.1	14.1	15
Y <- scan()
# 41	55	41	39	50	32	41	42	26	35	25	31	31	29	23
X;Y
plot(X,Y,main = "X against Y", pch = 17, col = 2)
model3 <- lm(Y~X)
model3
abline(model3, lwd = 2, col = "green")
cat("Linear Fitted Line: Y = 48.540 - 1.576*X")
predict(model3, data.frame(X=8))
cat("For X=8 -> Y=35.93006")
predict(model3, data.frame(X=8),interval = "conf",level = 0.95)
predict(model3, data.frame(X=8),interval = "conf",level = 0.90)


#Q4
Q4 <- read.table("http://media.pearsoncmg.com/aw/aw_sharpe_business_3/datasets/txt/GDP_2013.txt",sep = "\t", header = T)
head(Q4,5)
dim(Q4)
names(Q4) = c("Year","GDP")
head(Q4,5)
attach(Q4)
plot(Q4,pch = 17, col = 2)
model4 <- lm(GDP~Year)
model4
cat("Fitted Model: GDP = -387.8433 + 0.1993*Year")
abline(model4, lwd = 2, col = "green")
summary(model4)
cat("Multiple R-squared:  96.73%")
plot(model4,1)
cat("need transformation -> as it is expected to be scattered")
install.packages("MASS")
library(MASS)
b = boxcox(model4)
y1 = GDP^(0.25)
model_new = lm(y1~Year)
model_new
cat("New Fitted Model: y1^0.25 = -22.66422 + 0.01224 * Year")
summary(model_new)
cat("Increased R square value -> Good!!")
plot(model_new,1)
cat("Residual Plot is way better than the previous one!!")
