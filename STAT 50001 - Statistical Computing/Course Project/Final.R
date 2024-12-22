install.packages("readxl")
install.packages("dpylr")
install.packages("knitr")
install.packages("DT")
install.packages("corrplot")
install.packages("ggplot2")
install.packages("sf")
install.packages("maps")
install.packages("leaps")
install.packages("MASS")

library(readxl)
library(dplyr)
library(knitr)
library(DT)
library(corrplot)
library(ggplot2)
library(sf)
library(maps)
library(leaps)
library(MASS)

Batsman <- read_excel("C:/Users/PNW_checkout/Downloads/vaishak/PNW_COURSE-WORK/FALL24/STATISTICAL COMPUTING/FINAL PROJECT/Batsman.xlsx", sheet = 1)
dim(Batsman)
names(Batsman)
# View(Batsman)


##################################################################################################################################
######### Step 1: Data Cleaning
# Handle missing values (assuming "-" is used for missing values)
Batsman_clean <- Batsman %>%
        mutate(across(where(is.numeric), as.character)) %>%  # Convert numeric columns to character
        mutate(across(everything(), ~na_if(., "-"))) %>%  # Convert "-" to NA
        na.omit()  # Remove rows with NA values

# Step 2: Rename columns as per your request
Batsman_clean <- Batsman_clean %>%
        rename(
                Match = Mat,
                Innings = Inns,
                NotOut = NO,
                HighestScore = HS,
                BattingAverage = Ave,
                BallsFaced = BF,
                StrikeRate = SR,
                Hundreds = `100`,
                Fifties = `50`,
                Ducks = `0`,
                Fours = `4s`,
                Sixes = `6s`
        )

# Step 3: Split the 'HS' (Highest Score) column into 'HS' and 'HS_star'
Batsman_clean <- Batsman_clean %>%
        mutate(
                HS_star = ifelse(grepl("\\*", HighestScore), 1, 0),  # Create 'HS_star' column to mark not-out
                HighestScore = as.numeric(gsub("\\*", "", HighestScore))  # Remove "*" and convert to numeric
        )
names(Batsman_clean)
# Step 4: Split the 'Player' column into 'PlayerName' and 'Country'
Batsman_clean <- Batsman_clean %>%
        mutate(
                PlayerName = gsub(" \\(.*\\)", "", Player),  # Extract player name (remove country in brackets)
                Country = gsub(".*\\((.*)\\)", "\\1", Player)  # Extract country (from within parentheses)
        ) %>%
        select(-Player)  # Remove original 'Player' column

# Step 5: Final clean-up (Convert necessary columns to appropriate formats)
Batsman_clean <- Batsman_clean %>%
        mutate(
                Span = as.character(Span),  # Ensure 'Span' is in character format
                Match = as.numeric(Match),  # Convert 'Match' (Matches) to numeric
                Innings = as.numeric(Innings),  # Convert 'Innings' (Innings) to numeric
                NotOut = as.numeric(NotOut),  # Convert 'NotOut' (Not Outs) to numeric
                Runs = as.numeric(Runs),  # Convert 'Runs' to numeric
                BallsFaced = as.numeric(BallsFaced),  # Convert 'BallsFaced' (Balls Faced) to numeric
                StrikeRate = as.numeric(StrikeRate),  # Convert 'StrikeRate' (Strike Rate) to numeric
                Hundreds = as.numeric(Hundreds),  # Convert 'Hundreds' (Centuries) to numeric
                Fifties = as.numeric(Fifties),  # Convert 'Fifties' (Half-Centuries) to numeric
                Ducks = as.numeric(Ducks),  # Convert 'Ducks' (Ducks) to numeric
                Fours = as.numeric(Fours),  # Convert 'Fours' (Fours) to numeric
                Sixes = as.numeric(Sixes)   # Convert 'Sixes' (Sixes) to numeric
        )

# Step 6: Split the 'Span' column into 'StartYear' and 'EndYear'
Batsman_clean <- Batsman_clean %>%
        mutate(
               StartYear = as.numeric(sub("-.*", "", Span)),  # Extract the start year from 'Span'
                EndYear = as.numeric(sub(".*-", "", Span))     # Extract the end year from 'Span'
        ) %>%
        select(-Span)  # Optionally, remove the original 'Span' column

# View the updated cleaned data
head(Batsman_clean)
# View(Batsman_clean)
colnames(Batsman_clean)
dim(Batsman_clean)

##################################################################################################################################
########  Step 2: Data Exploration

# 1. Basic Statistics for Numeric Columns
summary(Batsman_clean)

# 2. Frequency Distribution for Categorical Variables
# Let's use table() to explore frequencies of X100 (Hundreds), X50 (Fifties), and Ducks

# Display the tables using kable for Markdown or RMarkdown
# CenturyTable <- kable(table(Batsman_clean$Hundreds), col.names = c("Number of Centuries", "Frequency"), caption = "Frequency Distribution of Centuries (Hundreds)")
# FiftyTable <- kable(table(Batsman_clean$Fifties), col.names = c("Number of Half-Centuries", "Frequency"), caption = "Frequency Distribution of Half-Centuries (Fifties)")
# DuckTable <- kable(table(Batsman_clean$Ducks), col.names = c("Number of Ducks", "Frequency"), caption = "Frequency Distribution of Ducks")
# 
# CenturyTable
# FiftyTable
# DuckTable

# Render interactive tables using DT::datatable
CenturyTable <- datatable(data.frame(table(Batsman_clean$Hundreds)), colnames = c("Number of Centuries", "Frequency"), caption = "Frequency Distribution of Centuries (Hundreds)", options = list(pageLength = 5))

FiftyTable <- datatable(data.frame(table(Batsman_clean$Fifties)), colnames = c("Number of Half-Centuries", "Frequency"), caption = "Frequency Distribution of Half-Centuries (Fifties)", options = list(pageLength = 5))

DuckTable <- datatable(data.frame(table(Batsman_clean$Ducks)), colnames = c("Number of Ducks", "Frequency"), caption = "Frequency Distribution of Ducks", options = list(pageLength = 5))

CenturyTable
FiftyTable
DuckTable

############################

# Summary statistics for numerical variables
summary_stats <- Batsman_clean %>%
        select(Match, Innings, NotOut, Runs, BattingAverage, BallsFaced, StrikeRate, 
               Hundreds, Fifties, Ducks, Fours, Sixes) %>%
        summary()

# View summary statistics
print(summary_stats)

############################

# Correlation Between Numeric Variables:

str(Batsman_clean)
Batsman_clean$BattingAverage <- as.numeric(Batsman_clean$BattingAverage)

correlation_matrix <- cor(Batsman_clean %>% select(Match, Innings, NotOut, Runs, BattingAverage, BallsFaced, StrikeRate, Hundreds, Fifties, Ducks, Fours, Sixes), use = "complete.obs")
print(correlation_matrix)

corrplot(correlation_matrix, method = "circle", type = "upper", title = "Correlation Plot of the Batsman Dataset", outline = T, tl.cex = 0.44, pch.cex = 1)

############################

# Top Players Based on Performance:

# Top 10 players by Runs
top_runs <- Batsman_clean %>%
        arrange(desc(Runs)) %>%
        select(PlayerName, Runs) %>%
        head(10)

mean_matches <- mean(Batsman_clean$Match, na.rm = TRUE)

# Top 10 players by Batting Average (with at least mean matches played)
top_avg <- Batsman_clean %>%
        filter(Match >= mean_matches) %>%
        arrange(desc(BattingAverage)) %>%
        select(PlayerName, BattingAverage, Match) %>%
        head(10)

# Top 10 players by Strike Rate (with at least mean matches played)
top_strike_rate <- Batsman_clean %>%
        filter(Match >= mean_matches) %>%
        arrange(desc(StrikeRate)) %>%
        select(PlayerName, StrikeRate, Match) %>%
        head(10)

# View results
print(top_runs)
print(top_avg)
print(top_strike_rate)


########################

# Country based analysis

# Define and apply the mapping of inconsistent values to standardized values
country_mapping <- c(
        "WI/World" = "WI", "ENG/World" = "ENG", "AUS/World" = "AUS",
        "BDESH/ICC/World" = "BDESH", "ICC/PAK" = "PAK", "ICC/INDIA" = "INDIA",
        "NZ/World" = "NZ", "ENG/IRE" = "ENG", "SA/World" = "SA",
        "AFG/GER" = "AFG", "AFG/ICC" = "AFG", "AUS/ICC/NZ" = "AUS",
        "USA/WI" = "USA", "ICC/NZ" = "NZ", "ICC/NEPAL" = "NEPAL",
        "HKG/NZ" = "HKG", "ICC/SL/World" = "SL", "ENG/ICC" = "ENG",
        "AUS/NL" = "AUS", "NL/SA" = "SA"
)

Batsman_clean <- Batsman_clean %>%
        mutate(Country = recode(Country, !!!country_mapping))

# Standardize country names for consistency
Batsman_clean <- Batsman_clean %>%
        mutate(Country = recode(Country,
                                "INDIA" = "India", "AUS" = "Australia", "ENG" = "England",
                                "NZ" = "New Zealand", "PAK" = "Pakistan", "SA" = "South Africa",
                                "WI" = "West Indies", "BDESH" = "Bangladesh", "IRE" = "Ireland",
                                "ZIM" = "Zimbabwe", "AFG" = "Afghanistan", "SL" = "Sri Lanka",
                                "SCOT" = "Scotland", "NL" = "Netherlands",
                                "UAE" = "United Arab Emirates", "USA" = "United States",
                                "NAM" = "Namibia", "OMAN" = "Oman", "NEPAL" = "Nepal",
                                "KENYA" = "Kenya", "PNG" = "Papua New Guinea",
                                "CAN" = "Canada", .default = Country))

# Summarize statistics by country
country_stats <- Batsman_clean %>%
        group_by(Country) %>%
        summarise(
                mean_runs = mean(Runs, na.rm = TRUE),
                mean_batting_avg = mean(as.numeric(BattingAverage), na.rm = TRUE),
                mean_strike_rate = mean(StrikeRate, na.rm = TRUE),
                total_players = n()
        ) %>%
        arrange(desc(mean_runs))  # Sort by mean runs

# View country-level statistics
print(country_stats)

# Load world map data
world_map <- map_data("world")

# Standardize country names in world_map if necessary
world_map$region <- recode(world_map$region,
                           "USA" = "United States", "UK" = "England")

# Merge world map with cricket data
map_data <- world_map %>%
        left_join(country_stats, by = c("region" = "Country"))

# Plot the map
ggplot(data = map_data, aes(x = long, y = lat, group = group, fill = total_players)) +
        geom_polygon(color = "black", linewidth = 0.1) +  # `linewidth` for aesthetics
        scale_fill_gradient(low = "lightgreen", high = "darkgreen", na.value = "grey80", 
                            name = "Total Players") +
        theme_minimal() +
        labs(
                title = "Cricket Player Distribution by Country",
                subtitle = "Gradient shows density based on total players",
                caption = "Data Source: Batsman_clean"
        )

########################

# NOT YET CHECKED BELOW CODES

########################



# Performance Over Time:

# Create a performance overview over the years
performance_over_time <- Batsman_clean %>%
        group_by(StartYear, EndYear) %>%
        summarise(
                avg_batting_avg = mean(BattingAverage, na.rm = TRUE),
                avg_strike_rate = mean(StrikeRate, na.rm = TRUE)
        ) %>%
        arrange(StartYear)

# View performance trends over time
print(performance_over_time)

# Plotting performance trends
ggplot(performance_over_time, aes(x = StartYear)) +
        geom_line(aes(y = avg_batting_avg, color = "Batting Average")) +
        geom_line(aes(y = avg_strike_rate, color = "Strike Rate")) +
        labs(
                title = "Performance Overview Over Time",
                x = "Year",
                y = "Average",
                color = "Metrics"
        ) +
        theme_minimal()

########################
# Player's Not-Out Statistics:

# Compare players who are not-out (HS_star = 1) vs those who are out (HS_star = 0)
not_out_stats <- Batsman_clean %>%
        group_by(HS_star) %>%
        summarise(
                avg_runs = mean(Runs, na.rm = TRUE),
                avg_batting_avg = mean(BattingAverage, na.rm = TRUE),
                avg_strike_rate = mean(StrikeRate, na.rm = TRUE),
                total_players = n()
        )

# View stats comparing not-out vs out players
print(not_out_stats)


#####################
# Distribution of Batting Average and Strike Rate:

# Plotting histograms for Batting Average and Strike Rate
library(ggplot2)

# Batting Average Distribution
ggplot(Batsman_clean, aes(x = BattingAverage)) +
        geom_histogram(bins = 20, fill = "blue", color = "black", alpha = 0.7) +
        labs(title = "Distribution of Batting Average", x = "Batting Average", y = "Frequency")

# Strike Rate Distribution
ggplot(Batsman_clean, aes(x = StrikeRate)) +
        geom_histogram(bins = 20, fill = "green", color = "black", alpha = 0.7) +
        labs(title = "Distribution of Strike Rate", x = "Strike Rate", y = "Frequency")


####################### 
# Exploring Players Who Have Never Scored a Duck:

# Identify players with no ducks
no_ducks <- Batsman_clean %>%
        filter(Ducks == 0) %>%
        select(PlayerName, Runs, BattingAverage, StrikeRate)

# View players who never scored a duck
print(no_ducks)


##################################################################################

#high score out/not out status

# Improved boxplot with better visual appeal
boxplot(BattingAverage ~ HS_star, data = Batsman_clean,
        col = c("#FF9999", "#99CCFF"), # Softer, visually appealing colors
        main = "Highest Score: OUT vs. NOT OUT Players", # Updated title
        xlab = "Player Status", # Improved x-axis label
        ylab = "Highest Score", # Improved y-axis label
        notch = TRUE, # Keeps notched style
        names = c("OUT", "NOT OUT")) # Custom x-axis labels

# Adding gridlines for better readability
grid(nx = NULL, ny = NULL, col = "lightgray", lty = "dotted")

# Adding a legend to clarify groups
legend("topright", legend = c("OUT", "NOT OUT"), 
       fill = c("#FF9999", "#99CCFF"), bty = "n")



################################################################################

# Batting Average Prediction

names(Batsman_clean)
subsets = regsubsets(BattingAverage~Match+NotOut+Runs+HighestScore+BallsFaced+StrikeRate+Hundreds+Fifties+Ducks+Fours+Sixes, data = Batsman_clean)
subset_summary = summary(subsets)
plot(subset_summary$adjr2, type = "b", xlab = "Number of Variables", ylab = "Adjusted R-Squared",
     main = "Variable Selection Using regsubsets")

cat("Choose the number of variables to include (1 to 8): ")
num_vars = as.integer(readline())

# Validate the input
if (num_vars < 1 || num_vars > length(subset_summary$which) - 1) {
        stop("Invalid number of variables. Please run the script again and choose a valid number.")
}

# Extract the corresponding row from the summary
chosen_model = subset_summary$which[num_vars, ]  # Adjust for 1-based index
cat("\nSelected Variables:\n")
print(names(chosen_model)[chosen_model])

# Proceed with the selected model
final_formula = as.formula(paste("BattingAverage ~", paste(names(chosen_model)[-1][chosen_model[-1]], collapse = " + ")))
cat("\nFinal Formula:\n")
print(final_formula)

# Optionally, fit a model using the chosen variables
final_model = lm(final_formula, data = Batsman_clean)
model_summary = summary(final_model)

# Extract coefficients
coefficients = model_summary$coefficients[, "Estimate"]

# Format and display the equation
equation = paste0("y = ", round(coefficients[1], 4))  # Start with intercept
for (i in 2:length(coefficients)) {
        term = paste0(" + ", round(coefficients[i], 4), "*", names(coefficients)[i])
        equation = paste0(equation, term)
}
cat("\nRegression Equation:\n")
cat(equation, "\n")

# Display the summary of the final model
summary(final_model)

plot(final_model,1 )

library("MASS")

summary(Batsman_clean$BattingAverage)

# # Add a small constant to BattingAverage to make all values positive
# epsilon = 1e-6  # Small constant
# Batsman_clean$BattingAverage = Batsman_clean$BattingAverage + epsilon
# b = boxcox(final_model)
# cat("Lamdba: 0.45") # for 6 variables

# Identify the optimal lambda (power)
boxcox_result = boxcox(final_model)
optimal_lambda = boxcox_result$x[which.max(boxcox_result$y)]
cat("\nOptimal Lambda for Box-Cox Transformation:\n")
cat(optimal_lambda, "\n")

# Transform BattingAverage based on the optimal lambda
if (abs(optimal_lambda) < 1e-2) {
  Batsman_clean$TransformedBattingAverage = log(Batsman_clean$BattingAverage)
  cat("\nUsing log transformation as lambda is close to 0.\n")
} else {
  Batsman_clean$TransformedBattingAverage = Batsman_clean$BattingAverage^optimal_lambda
  cat("\nUsing power transformation with lambda = ", round(optimal_lambda, 2), ".\n")
}

# Refit the model with the transformed dependent variable
transformed_formula = as.formula(paste("TransformedBattingAverage ~", 
                                       paste(names(chosen_model)[-1][chosen_model[-1]], collapse = " + ")))
transformed_model = lm(transformed_formula, data = Batsman_clean)

# Display summary of the transformed model
cat("\nSummary of the Model with Transformed Dependent Variable:\n")
summary(transformed_model)


plot(transformed_model,1 )
summary(transformed_model)


  
##########################################################################

