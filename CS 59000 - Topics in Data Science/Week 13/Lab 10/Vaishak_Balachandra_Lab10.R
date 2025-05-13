### Lab 10 - Vaishak Balachandra

################################################################################

# Q1

# a

install.packages("palmerpenguins")
library(palmerpenguins)
data(penguins, package = "palmerpenguins")
head(penguins)
names(penguins)
dim(penguins)
cat("There are 344 rows and 8 columns in the penguins dataset!")

# b

# attach(penguins)
table(penguins$species)
cat("There are 3 different species in the penguins dataset namely:\n1. Adelie -- 152\n2. Chinstrap -- 68\n3. Gentoo -- 124")

# c

# Before, performing the LDA and QDA. Let's remove the NA values in the dataset, if any!!
sum(is.na(penguins))
cat("There are NA values in the penguin dataset")
clean_data = na.omit(penguins)
head(clean_data)
dim(clean_data)
cat("There are there are 11 such rows in the main dataset 'penguins', which has been removed!!")

attach(clean_data)
names(clean_data)
install.packages("MASS")
library(MASS)

################################################################################

# 1. Performing LDA

lda_penguins = lda(species~., data = clean_data)
lda_penguins
cat("Inference: LD1 accounts for 84.58% of the variance between the species groups. i.e., (LD1) is sufficient to capture most of the class separability in the data.")
plot(lda_penguins, col = c("red","green","blue")[as.integer(clean_data$species)])

# let's consider only numerical variables in the model

lda_numerical = lda(species~bill_length_mm+bill_depth_mm+flipper_length_mm+body_mass_g, data = clean_data)
lda_numerical
cat("Inference: LD1 accounts for 86.55% of the variance between the species groups. i.e., (LD1) is sufficient to capture most of the class separability in the data.")
plot(lda_numerical, col = c("red","green","blue")[as.integer(clean_data$species)])

# or

# install.packages("ggplot2")
library(ggplot2)
lda_pred <- predict(lda_penguins)
lda_df <- data.frame(species = clean_data[, "species"], LD1 = lda_pred$x[, 1], LD2 = lda_pred$x[, 2])
ggplot(lda_df) + geom_point(aes(x = LD1, y = LD2, color = species), size = 4) + theme_classic()

################################################################################

# 2. Performing QDA

library(MASS)
library(ggplot2)
# names(clean_data)

set.seed(037831852)
index <- sample(1:nrow(clean_data), 0.7 * nrow(clean_data))
train <- clean_data[index, ]
test <- clean_data[-index, ]

qda_numerical <- qda(species~bill_length_mm+bill_depth_mm+flipper_length_mm+body_mass_g, data = train)
qda_numerical

predicted <- predict(qda_numerical, test)

head(predicted$class)
head(predicted$posterior)

mean(predicted$class == test$species)
cat("Accuracy: 99%")

install.packages("klaR")
library(klaR)

partimat(species ~ bill_length_mm + bill_depth_mm + flipper_length_mm + body_mass_g, 
         data = train, method = "qda")

################################################################################