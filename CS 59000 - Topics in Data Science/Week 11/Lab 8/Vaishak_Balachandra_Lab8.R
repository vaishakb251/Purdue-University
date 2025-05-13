# 1

# a
install.packages("rpart")
library(rpart)
data(cu.summary, package = "rpart")
data = cu.summary
head(data)
names(data)
attach(data)

# b
install.packages("ISLR")
library(ISLR)
install.packages("tree")
library(tree)
install.packages("rpart.plot")
library(rpart.plot)

tree_model = rpart(Mileage ~ Price + Country + Reliability + Type, data = data, method = "anova", cp = 0)
tree_model
cat("Thus, there are 5 terminals in tree.")

plot(tree_model)
text(tree_model, col = "blue", minlength = 2L, cex = 0.5)
printcp(tree_model)
plotcp(tree_model)
?rpart.plot
rpart.plot(tree_model, extra = 101)


#################################################################################

# 2

# a
dat <- read.csv("C:/Users/PNW_checkout/Downloads/sem 2/0. Coursework/0. Coursework/Data science/Lab/Lab 8/ispy1doctored.csv")
head(dat)
dim(dat)
names(dat)

# b
hist(dat$MRI_LD_Tfinal, main = "*** Histogram of MRI_LD_TFinal ***", col = rainbow(7), xlab = "MRI_LD_TFinal", col.main = "orange", col.lab = "darkgreen", ylim = c(0,50))
box()

# c
set.seed(0037831852)
index <- sample(1:nrow(dat), 70)
train_dat <- dat[index,]
test_dat <- dat[-index,]
dim(dat)
dim(train_dat)
dim(test_dat)

# d
install.packages("rpart")
library(rpart)
install.packages("rpart.plot")
library(rpart.plot)
model_tree <- rpart(train_dat$MRI_LD_Tfinal~., data = train_dat, method = "anova")
model_tree

# e
plot(model_tree)
text(model_tree, use.n = TRUE, cex = 0.7, col = "red")

printcp(model_tree)
plotcp(model_tree)

# or
rpart.plot(model_tree, box.palette = "orange")

# install.packages("rattle")
# library(rattle)
# fancyRpartPlot(model_tree)
# ?fancyRpartPlot

# extra 
predicted = predict(model_tree, test_dat, type = "vector")
# print(predicted)
actual = test_dat$MRI_LD_Tfinal

MAE = sum(abs(predicted - actual))/length(actual)
MAE
# VALUE of MAE can be analysed, only by comparison
