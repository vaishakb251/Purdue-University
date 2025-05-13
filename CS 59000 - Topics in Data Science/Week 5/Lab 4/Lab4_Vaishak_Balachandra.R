#################### Lab 4

################################################################################

#################### Q1

install.packages("readxl")
library(readxl)
# file.choose()
Q1 <- read_excel("C:/Users/PNW_checkout/Downloads/sem2/0. Coursework/Data science/Lab/Lab 4/Q1.xlsx")
head(Q1,5)
names(Q1)
dim(Q1)
attach(Q1)

# a
plot(X1,y,pch = 17, main = "Size of the firm vs Number of months elapsed", col = ifelse(X2 == "Mutual", "red", "green"))
legend(225,35,fill = c("red","green"), c("Mutual","Stock"))

# b
model = lm(y~X1+X2)
model
cat("Fitted Model Equation:

for Mutual:
y = 33.8741 -0.1017*Size
    
for Stock:
y = 41.9296 -0.1017*Size")

abline(33.8741, -0.1017, lwd = 2, col = "red") # for Mutual
abline(41.9296, -0.1017, lwd = 2, col = "green") # for Stock

################################################################################

#################### Q2

# a
data("mtcars")
head(mtcars)
colnames(mtcars)
dim(mtcars)
attach(mtcars)

# b
model2 <- lm(mpg~disp+hp+wt+qsec)
model2
cat("Fitted Model Equation:
mpg =   27.329638 + 0.002666*disp - 0.018666*hp - 4.609123*wt + 0.544160*qsec")

# c
summary(model2)
cat("From the model summary, using the pvalue = 0.00113(**),
'wt' is the only variable that is significant, while other variables have pvalue > 0.05, that's makes them insignificant!!")

# d
# anova(model2)
summary(model2)
cat("Coefficient of Determination: 
Multiple R^2 squared value: 83.51%
Adjusted R^2 squared value: 81.07%")


################################################################################
