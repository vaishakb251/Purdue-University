# Lab 9

# 1

# a
install.packages("palmerpenguins")
library(palmerpenguins)
data(penguins, package = "palmerpenguins")
head(penguins)
dim(penguins)

# b
names(penguins)
attach(penguins)
table(species)
cat("There are 3 species of penguins in the given dataset")

# c
new = penguins[,c(1,3,5)]
head(new)
dim(new)
names(new)
cleandata <- na.omit(new)
head(cleandata)
dim(cleandata)

# also
needed_data <- cleandata[,c(2,3)]
head(needed_data)
dim(needed_data)
class = cleandata$species
head(class)
length(class)
class

# d
data1 <- scale(needed_data)
head(data1)



# e
install.packages("factoextra")
library(factoextra)
fviz_nbclust(data1, kmeans, method="wss")
cat("From the plot, 3 or 4 is the best cluster count")

# f
result = kmeans(data1,3)
result$size
result
cat("For 3 clusters: 127 151  64")

result1 = kmeans(data1,4)
result1$size
result1
cat("For 4 clusters: 41 116 116  69")

# g
# For 3 clusters
result$centers
result$cluster
result$size

# # For 4 clusters
# result1$centers
# result1$cluster
# result1$size

# h
result$cluster
length(result$cluster)
table(result$cluster, class)
table(class)
