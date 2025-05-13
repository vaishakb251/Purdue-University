# q1

q1 <- read.csv("q1.csv")
head(q1)
names(q1)
attach(q1)

# a
p = table(Result)
install.packages("DescTools")
library(DescTools)
Entropy(p)
cat("The entropy value of 0.9967 indicates a relatively high level of uncertainty in the Result variable")

# b
Ent_Result = Entropy(table(Result))
Ent_Result

Ent_Result_Course <- sum(prop.table(table(q1$Course)) * sapply(unique(q1$Course), function(x) Entropy(table(q1$Result[q1$Course == x]))))
Ent_Result_Background <- sum(prop.table(table(q1$Background)) * sapply(unique(q1$Background), function(x) Entropy(table(q1$Result[q1$Background == x]))))
Ent_Result_Working <- sum(prop.table(table(q1$Working)) * sapply(unique(q1$Working), function(x) Entropy(table(q1$Result[q1$Working == x]))))

IG_Result_Course = Ent_Result - Ent_Result_Course
IG_Result_Background = Ent_Result - Ent_Result_Background
IG_Result_Working = Ent_Result - Ent_Result_Working

cat("Information gain:
1. Course:" , IG_Result_Course, 
"\n2. Background:", IG_Result_Background, 
"\n3. Working:", IG_Result_Working)

cat("Thus, here 'Course' is the root node!!")

# c
install.packages("rpart")
library("rpart")
install.packages("rpart.plot")
library("rpart.plot")

model <- rpart(Result ~ Course + Background + Working, data = q1, method = "class", 
               control = rpart.control(cp = 0, minsplit = 2, minbucket = 1))
rpart.plot(model, type = 2, extra = 101, box.palette = "Blues")

######################################################################################

# q2

# a
data("OJ", package = "ISLR")
head(OJ)
dim(OJ)
# Variable Names:
names(OJ)
attach(OJ)

# b
install.packages("caret")
library(caret)
set.seed(037831852)  
train_index <- sample(1:nrow(OJ), 800, replace = FALSE)  
train_set <- OJ[train_index, ]  
test_set <- OJ[-train_index, ]  
dim(train_set)
dim(test_set)

# c
install.packages("rpart")
library(rpart)
tree_model <- rpart(Purchase ~ ., data = train_set, method = "class")
summary(tree_model)

cat("Root node: error rate = 0.39375", "\n",
    "Most important variable: LoyalCH", "\n",
    "Best first split: LoyalCH < 0.48285")

sum(tree_model$frame$var == "<leaf>")
cat("There are 6 leaf/terminal nodes in the Tree")

# d
install.packages("rpart")
library(rpart)
install.packages("rpart.plot")
library(rpart.plot)
# ?rpart.plot
rpart.plot(tree_model, extra = 101, cex = 0.65)
cat("Inference: LoyalCH is the strongest predictor")

# e
install.packages("rpart")
library(rpart)
install.packages("caret")
library(caret)
predictions <- predict(tree_model, test_set, type = "class")

conf_matrix <- table(Predicted = predictions, Actual = test_set$Purchase)
conf_matrix
test_error_rate <- 1 - sum(diag(conf_matrix)) / sum(conf_matrix)
# or
# (28+14)/(140+14+28+88)
cat("Test Error rate: ", test_error_rate)

# f
install.packages("tree")
library(tree)
set.seed(037831852)
tree_model_tree <- tree(Purchase ~ ., data = train_set)
cv_results <- cv.tree(tree_model_tree, FUN = prune.tree)
optimal_size <- cv_results$size[which.min(cv_results$dev)]
a = list(cv_results = cv_results, optimal_size = optimal_size)
cat("Optimal Size:", a$optimal_size)
