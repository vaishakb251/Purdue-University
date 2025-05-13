##### --- 1. Loading and Preparing the Data ---

## Loading necessary packages 
install.packages(c("rpart", "rpart.plot", "cluster", "factoextra", "corrplot", "caret", "ROSE", "DMwR2","ggplot2"))
library(rpart)
library(rpart.plot)
library(cluster)
library(ggplot2)
library(factoextra)
library(corrplot)
library(caret)
library(ROSE)    # For handling class imbalance
library(DMwR2)    # For SMOTE implementation

## Reading the data
data <- read.csv("bank-full.csv", sep=";")
head(data, 5)

##### Exploratory Data Analysis (EDA)

## Dataset dimensions
print("Dataset dimensions:")
dim(data)

## Column names and structure
print("Column names:")
names(data)

print("Structure of the data:")
str(data)

## Summary statistics
print("Summary statistics:")
summary(data)

## Check for missing values
missing_values <- colSums(is.na(data))
print("Missing values in each column:")
print(missing_values)
print("So, no columns with NA values!!")

## Distribution of the target variable
print("Distribution of term deposit subscriptions:")
table(data$y)
subscription_percent <- prop.table(table(data$y)) * 100
print(paste("Percentage of 'yes':", round(subscription_percent["yes"], 2), "%"))
print(paste("Percentage of 'no':", round(subscription_percent["no"], 2), "%"))

# Print class imbalance ratio
imbalance_ratio <- subscription_percent["no"] / subscription_percent["yes"]
print(paste("Class imbalance ratio (no:yes):", round(imbalance_ratio, 2), ":1"))

##### --- 3. Data Visualization ---

## Target variable distribution
barplot(table(data$y), 
        main="Term Deposit Subscription (Output variable)", 
        xlab="Subscribed", 
        col=c("red", "green"), 
        names.arg=c("No", "Yes"),
        ylim = c(0,50000))
box()
# table(data$y)
cat("Only 11.6% of the customers agreed to opt term deposit subscription!")

## Age distribution
hist(data$age, 
     main="Distribution of Customer Age", 
     xlab="Age", 
     col="skyblue", 
     border="white")
cat("Insights: Majority of the customers were aged between 25-40 years")

## Balance distribution (with outlier handling for better visualization)
# table(data$balance)

balance <- data$balance
threshold <- quantile(balance, 0.95)
filtered_balance <- balance[balance <= threshold]

neg <- filtered_balance[filtered_balance < 0]
pos <- filtered_balance[filtered_balance >= 0]

neg_hist <- hist(neg, plot = FALSE, breaks = 30)
pos_hist <- hist(pos, plot = FALSE, breaks = 30)

plot(pos_hist, col = rgb(0.2, 0.9, 0.2, 0.6), xlim = range(c(neg_hist$breaks, pos_hist$breaks)), 
     ylim = c(-max(neg_hist$counts), max(pos_hist$counts)), 
     main = "Account Balance Distribution (95th percentile)", xlab = "Balance (euros)", ylab = "Frequency")

# Add negative bars flipped downward
for (i in 1:length(neg_hist$counts)) {
  rect(neg_hist$breaks[i], 0, neg_hist$breaks[i+1], -neg_hist$counts[i],
       col = rgb(0.2, 0.9, 0.2, 0.6), border = "black")
}
cat("Insights: Most of the customers reached out have a positive account balance")
box()

## Campaign contacts distribution
campaign_cutoff <- quantile(data$campaign, 0.95)
campaign_to_plot <- subset(data$campaign, data$campaign <= campaign_cutoff)
hist(campaign_to_plot, 
     main="Distribution of Campaign Contacts (95th percentile)", 
     xlab="Number of contacts", 
     col="coral", 
     border="white", 
     ylim = c(0,20000))
cat("Around 66.46% of the customers have been contacted less than or equal to twice during the campaign")
box()

## Job type distribution with % labels and improved layout
job_counts <- table(data$job)
job_percent <- round(100 * job_counts / sum(job_counts), 1)


par(mar = c(10, 4, 4, 2) + 0.1)  # Bottom margin for labels


bar_positions <- barplot(job_counts, 
                         main = "Distribution by Job Type",
                         col = "lightgreen", 
                         las = 2,    # Rotate labels vertically
                         ylim = c(0, max(job_counts) * 1.4))  # Extra space for text

# Add percentage labels above bars
text(x = bar_positions, 
     y = job_counts, 
     labels = paste0(job_percent, "%"), 
     pos = 3, cex = 0.8)
cat("Most common job category of the customers are: Blue-collar, Management and Technician")
box()

## Education level distribution
education_counts <- table(data$education)
barplot(education_counts, 
        main="Distribution by Education Level", 
        xlab="Education", 
        col="lightgreen",
        ylim = c(0,25000))
box()

# pie chart
education_counts <- table(data$education)
percent_labels <- paste(names(education_counts), 
                        round(100 * education_counts / sum(education_counts), 1), "%")

pie(education_counts, 
    labels = percent_labels, 
    main = "Education Level Distribution", 
    col = rainbow(length(education_counts)),
    cex = 0.7,
    cex.main = 0.8)
cat("51.3% of the customers have secondary education!")
box()

## Month of last contact
month_order <- c("jan","feb","mar","apr","may","jun","jul","aug","sep","oct","nov","dec")
data$month <- factor(data$month, levels=month_order)
month_counts <- table(data$month)
barplot(month_counts, 
        main="Distribution by Month of Last Contact", 
        xlab="Month", 
        col="coral",
        ylim = c(0,15000),
        las = 2)
cat("More customers were contacted in May than in any other month. \nSo, summer time is the time, where most of the last contacts were made!!")
box()

# Correlation matrix for numeric variables
numeric_cols <- sapply(data, is.numeric)
numeric_data <- data[, numeric_cols]
cor_matrix <- cor(numeric_data)
corrplot(cor_matrix, 
         method="color", 
         type="upper", 
         tl.col="black", 
         tl.srt=90,
         tl.cex = 0.7,
         addCoef.col="black",
         number.cex=0.7,
         main="Correlation Matrix of Numeric Variables")
cat("Large Independency is observed in the dataset!!")

# Cross-tabulations with the target variable

cat("\n--- Subscription Rate by Job Type ---\n")
job_subscription_table <- table(data$job, data$y)
job_subscription_rates <- round(prop.table(job_subscription_table, 1)[,"yes"] * 100, 2)
job_subscription_df <- data.frame(
  Job = names(job_subscription_rates),
  Subscription_Rate = job_subscription_rates
)
job_subscription_df <- job_subscription_df[order(-job_subscription_df$Subscription_Rate),]
print(job_subscription_df)

mosaicplot(job_subscription_table,
           main="Mosaic Plot: Job vs Subscription",
           xlab="Job", ylab="Subscription",
           las=2, col=c("lightblue", "coral"))

cat("\n--- Subscription Rate by Education Level ---\n")
edu_subscription_table <- table(data$education, data$y)
edu_subscription_rates <- round(prop.table(edu_subscription_table, 1)[,"yes"] * 100, 2)
print(edu_subscription_rates)

mosaicplot(edu_subscription_table,
           main="Mosaic Plot: Education vs Subscription",
           xlab="Education", ylab="Subscription",
           las=2, col=c("lightgreen", "salmon"))

cat("\n--- Subscription Rate by Marital Status ---\n")
marital_subscription_table <- table(data$marital, data$y)
marital_subscription_rates <- round(prop.table(marital_subscription_table, 1)[,"yes"] * 100, 2)
print(marital_subscription_rates)

mosaicplot(marital_subscription_table,
           main="Mosaic Plot: Marital Status vs Subscription",
           xlab="Marital Status", ylab="Subscription",
           las=2, col=c("skyblue", "tomato"))

cat("\n--- Subscription Rate by Previous Marketing Outcome ---\n")
poutcome_subscription_table <- table(data$poutcome, data$y)
poutcome_subscription_rates <- round(prop.table(poutcome_subscription_table, 1)[,"yes"] * 100, 2)
print(poutcome_subscription_rates)

mosaicplot(poutcome_subscription_table,
           main="Mosaic Plot: Previous Outcome vs Subscription",
           xlab="Previous Outcome", ylab="Subscription",
           las=2, col=c("plum", "darkorange"))


# --- 4. Data Preparation for Modeling ---

# names(data)
# Convert categorical variables to factors
categorical_vars <- c("job", "marital", "education", "default", "housing", 
                      "loan", "contact", "month", "poutcome", "y")
data[categorical_vars] <- lapply(data[categorical_vars], as.factor)

# Encoding target variable to numeric for some analyses
data$y_numeric <- as.numeric(data$y == "yes")

# Split data into training (70%) and testing (30%) sets
set.seed(123)  # For reproducibility
sample_size <- floor(0.7 * nrow(data))
train_indices <- sample(seq_len(nrow(data)), size = sample_size)

train_data <- data[train_indices, ]
test_data <- data[-train_indices, ]

# Check class imbalance in training set
print("Class distribution in training set:")
table(train_data$y)

train_imbalance <- prop.table(table(train_data$y)) * 100
print(paste("Training set - Yes:", round(train_imbalance["yes"], 2), "%, No:", round(train_imbalance["no"], 2), "%"))



# SECTION 4.5

# Ensure the target variable is a factor
train_data$y <- as.factor(train_data$y)

# ------------------------
# Method 1: ROSE (Random Over-Sampling Examples)
# ------------------------
library(ROSE)
set.seed(123)
rose_train <- ROSE(y ~ ., data = train_data, seed = 123)$data

cat("ROSE class distribution:\n")
print(table(rose_train$y))

# ------------------------
# Method 2: Random Undersampling
# ------------------------
set.seed(123)
yes_idx <- which(train_data$y == "yes")
no_idx <- which(train_data$y == "no")
no_keep <- min(length(no_idx), length(yes_idx) * 2)

undersampled_train <- train_data[c(yes_idx, sample(no_idx, no_keep)), ]

cat("Undersampling class distribution:\n")
print(table(undersampled_train$y))






# --- 5. Decision Tree Model (Supervised Learning) ---

# Function to build and evaluate decision tree
evaluate_dt <- function(train_set, test_set, dataset_name) {
  print(paste("Building decision tree using", dataset_name))
  
  # Build the decision tree model
  dt_model <- rpart(y ~ age + job + marital + education + default + balance + 
                      housing + loan + contact + month + duration + campaign + 
                      pdays + previous + poutcome,
                    data = train_set,
                    method = "class",
                    control = rpart.control(cp = 0.001, minbucket = 20))
  
  # Prune the tree to prevent overfitting
  cp_optimal <- dt_model$cptable[which.min(dt_model$cptable[,"xerror"]),"CP"]
  dt_model_pruned <- prune(dt_model, cp = cp_optimal)
  
  # Plot the decision tree
  rpart.plot(dt_model_pruned, 
             extra = 104,  # Show fitted values and percentages
             box.palette = "RdBu",
             shadow.col = "gray",
             nn = TRUE,  # Show node numbers
             main = paste("Decision Tree -", dataset_name))
  
  # Evaluate the decision tree on test data
  dt_predictions <- predict(dt_model_pruned, test_set, type = "class")
  dt_confusion_matrix <- table(Predicted = dt_predictions, Actual = test_set$y)
  print(paste("Decision Tree Confusion Matrix for", dataset_name, ":"))
  print(dt_confusion_matrix)
  
  # Calculate performance metrics
  dt_accuracy <- sum(diag(dt_confusion_matrix)) / sum(dt_confusion_matrix)
  
  # Handle the case where some classes might be missing in the predictions
  if (dim(dt_confusion_matrix)[1] < 2 || dim(dt_confusion_matrix)[2] < 2) {
    dt_precision <- dt_recall <- dt_f1 <- NA
  } else {
    dt_precision <- dt_confusion_matrix[2,2] / sum(dt_confusion_matrix[2,])
    dt_recall <- dt_confusion_matrix[2,2] / sum(dt_confusion_matrix[,2])
    dt_f1 <- 2 * dt_precision * dt_recall / (dt_precision + dt_recall)
  }
  
  print(paste("Decision Tree Accuracy:", round(dt_accuracy, 4)))
  print(paste("Decision Tree Precision:", round(dt_precision, 4)))
  print(paste("Decision Tree Recall:", round(dt_recall, 4)))
  print(paste("Decision Tree F1 Score:", round(dt_f1, 4)))
  
  # Variable importance
  dt_var_importance <- dt_model_pruned$variable.importance
  if (length(dt_var_importance) > 0) {
    dt_var_importance_df <- data.frame(
      Variable = names(dt_var_importance),
      Importance = dt_var_importance
    )
    dt_var_importance_df <- dt_var_importance_df[order(-dt_var_importance_df$Importance),]
    
    print(paste("Decision Tree Variable Importance for", dataset_name, ":"))
    print(dt_var_importance_df)
    
    # Return results
    return(list(
      model = dt_model_pruned,
      accuracy = dt_accuracy,
      precision = dt_precision,
      recall = dt_recall,
      f1 = dt_f1,
      var_importance = dt_var_importance_df,
      predictions = dt_predictions
    ))
  } else {
    print("No variable importance available - model might be too simple")
    return(list(
      model = dt_model_pruned,
      accuracy = dt_accuracy,
      precision = dt_precision,
      recall = dt_recall,
      f1 = dt_f1,
      var_importance = NULL,
      predictions = dt_predictions
    ))
  }
}

# Test models on original imbalanced data, ROSE and undersampled data
original_result <- evaluate_dt(train_data, test_data, "Original Imbalanced Data")
rose_result <- evaluate_dt(rose_train, test_data, "ROSE Balanced Data")
under_result <- evaluate_dt(undersampled_train, test_data, "Undersampled Data")

# Compare results
model_comparison <- data.frame(
  Model = c("Original", "ROSE", "Undersampling"),
  Accuracy = c(original_result$accuracy, rose_result$accuracy, under_result$accuracy),
  Precision = c(original_result$precision, rose_result$precision, under_result$precision),
  Recall = c(original_result$recall, rose_result$recall, under_result$recall),
  F1_Score = c(original_result$f1, rose_result$f1, under_result$f1)
)

print("Model Performance Comparison:")
print(model_comparison)

# Select the best model based on F1 score
best_model_index <- which.max(model_comparison$F1_Score)
best_model_name <- as.character(model_comparison$Model[best_model_index])
print(paste("Best model based on F1 score:", best_model_name))

# Choose the best model result for further analysis
best_result <- list(original_result, rose_result, under_result)[[best_model_index]]
best_dt_model <- best_result$model

# Plot variable importance of the best model
if (!is.null(best_result$var_importance)) {
  par(mar=c(10, 4, 4, 2) + 0.1)  # Increase bottom margin for labels
  barplot(best_result$var_importance$Importance,
          names.arg = best_result$var_importance$Variable,
          main = paste("Variable Importance -", best_model_name),
          xlab = "Variables",
          ylab = "Importance",
          col = "steelblue",
          las = 2,
          cex.names = 0.7)
  par(mar=c(5, 4, 4, 2) + 0.1)  # Reset margins
}


# --- 6. Clustering Analysis (Unsupervised Learning) ---

# Select numeric variables for clustering
clustering_data <- data[, c("age", "balance", "duration", "campaign", "pdays", "previous")]

# Handle -1 in pdays (no previous contact)
clustering_data$pdays[clustering_data$pdays == -1] <- max(clustering_data$pdays) + 1

# Normalize the data
clustering_data_scaled <- scale(clustering_data)

# Determine optimal number of clusters using the elbow method
set.seed(123)
wss <- numeric(10)
wss[1] <- (nrow(clustering_data_scaled)-1)*sum(apply(clustering_data_scaled, 2, var))
wss[2:10] <- sapply(2:10, function(k) kmeans(clustering_data_scaled, centers = k, nstart = 25)$tot.withinss)

# Plot elbow method
plot(1:10, wss, type = "b", pch = 19, frame = FALSE, 
     xlab = "Number of clusters K", 
     ylab = "Total within-clusters sum of squares",
     main = "Elbow Method for Optimal K",
     xlim = c(1,10))

# Calculate second differences to find the "elbow" point
wss_diffs <- diff(wss)
wss_second_diffs <- diff(wss_diffs)
optimal_k <- which.min(abs(wss_second_diffs)) + 1
abline(v = optimal_k, lty = 2, col = "red")

print(paste("Optimal number of clusters:", optimal_k))

# Perform K-means clustering
kmeans_result <- kmeans(clustering_data_scaled, centers = optimal_k, nstart = 25)

# Add cluster assignments to the original data
data$cluster <- kmeans_result$cluster

# Visualize clusters (using first two principal components for visualization)
pca_result <- prcomp(clustering_data_scaled)
fviz_cluster(kmeans_result, data = clustering_data_scaled,
             geom = "point",
             ellipse.type = "convex",
             palette = "jco",
             ggtheme = theme_minimal(),
             main = "Cluster Plot")

# Analyze the characteristics of each cluster
cluster_summary <- aggregate(data[, c("age", "balance", "duration", "campaign", 
                                      "pdays", "previous", "y_numeric")],
                             by = list(Cluster = data$cluster),
                             FUN = mean)
print("Cluster Characteristics:")
print(cluster_summary)

# Cluster subscription rates
cluster_subscription <- aggregate(y_numeric ~ cluster, data = data, FUN = mean)
print("Subscription Rate by Cluster:")
print(cluster_subscription)

# Plot cluster subscription rates
barplot(cluster_subscription$y_numeric * 100,
        names.arg = paste("Cluster", cluster_subscription$cluster),
        main = "Subscription Rate by Cluster",
        xlab = "Cluster",
        ylab = "Subscription Rate (%)",
        col = rainbow(nrow(cluster_subscription)))

# Job distribution by cluster
job_by_cluster <- table(data$cluster, data$job)
print("Job Distribution by Cluster:")
print(job_by_cluster)

# Education distribution by cluster
education_by_cluster <- table(data$cluster, data$education)
print("Education Distribution by Cluster:")
print(education_by_cluster)

# --- 6.5 Enhanced Clustering: High and Low Potential Target Segmentation ---

# Calculate subscription rates for each cluster
cluster_subscription_rates <- aggregate(y_numeric ~ cluster, data = data, FUN = mean)

# Classify clusters as high or low potential based on subscription rates
median_rate <- median(cluster_subscription_rates$y_numeric)
cluster_potential <- data.frame(
  cluster = cluster_subscription_rates$cluster,
  subscription_rate = cluster_subscription_rates$y_numeric,
  potential = ifelse(cluster_subscription_rates$y_numeric > median_rate, "High", "Low")
)

print("Client Segment Potential Classification:")
print(cluster_potential)

# Add potential classification to the main dataset
data$potential <- "Low"  # Default value
for (i in 1:nrow(cluster_potential)) {
  cluster_id <- cluster_potential$cluster[i]
  potential_level <- cluster_potential$potential[i]
  data$potential[data$cluster == cluster_id] <- potential_level
}

# Create a summary of high vs low potential segments
high_potential <- subset(data, potential == "High")
low_potential <- subset(data, potential == "Low")

# Compare key characteristics between high and low potential segments
potential_comparison <- data.frame(
  Characteristic = c("Average Age", "Average Balance", "Average Campaign Contacts", 
                     "Previous Success Rate", "Has Housing Loan (%)", "Has Personal Loan (%)"),
  High_Potential = c(
    mean(high_potential$age),
    mean(high_potential$balance),
    mean(high_potential$campaign),
    mean(high_potential$poutcome == "success") * 100,
    mean(high_potential$housing == "yes") * 100,
    mean(high_potential$loan == "yes") * 100
  ),
  Low_Potential = c(
    mean(low_potential$age),
    mean(low_potential$balance),
    mean(low_potential$campaign),
    mean(low_potential$poutcome == "success") * 100,
    mean(low_potential$housing == "yes") * 100,
    mean(low_potential$loan == "yes") * 100
  )
)

# Format numeric values for better readability
potential_comparison$High_Potential <- round(potential_comparison$High_Potential, 2)
potential_comparison$Low_Potential <- round(potential_comparison$Low_Potential, 2)

print("Comparison between High and Low Potential Segments:")
print(potential_comparison)

# Visualize the segments
par(mfrow=c(1,2))

# Age distribution by potential
boxplot(age ~ potential, data = data,
        main = "Age Distribution by Potential",
        xlab = "Potential",
        ylab = "Age",
        col = c("lightcoral", "lightgreen"))

# Balance distribution by potential
boxplot(balance ~ potential, data = data,
        main = "Balance Distribution by Potential",
        xlab = "Potential",
        ylab = "Balance",
        col = c("lightcoral", "lightgreen"))

par(mfrow=c(1,1))

# Further analyze high potential clients
# Plot the job distribution in high potential clients
high_potential_jobs <- table(high_potential$job)
high_potential_jobs_pct <- high_potential_jobs / sum(high_potential_jobs) * 100

par(mar=c(10, 4, 4, 2) + 0.1)  # Increase bottom margin for labels
barplot(sort(high_potential_jobs_pct, decreasing = TRUE),
        main = "Job Distribution in High Potential Clients",
        xlab = "",
        ylab = "Percentage",
        col = "lightgreen",
        las = 2,
        cex.names = 0.7)
par(mar=c(5, 4, 4, 2) + 0.1)  # Reset margins

# Create a profile of the ideal high-potential client
# Get the most common characteristics in high potential segments
high_potential_profile <- data.frame(
  Characteristic = c("Most Common Job", "Most Common Education", "Most Common Marital Status",
                     "Average Age", "Common Months for Contact", "Previous Campaign Success Rate"),
  Value = c(
    names(which.max(table(high_potential$job))),
    names(which.max(table(high_potential$education))),
    names(which.max(table(high_potential$marital))),
    round(mean(high_potential$age), 1),
    paste(names(sort(table(high_potential$month), decreasing = TRUE)[1:3]), collapse = ", "),
    paste0(round(mean(high_potential$poutcome == "success") * 100, 1), "%")
  )
)

print("High Potential Client Profile:")
print(high_potential_profile)

# --- 7. Model Comparison ---

# Calculate entropy for each cluster
cluster_entropies <- tapply(data$y_numeric, data$cluster, function(x) {
  p <- mean(x)
  if (p == 0 || p == 1) return(0)
  -p * log2(p) - (1-p) * log2(1-p)
})

# Calculate weighted average entropy
cluster_sizes <- table(data$cluster)
weighted_entropies <- cluster_entropies * (cluster_sizes / sum(cluster_sizes))
clustering_entropy <- sum(weighted_entropies)
print(paste("Clustering Entropy:", round(clustering_entropy, 4)))

# Compare with baseline entropy (no clustering)
baseline_p <- mean(data$y_numeric)
baseline_entropy <- -baseline_p * log2(baseline_p) - (1-baseline_p) * log2(1-baseline_p)
print(paste("Baseline Entropy (no clustering):", round(baseline_entropy, 4)))
print(paste("Entropy Reduction:", round(baseline_entropy - clustering_entropy, 4)))

# --- 7.5 Contact Method Classification ---

# Build a model to classify best contact method based on client characteristics

# First, check which contact methods have the best success rate
contact_success <- aggregate(y_numeric ~ contact, data = data, FUN = mean)
contact_success$success_rate <- contact_success$y_numeric * 100
contact_success <- contact_success[order(-contact_success$success_rate),]

print("Success Rate by Contact Method:")
print(contact_success)

# Create a classification model for best contact method
# Define the "best" contact method for each client based on success probability
# (We'll create a training set where the target is the most successful contact method)

# Transform data for contact method classification
# First, get the best contact method overall
best_contact <- as.character(contact_success$contact[1])

# Create a dataset for contact method prediction
contact_data <- data
contact_data$best_contact <- best_contact  # Default to the most successful method overall

# For clients who were actually contacted, set their best contact method
# based on whether they subscribed or not
contacted_indices <- which(contact_data$y == "yes")
contact_data$best_contact[contacted_indices] <- as.character(contact_data$contact[contacted_indices])

# Convert to factor
contact_data$best_contact <- as.factor(contact_data$best_contact)

# Build a decision tree to predict best contact method
# Split data for contact model
set.seed(456)
contact_train_indices <- sample(seq_len(nrow(contact_data)), size = sample_size)
contact_train <- contact_data[contact_train_indices, ]
contact_test <- contact_data[-contact_train_indices, ]



# --- 8. Conclusion and Summary ---

cat("\n--- Model Comparison Results ---\n")
cat("Decision Tree Performance (Best Model - ", best_model_name, "):\n", sep="")
cat(paste("  Accuracy:", round(model_comparison$Accuracy[best_model_index], 4), "\n"))
cat(paste("  Precision:", round(model_comparison$Precision[best_model_index], 4), "\n"))
cat(paste("  Recall:", round(model_comparison$Recall[best_model_index], 4), "\n"))
cat(paste("  F1 Score:", round(model_comparison$F1_Score[best_model_index], 4), "\n"))

cat("\nClustering Performance:\n")
cat(paste("  Number of optimal clusters:", optimal_k, "\n"))
cat(paste("  Entropy:", round(clustering_entropy, 4), "\n"))
cat(paste("  Entropy reduction from baseline:", round(baseline_entropy - clustering_entropy, 4), "\n"))

cat("\nKey Findings:\n")
cat("1. The most important predictors for term deposit subscription are:\n")
if (!is.null(best_result$var_importance)) {
  top_predictors <- best_result$var_importance$Variable[1:5]
  cat(paste("   -", top_predictors, "\n"))
}

cat("\n2. Cluster Analysis revealed distinct customer segments with varying subscription rates\n")
cluster_rates <- paste("   Cluster", cluster_summary$Cluster, "- Subscription rate:", 
                       round(cluster_summary$y_numeric * 100, 2), "%")
cat(paste(cluster_rates, "\n"))

cat("\n3. Marketing Recommendations based on our analysis:\n")
cat("   - Target clients with profiles similar to those in high-subscription clusters\n")
cat("   - Focus on the most influential factors identified in the decision tree\n")
cat("   - Consider personalized marketing approaches based on cluster characteristics\n")

cat("\n4. Client Segmentation Strategy:\n")
cat("   - High potential segments: ", paste(rownames(cluster_potential)[cluster_potential$potential == "High"], collapse=", "), "\n")
cat("   - Focus resources primarily on high potential segments\n")
cat("   - For low potential segments, reduce contact frequency and use lower-cost channels\n\n")

cat("5. Optimized Contact Method Strategy:\n")
cat("   - Personalize contact method based on client profile using our classification model\n")
contact_recommendations <- paste("   - For", names(table(data$recommended_contact)), 
                                 "contacts:", round(table(data$recommended_contact)/sum(table(data$recommended_contact))*100, 1), "%")
cat(paste(contact_recommendations, "of clients\n"))
cat("   - Match contact timing with client availability patterns\n")

