########## Lab 6

################################################################################

# Q1
Q1 <- read.csv("Spider.csv")
head(Q1)
dim(Q1)
names(Q1)
attach(Q1)

Q1$Spiders = as.numeric(Q1$Spiders == "present")
head(Q1)

# a
model1 <- glm(Q1$Spiders~Q1$Grain.size, family = "binomial")
summary(model1)
cat("Logistic Fitted Model is:
Spiders = [1 + exp(1.648 - 5.122*Grain.Size)]^(-1)")

table(Q1$Spiders)
p = predict(model1, data = Q1, type = "response")
p
pp = ifelse(p>0.4, 1, 0)
pp

# b
install.packages("caret")
library(caret)
confusionMatrix(data = factor(pp), reference = factor(Q1$Spiders), positive = "1")
cat("Accuracy of the classification: 67.86%")

################################################################################

# Q2
Q2 <- read.csv("home.csv")
head(Q2)
dim(Q2)
names(Q2)
attach(Q2)

# a
model2 = glm(Sold~.,family= binomial , data = Q2)
summary(model2)
model2
cat("Multiple Logistic Fitted Model is:
Spiders = [1 + exp(3.222 + 0.001444*Living.Area - 0.0049*Age - 0.00001693*Price - 0.4805*Bedrooms + 0.01813*Bathrooms + 0.1253*Fireplaces)]^(-1)")


# b
p1 = predict(model2, type = 'response')
pp1 <- ifelse(p1 > 0.5, 1, 0)
library(caret)
confusionMatrix(data = factor(pp1), reference = factor(Q2$Sold), positive = "1")
cat("Accuracy of the model: 73.63%")
