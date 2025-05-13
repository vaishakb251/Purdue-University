######## LAB 3

################################################################################

# Q1

Q1 <- read.table("https://media.pearsoncmg.com/aw/aw_sharpe_business_3/datasets/txt/GDP_2013.txt", header = T, sep = "\t")
head(Q1,5)
dim(Q1)
names(Q1) = c("Year", "GDP")
head(Q1,5)
attach(Q1)

# a
plot(Year, GDP, main = "Scatterplot: GDP against Year", pch = 17, cex = 1.2, col.main = "orange", col.lab = "purple", col = "green")

# b
model = lm(GDP~Year)
model
cat("Fitted Model:
GDP = -387.8433 + 0.1993* Year")

# c
abline(model, lwd = 2, col = "red")

# d
summary(model)
cat("R-squared value: 96.73%")

# e
plot(model,1)
cat("Residual plot is not soo good!! - > as it has a clear structure(parabolic). Thus, needs some transformation!!")

# f
install.packages("MASS")
library(MASS)
b = boxcox(model)
b = boxcox(model, lambda = seq(-1,1))
y1 = GDP^0.25
new_model = lm(y1~Year)           
summary(new_model)
new_model
cat("New Fitted Model:
GDP^0.2 =    -22.66422 + 0.01224*Year")
cat("R-squared value: 99.57%")
plot(new_model,1)
cat("Residual plot has no clear structure, hence a better model!!")



