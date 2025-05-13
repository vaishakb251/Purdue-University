################################################################################

# MIDTERM - VAISHAK BALACHANDRA - 0037831852

################################################################################

# 1

# a
Q1 <- read.table("C:/Users/PNW_checkout/Downloads/sem 2/0. Coursework/0. Coursework/Data science/Vaishak_Balachandra_Midterm/MidterrmQ1.txt", header = T)
head(Q1)
dim(Q1)
names(Q1)
attach(Q1)
cat("109 mens are included in the given dataset")


# b
plot(X,Y, main = "Scatterplot of Y against X", pch = 17, col = "maroon", col.main = "orange", col.lab = "darkgreen", xlab = "Waist circumference (cm)", ylab = "Deep Abdominal AT")
model1 <- lm(Y~X)
model1
cat("Linear Fitted Model Equation:
Y = -215.981 + 3.459*X
AT = -215.981 + 3.459*Waist")
abline(model1, lwd = 2, col = "purple")

# c
summary(model1)
cat("Coefficient of Determination (R squared value) = 0.67 = 67%")
cat("Inference: It means only 67% of the variability in Y(AT) is defined by X(Waist Circumference)")

# d
predict(model1, data.frame(X = 105))
cat("Here, For the waist circumference equals to 105cm, the AT is found to be 147.1987")

# e
predict(model1, data.frame(X = 105), interval = "confidence", level = 0.9)
cat("Confidence Interval: [139.8762, 154.5213]")
predict(model1, data.frame(X = 105), interval = "pred", level = 0.9)
cat("Confidence Interval: [91.85026, 202.5472]")

################################################################################

# 2

# a
install.packages("readxl")
library(readxl)
Q2 <- read_excel("Passangers.xlsx")
head(Q2)
dim(Q2)
names(Q2)
attach(Q2)

model2 <- glm(Survived~Age+Speed, family = "binomial")
model2
cat("Logistic Fitted Model Equation:
Survived = [1 + exp(-7.56052 - 0.05207*Age + 0.14679*Speed)]^(-1)")

# b
predict(model2, data.frame(Age= 35, Speed = 80), type = "response")
cat("Probability that a 35-year-old passenger will survive if there was a crash of a car speeding at 80mph is: 0.08625105 = 8.625105%")

################################################################################

# 3

# a
Q3_initial <- read.csv("Credit_data.csv")
head(Q3_initial)
dim(Q3_initial)
names(Q3_initial)
attach(Q3_initial)

# Since, my PUID ends with 2 <5, I'm choosing the first 15000 rows
Q3 <- Q3_initial[1:15000, ]
dim(Q3)

# b
plot(Q3$BILL_AMT1, Q3$MISSED_PAYMENT, pch = "x", col = "maroon",main = "Scatterplot of Missed Payment against Bill Amnt 1", col.main = "orange", col.lab = "red", cex = 0.75, xlab = "Bill Amount 1", ylab = "Missed Payment")
model3 <- glm(MISSED_PAYMENT ~ BILL_AMT1, data = Q3, family = "binomial")
summary(model3)
cat("Logistic Fitted Model Equation: MISSED_PAYMENT = [1 + exp(-(1.202 + 0.0000006967*BILL_AMT1))]^(-1)")
curve(predict(model3, newdata = data.frame(BILL_AMT1 = x), type = "response"), col = "blue", add = TRUE)


# c
# summary(model3)
p = predict(model3, data = Q3, type = 'response')
pp =ifelse(p > 0.5, 1, 0)
# install.packages("caret")
library(caret)
confusionMatrix(data = factor(pp), reference = factor(Q3$MISSED_PAYMENT), positive = "1")
cat("Accuracy = 0.7749 = 77.49%")

# d
names(Q3)
model3a <- glm(MISSED_PAYMENT~., family = "binomial", data = Q3)
model3a

p1 = predict(model3a, data = Q3, type = 'response')
pp1 =ifelse(p1 > 0.5, 1, 0)
library(caret)
confusionMatrix(data = factor(pp1), reference = factor(Q3$MISSED_PAYMENT), positive = "1")
cat("Accuracy = 0.8015 = 80.15%")

cat("The curve in the plot appears like a stright line, as the effect size of BILL_AMT1 on the probability of missed payment is very small (i.e., coefficient is 0.0000006967), meaning the relationship is weak.")

################################################################################

# 4

# a
library(readxl)
Q4 <- read_excel("program_data.xlsx")
head(Q4)
names(Q4)
dim(Q4)

set.seed(2467)
rnum <- sample(1:nrow(Q4))
Q4 <- Q4[rnum,]

Q4$ses <- as.numeric(as.factor(Q4$ses))
prog_factor <- as.factor(Q4$prog)

# min-max normalization
normalize <- function(x){
  return ((x-min(x))/(max(x)-min(x)))
}

Q4_norm <- as.data.frame(lapply(Q4[,c("ses", "read", "write", "math", "science", "socst")], normalize))
head(Q4_norm)

# Splitting the dataset
set.seed(2467)
train_index <- sample(1:nrow(Q4_norm), 0.8 * nrow(Q4_norm))
train_data <- Q4_norm[train_index,]
test_data <- Q4_norm[-train_index,]
train_labels <- prog_factor[train_index]
test_labels <- prog_factor[-train_index]

# To find optimum k value
set.seed(2467)
k_values <- 10:20
accuracies <- numeric(length(k_values))

for(i in 1:length(k_values)) {
  knn_pred <- knn(train = train_data, test = test_data, cl = train_labels, k = k_values[i])
  accuracies[i] <- sum(knn_pred == test_labels) / length(test_labels)
}

plot(k_values, accuracies, type="b", xlab="k", ylab="Accuracy", main="Accuracy for Different k Values")
cat("Best k:", 15)

# b
library(class)
knn_pred <- knn(train = train_data, test = test_data, cl = train_labels, k = 15)
confusion_matrix <- table(Predicted = knn_pred, Actual = test_labels)
print(confusion_matrix)
accuracy <- sum(knn_pred == test_labels) / length(test_labels)
cat("Accuracy: 66.67%")

#################################################################################


