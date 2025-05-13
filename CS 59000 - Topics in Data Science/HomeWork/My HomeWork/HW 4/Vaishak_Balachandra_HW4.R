#####################  HW-4  ####################################

#################################################################

# Q1

ID <- c('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T' )
Age <- c(18, 21, 22, 24, 26, 26, 27, 30, 31, 35, 39, 40, 41, 42, 44, 46, 47, 48, 49, 54)
Spend <- c(10, 11, 22, 15, 12, 13, 14, 33, 39, 37, 44, 27, 29, 20, 28, 21, 30, 31, 23, 24)
Q1 <- data.frame(ID, Age, Spend)
head(Q1)
dim(Q1)
names(Q1)

set.seed(037831852)
kmeans_m1 <- kmeans(Q1[ , 2:3], centers = 3)
kmeans_m1$cluster
kmeans_m1$centers
kmeans_m1$size
cat("Therefore, using 3 centered K-MEANS Clustering, we got 3 clusters: 
2  5 13")

install.packages("factoextra")
library(factoextra)
rownames(Q1) <- Q1[, 1]
# or 
# rownames(Q1) <- Q1$ID
fviz_cluster(kmeans_m1, data=Q1[ , 2:3], main = "K-means Clustering with 3 Clusters", geom = "text", labelsize = 1.5)
# also Dendogram splits
split(Q1$ID, kmeans_m1$cluster)

#################################################################

# Q2

data("USArrests")
head(USArrests)
Q2 <- USArrests
head(Q2)
dim(Q2)
names(Q2)
attach(Q2)
length(rownames(Q2))
cat("There are 50 states considered in the dataset")

# a

summary(Q2)

# b

# Since given to perform kmeans with similar rate -> meaning perform normalization before using the actual data
Q2_normalized <- scale(Q2)
head(Q2_normalized)

install.packages("factoextra")
library(factoextra)
fviz_nbclust(Q2_normalized, kmeans, method = "wss")
cat("From the plot, centeres = k = 6, looks like a fair consideration for kmeans clustering!
REASON: After k=6, the curve flattens, and do not give any additional information")

set.seed(037831852)
kmeans_m2 <- kmeans(Q2_normalized, centers = 6)
kmeans_m2$cluster

fviz_cluster(kmeans_m2, data=Q2_normalized, main = "K-means Clustering with 6 Clusters", geom = "point", labelsize = 1.5)
# also Dendogram splits
split(rownames(Q2), kmeans_m2$cluster)

# c

# Performing Heirarchial Clustering
d2 = dist(Q2_normalized)
hc2 <- hclust(d2)
plot(hc2, main = "Heirarchial Clustering for USArrests data", labels = rownames(Q2), cex = 0.5)
rect.hclust(hc2, k = 6, border = "red")

#################################################################

# Q3

# a

install.packages("palmerpenguins")
library(palmerpenguins)
data(penguins, package = "palmerpenguins")
Q3 <- penguins
head(Q3)
dim(Q3)

# b

sum(is.na(Q3))
Q3_clean <- na.omit(Q3)
head(Q3_clean)
dim(Q3_clean)

# c

set.seed(037831852)
i  = sample(nrow(Q3_clean), 50)
Q3_50 <- Q3_clean[i,]
head(Q3_50)
dim(Q3_50)
names(Q3_50)

# d

# extracting the numerical data (EXCLUDING YEAR COLUMN)
data3_numerical_columns <- Q3_50[,c(3,4,5,6)]

# Standardizing using Zscore
Q3_normalized <- scale(data3_numerical_columns)
head(Q3_normalized)
 

# e

library(factoextra)
fviz_nbclust(Q3_normalized, kmeans, method = "wss")
cat("From the plot, centeres = k = 4, looks like a fair consideration for kmeans clustering!
REASON: After k=3, the curve flattens, and do not give any additional information")

set.seed(037831852)
kmeans_m3 <- kmeans(Q3_normalized, centers = 3)
kmeans_m3$cluster

fviz_cluster(kmeans_m3, data=Q3_normalized, main = "K-means Clustering with 3 Clusters", geom = "point", labelsize = 1.5)
# also Dendogram splits
split(Q3_50$species, kmeans_m3$cluster)

# also

# Performing Heirarchial Clustering
d3 = dist(Q3_normalized)
hc3 <- hclust(d3)
plot(hc3, main = "Heirarchial Clustering for Penguin data", labels = Q3_50$species  ,cex = 0.5)
rect.hclust(hc3, k = 3, border = "red")

#################################################################

# Q4

# a

Q4 <- read.csv("diabetes.csv")
head(Q4)
dim(Q4)
names(Q4)

# b

install.packages("caret")
library(caret)
set.seed(037831852)
train_index <- createDataPartition(Q4$class, p=0.7, list = FALSE)
train <- Q4[train_index,]
test <- Q4[-train_index,]
# dim(Q4)
# dim(train)
# dim(test)

# c

install.packages("rpart")
library(rpart)
install.packages("rpart.plot")
library(rpart.plot)

tree_model4 <- rpart(train$class~., data = train, method = "class")
tree_model4

plot(tree_model4)
text(tree_model4, use.n = TRUE, cex = 0.7, col = "red") 

printcp(tree_model4)
plotcp(tree_model4)

rpart.plot(tree_model4, type = 2, extra = 101, tweak = 1, box.palette = "skyblue")

# d

actual_class <- test$class
actual_class

predicted = predict(tree_model4, test)
predicted
predicted_class <- ifelse(predicted[, "Positive"] > 0.5, "Positive", "Negative")
predicted_class

# confusion matrix
conf_matrix <- table(Predicted = predicted_class, Actual = actual_class)
conf_matrix

# Accuracy
accuracy <- sum(predicted_class == actual_class) / length(actual_class)
accuracy
cat("Accuracy: 89.10%")

#################################################################




