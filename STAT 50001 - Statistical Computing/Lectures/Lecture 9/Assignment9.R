install.packages("UsingR")
library(UsingR)
data("normtemp")
head(normtemp, 6)
attach(normtemp)
t.test(temperature, mu = 98.6)
cat("Since p value is 2.411e-07 < typical alpha value 0.05, we reject the null hypothesis, and conclude that the average body temperature is not 98.6 C")
hist(temperature, col = rainbow(3))




install.packages("faraway")
library(faraway)
data("prostate")
head(prostate)
dim(prostate)
attach(prostate)
t.test(age, mu = 65, alt = "less")
cat("Since the p-value is 0.06843, which is greater than the significance level of 0.05, we fail to reject the null hypothesis. This suggests that the average age is not significantly less than 65.")



Q3 = read.csv("C:\\Users\\PNW_checkout\\Downloads\\vaishak\\PNW_COURSE-WORK\\FALL24\\STATISTICAL COMPUTING\\Assignment\\Assignment 9\\NAPA.csv")
head(Q3)
dim(Q3)
length(Q3)
names(Q3)
attach(Q3)
length(Q3$Age[Age>50])
sum(Age > 50)
boxplot(Age~Gender, col = c(2,3), notch = TRUE)$out
t.test(Age~Gender, alt = "less")
cat("Since the p-value is less than 2.2e-16, which is much smaller than 0.05, we reject the null hypothesis. This suggests that the average age of males is significantly less than females.")

Male = subset(Q3, Gender == "M")
head(Male)
t.test(Male$Hours, mu = 4.361, alt = "less")
cat("Since the p-value is 4.707e-11, which is smaller than 0.05, we reject the null hypothesis. This suggests that the average hours for males is significantly less than 4.361.")

Female = subset(Q3, Gender == "F")
head(Female)
t.test(Female$Age, mu = 41.33, alt = "less")
cat("Since the p-value is 2.617e-11, which is smaller than 0.05, we reject the null hypothesis. This suggests that the average age of females is significantly less than 41.33.")



install.packages("MASS")
library(MASS)
data("birthwt")
head(birthwt)
names(birthwt)
dim(birthwt)
attach(birthwt)
# xtabs(~low+race)
table(low,race)
prop = c(23/96, 11/26, 25/67)
prop


Q5 = c(0.8, 0.8, 1.3, 1.5, 1.8, 1.9, 1.9, 2.1, 2.6, 2.7, 2.9, 3.1, 3.2, 3.3,  3.5, 3.6, 4.0, 4.1, 4.2, 4.2, 4.3, 4.3, 4.4, 4.4, 4.6, 4.7, 4.7, 4.8,  4.9, 4.9, 5, 5.3, 5.5, 5.7, 5.7, 6.1, 6.2, 6.2, 6.2, 6.3, 6.7, 6.9, 7.1, 7.1, 7.1, 7.1, 7.4, 7.6, 7.7, 8, 8.2, 8.6, 8.6, 8.6, 8.8, 8.8,  8.9,  8.9,  9.5,  9.6,  9.7,  9.8,  10.7,  10.9,  11,  11,  11.1,  11.2,  11.2, 11.5, 11.9, 12.4, 12.5, 12.9, 13, 13.1, 13.3, 13.6, 13.7,  13.9, 14.1, 15.4, 15.4, 17.3, 17.3, 18.1, 18.2, 18.4, 18.9, 19,  19.9, 20.6, 21.3, 21.4, 21.9, 23.0, 27, 31.6, 33.1, 38.5)
t.test(Q5)$conf.int
t.test(Q5, conf.level = 0.99)$conf.int
t.test(Q5, mu = 8, alt = "greater")
cat("Since the p-value is 0.005468, which is less than 0.05, we reject the null hypothesis and conclude that the true mean is significantly greater than 8.")



NS = c(18,22,21,17,20,17,23,20,22,21) 
S = c(16,20,14,21,20,18,13,15,17,21)
t.test(NS, S, alt = "greater")
cat("Since the p-value is 0.01899, which is less than 0.05, we reject the null hypothesis and conclude that the mean of NS is significantly greater than the mean of S.")


