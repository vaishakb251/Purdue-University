# Q1
Q1 <- read.csv("Q1.csv")
head(Q1)
names(Q1)
names(Q1) = c("Height","Weight","Size")
dim(Q1)
attach(Q1)

set.seed(111)

# install.packages("e1071")
library(e1071)
index = createDataPartition(Q1$Size, p = 0.7, list = F)

train = Q1[index, -3] # except the label, choosing the rest rows in index
test = Q1[-index,-3]

train_label = Q1[index,3]
test_label = Q1[-index, 3]

# install.packages("class")
library(class)
pred = knn(train = train, test = test, cl = train_label, k = 5)
pred

table(test_label, pred)

# install.packages("gmodels")
library(gmodels)
CrossTable(x = test_label, y = pred, prop.chisq = F)

confusionMatrix(reference=factor(test_label), data = pred)

# Accuracy: 100%
# Sensitivity = 100%        
# Specificity = 100%
                