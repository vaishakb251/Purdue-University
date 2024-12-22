#Q1
y = scan()
# 3 11  8 10 13  5  4 14  5  9
y
x = scan()
# 63 79 53 77 89 66 64 91 71 74
x
x;y
plot(x,y, pch = 17, lwd = 2)
cor(x,y)
# or cor(x,y,method = p) or cor(x,y, method = "pearson")
cor(x,y,method = "s")
cor(x,y,method = "k")
cor.test(x,y, method = "p")$p.value
cat("Reject the null hypothesis i.e. We have enough evidence to say that they are correleated")
shapiro.test(y)
cat("There are normally distributed, best suit is pearson!!")
# cor.test(x,y, method = "s")$p.value
# cor.test(x,y, method = "k")$p.value

#Q2
Q2 = read.csv("https://archive.ics.uci.edu/ml/machine-learning-databases/breast-cancer-wisconsin/wdbc.data", header = F)
dim(Q2)
data <- Q2[, 3:8]
cor(data)
install.packages("corrplot")
library(corrplot)
corrplot(cor(data), method = "shade", type = "upper")
# type options: "full", "lower", "upper"
# method options: "circle", "square", "ellipse", "number", "shade", "color", "pie"

#Q3
install.packages("PASWR")
library(PASWR)
data(Grades)
head(Grades)
dim(Grades)
attach(Grades)
plot(sat,gpa, pch = 17, col = 2, main = "GPA vs SAT")
m = lm(gpa~sat)
m
cat("The equation of the fitted model is: gpa = -1.192064 + 0.003094*sat")
abline(m, lwd = 2, col = 4)
# also abline(b0,b1) i.e., abline(intercept, slope)
# library(UsingR)
# simple.lm(independent, dependent, show.ci = TRUE)