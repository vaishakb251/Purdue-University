########## Homework 2

################################################################################

#### Q1

# a -- Eucledian
A = c(1,1,7)
B = c(2,9,5)
C = c(9,6,3)
D = c(3,5,7)
Q1 <- rbind(A,B,C,D)
Q1

cat("Euclidean Distances between the points are given by:")
eucl_distance = dist(Q1, method = "euclidean")
# or
# install.packages("philentropy")
# library(philentropy)
# eucl_distance = distance(Q1, method = 'euclidean')
eucl_distance
# 
# Euclidean Distance between A and B is 8.306624 units
# Euclidean Distance between A and C is 10.246951 units
# Euclidean Distance between A and D is 4.472136 units
# Euclidean Distance between B and C is 7.874008 units
# Euclidean Distance between B and D is 4.582576 units
# Euclidean Distance between C and D is 7.280110 units

# b -- Manhattan
cat("Manhattan Distances between the points are given by:")
manhattan_distance = dist(Q1, method = "manhattan")
# or
# manhattan_distance = distance(Q1, method = "manhattan")
manhattan_distance
# 
# Manhattan Distance between A and B is 11 units
# Manhattan Distance between A and C is 17 units
# Manhattan Distance between A and D is 6 units
# Manhattan Distance between B and C is 12 units
# Manhattan Distance between B and D is 7 units
# Manhattan Distance between C and D is 11 units

################################################################################

#### Q2

# a
data(mtcars)
head(mtcars)
names(mtcars)
dim(mtcars)

Q2 <- mtcars[,1]
Q2
length(Q2)

cat("Zscore representation of the mpg's are given by:")
zscore <- scale(Q2)
zscore

# b
cat("Min-Max(0,1) representation of the mpg's are given by:")
install.packages("scales")
library(scales)
min_max_score <- rescale(Q2)
# or
# min_max_score <- scale(Q2, center = min(Q2), scale = max(Q2) - min(Q2))
min_max_score

################################################################################

#### Q3

# a
Q3 <- read.table("https://users.stat.ufl.edu/~winner/data/nuclear_time.dat")
head(Q3,5)
names(Q3) = c("Task","Nationality","Time_to_Complete","TACOM_Complexity_Score")
head(Q3,5)
attach(Q3)

# b
boxplot(Time_to_Complete~Nationality, main = "Boxplot of Time to Complete based on Nationality", xlab = "Nationality (1= US, 0= non-US)", ylab = "Time to Complete", col = c(5,12), col.main = "orange", col.lab = "purple")

# c
t.test(Time_to_Complete~Nationality)
cat("Here, the pvalue = 0.0003475, which is less than 0.05. Thus, we reject the null hypothesis and conclude that there is a significant difference in the time to complete the task between the US and the non-US individuals.")

################################################################################

#### Q4

# a
Q4 <- read.table("https://jse.amstat.org/datasets/diamond.dat.txt")
head(Q4)

# b
colnames(Q4) = c("Size","Price")
head(Q4)
attach(Q4)

# c
plot(Size, Price, main = "Prize against Size", pch = 17, col = 2, cex = 1.5, xlab = "Size(in carats)", ylab = "Prize(in Singapore Dollar)", col.lab = "orange", col.main = "maroon", ylim = c(100, 1250))

# d
model = lm(Price~Size)
model
abline(model, lwd = 2, col = "green")
cat("Fitted Model:
Price = -259.6 + 3721*Size")

# e
summary(model)
cat("Here, the pvalue = 2.2e-16, which is less than 0.05. Thus we reject the null hypothesis, and conclude that the size of the diamond (in carats) has a significant positive relationship with its price.")


# f
predict(model, data.frame(Size = 0.24))
cat("For 0.24 carat, the predicted Price is 633.4201 Singaporean Dollar")
predict(model, data.frame(Size = 0.24), interval = "confidence", level = 0.95)
cat("95% Confidence Interval: for 0.24 carat, the predicted price lies in [622.4484, 644.3917]")
predict(model, data.frame(Size = 0.24), interval = "prediction", level = 0.95)
cat("95% Prediction Interval: for 0.24 carat, the predicted price lies in [568.3961, 698.444]")

################################################################################

