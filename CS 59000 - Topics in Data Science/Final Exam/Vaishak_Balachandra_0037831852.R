# Q1

install.packages("readxl")
library(readxl)
Q1 <- read_excel("Labor_data.xlsx")
head(Q1)
dim(Q1)
names(Q1)
attach(Q1)

# (a)	Fit a simple logistic regression model to describe the relationship between the inlf and the years of education. Please be sure to state the model equation
model = glm(inlf~educ, data = Q1, family = binomial)
summary(model)
cat("Fitted Simple Logistic Regression:
inlf = [1 + exp(1.85199 - 0.17398*educ)]^-1")

# (b)	Display the fitted logistic regression model using the probability curve.
plot(educ, inlf, main = "Scatter Plot of inlf against educ", pch = 17, col = "orange")
curve(predict(model, newdata = data.frame(educ = x), type = "response"), add = TRUE, col = "darkgreen", lwd = 2)

# (c)	Split the data-set with 70% training data and 30% test data. Please be sure to use set.seed  and use your PUID number for reproducibility of the results. 
set.seed(037831852)
train_indices <- sample(1:nrow(Q1), size = 0.7*nrow(Q1))
train_data <- Q1[train_indices, ]
test_data <- Q1[-train_indices, ]
# dim(train_data)
# dim(test_data)

# (d)	Fit a multiple logistic regression model using inlf as the outcome variable and all other variables as explanatory variables. Identify all significant variables.
model1 = glm(inlf~., data = train_data, family = binomial)
summary(model1)
cat("Significant Variables (alpha = 0.05): 
1. kidslt6 -- highly significant, 
2. age -- highly significant, 
3. educ -- highly significant, 
4. huseduc -- marginally significant")

# (e)	Create the confusion matrix to assess the classification accuracy (assume that probabilities exceeding  0.5 as predicted to be in the labor force based on your model)
pred <- predict(model1, newdata = test_data, type = "response")
predictions <- ifelse(pred > 0.5, 1, 0)
conf_matrix <- table(Predicted = predictions, Actual = test_data$inlf)
cat("Confusion Matrix: \n")
print(conf_matrix)
accuracy <- sum(diag(conf_matrix)) / sum(conf_matrix)
cat("Classification Accuracy: ", accuracy*100 , "%")
# or
install.packages("caret")
library(caret)
confusionMatrix(data = factor(predictions), reference = factor(test_data$inlf), positive = "1") 
cat("Classification Accuracy: 65.49%")

################################################################################

# Q2

Color = c("Red", "Red", "Red", "Blue", "Blue", "Blue", "Red", "Blue", "Red", "Red")
Size = c("Large", "Large", "Large", "Large", "Large", "Large", "Small", "Small", "Small", "Small")
Act = c("Stretch", "Stretch", "Dip", "Dip", "Stretch", "Dip", "Dip", "Dip", "Stretch", "Dip")
Age = c("Adult", "Child", "Child", "Adult", "Child", "Child", "Child", "Adult", "Child", "Adult")
Inflated = c("F", "T", "F", "T", "F", "F", "F", "T", "F", "T")

Q2 = data.frame(Color, Size, Act, Age, Inflated)
head(Q2)
dim(Q2)
names(Q2)
attach(Q2)

# (a)	Calculate the entropy of the inflated status.
# install.packages("DescTools")
library(DescTools)
Q2$Inflated <- factor(Q2$Inflated, levels = c("F", "T"))
entropy <- Entropy(table(Q2$Inflated), base = 2)
cat("Entropy of Inflated Variable:", entropy)
cat("INFERENCE: Indicates a high level of uncertainty!!")

# (b)	Identify the root node of the above data by calculating the information gain.  
# install.packages("FSelector")
library(FSelector)
info_gain <- information.gain(Inflated~., data = Q2)
print(info_gain)
cat("Seeing the importance of all the attribute
'AGE' can be the root node!!")

# (c)	Construct a decision tree for the subject data using R.
# install.packages("rpart")
# install.packages("rpart.plot")
library(rpart)
library(rpart.plot)

tree_model <- rpart(Inflated ~ ., data = Q2, method = "class", parms = list(split = "information"), control = rpart.control(cp = 0, minsplit = 2, minbucket = 1))
rpart.plot(tree_model, type = 4, extra = 101, main = "Decision Tree Plot", fallen.leaves = TRUE, cex = 0.55)


################################################################################

# Q3

# (a)	Access your dataset and print the jurisdiction (country, from which data were collected).
# install.packages("csranks")
library(csranks)
data("pisa2018")
head(pisa2018)
dim(pisa2018)
names(pisa2018)
# printing the jurisdiction
print(pisa2018$jurisdiction)

# (b)	Clean the dataset by removing the missing values.
sum(is.na(pisa2018))
cat("Has 2 NA values!!")
pisa_clean = na.omit(pisa2018)
dim(pisa_clean)

# (c)	Choose 25 countries at random using sample function. Please make sure you used your PUID to set the seed for reproducibility of your work. 
set.seed(037831852)
random_countries = sample(pisa_clean$jurisdiction, 25)
index = match(random_countries, pisa_clean$jurisdiction)
pisa_subset = pisa_clean[index,]
pisa_subset

# (d)	Extract the numerical variables (test scores) and standardize them. 
score_data <- scale(pisa_subset[, c("math_score", "reading_score", "science_score")])
score_data

# (e)	Perform the cluster analysis using the K-means clustering to identify the members in each clusters.
set.seed(037831852)
# install.packages("factoextra") 
library(factoextra) 
fviz_nbclust(score_data, kmeans, method="wss")
cat("Optimal Cluster Size from the Elbow plot: 3")
kmeans_model <- kmeans(score_data, centers = 3, nstart = 25)
kmeans_model
kmeans_model$size
cat("K-means clustering with 3 clusters of sizes '5 13 7'
i.e 5 - math_score
    13 - reading_score
    7 - science_Score")
# Contigency Table/Confusion Matrix: having 3 rows representing each cluster, and 1 - present, and 0 - absent
class = pisa_subset$jurisdiction
table(kmeans_model$cluster, class)
pisa_subset$cluster <- kmeans_model$cluster

# (f) Hierarchical clustering and dendrogram
distance_matrix <- dist(score_data)
hc <- hclust(distance_matrix)
plot(hc, main = "Cluster Dendrogram", xlab = "Jurisdiction", sub = "", labels = pisa_subset$jurisdiction)
# or
hc$labels <- as.character(pisa_subset$jurisdiction)
fviz_dend(hc, k = 3, cex = 0.6, k_colors = c("red", "darkblue", "darkgreen"), main = "Cluster Dendrogram", xlab = "Jurisdictions")

################################################################################


