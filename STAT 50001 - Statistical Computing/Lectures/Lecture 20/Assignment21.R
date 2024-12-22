# y<-c(33.3,33.4,32.9,32.6,32.5,33.0,34.5,34.8,33.8,33.4,
#      33.7,33.9,37.4,36.9,37.6,36.6,37.0,36.7)
# car=factor(rep(rep(1:2,c(3,3)),3))
# car
# levels(car)=c("A","B")
# driver<-factor(rep(1:3,c(6,6,6)))
# levels(driver)=c("a","b","c")
# data <- data.frame(car, driver, y)
# data
# attach(data)
# m1 = lm(y~car)
# anova(m1)
# # same also by
# # aov(y~car)
# # summary(aov(y~car))
# 
# m2 <- lm(y~driver)
# anova(m2)
# 
# boxplot(y~driver, data = data)
# # also, driver is significant difference
# boxplot(y~car, data = data)
# # also, car is not significant difference
# 
# fit = lm(y~car+driver)
# summary(fit)
# anova(fit)
# 
# # checking the interaction between the car and driver
# fit1 = lm(y~car*driver)
# summary(fit1)
# anova(fit1)
# # or
# # aov(y~car*driver)
# # summary(aov(y~car*driver))
# # inference: there is no significant difference

#############################

# y<-c(92,80,80,78,63,65,65,69,60,59,57,51,60,58,52,65)
# Seat<-factor(rep(c("Good","Bad"), c(8,8)))
# Seat
# Popcorn<-factor(rep(rep(c("Y","N"), c(4,4)),2))
# interaction.plot(Seat,Popcorn,y)
# summary(aov(y~Seat*Popcorn))

#############################

# MANOVA -> 2/many responses + 1 categorical variable
# Simple ANOVA -> 1 response + 1 categorical variable
# 2way ANOVA -> 1 response + 2/many categorical
# ANCOVA -> 1 response + 1 categorical variable + 1 or more continuous covariates

#############################

# EXAMPLE

# Subject	Group	        Treatment	Pre-Test Score	Post-Test Score	Satisfaction Rating
# 1	A (Control)	        Placebo	        50	        55	        3
# 2	A (Control)	        Placebo	        45     	        50	        2
# 3	B (Experimental)	Drug A	        60	        70	        4
# 4	B (Experimental)	Drug A	        55	        65	        5
# 5	C (Experimental)	Drug B	        52	        68	        4
# 6	C (Experimental)	Drug B	        50	        64	        4

# How it fits different analyses:
#         
# Simple ANOVA:
#               Response: Post-Test Score
#               Categorical Variable: Group (A, B, C)
# 
# 2-Way ANOVA:
#               Response: Post-Test Score
#               Categorical Variables: Group (A, B, C) and Treatment (Placebo, Drug A, Drug B)
# 
# MANOVA:
#               Responses: Post-Test Score and Satisfaction Rating
#               Categorical Variable: Group (A, B, C)
# 
# ANCOVA:
#               Response: Post-Test Score
#               Categorical Variable: Group (A, B, C)
#               Covariate: Pre-Test Score


#############################

# ASSIGNMENT 21

# file.choose()
data <- read.csv("C:\\Users\\PNW_checkout\\Downloads\\vaishak\\PNW_COURSE-WORK\\FALL24\\STATISTICAL COMPUTING\\Assignment\\Assignment 21\\ANCOVA data.csv")
head(data)
dim(data)
names(data)
new = data[,-c(1)]
summary(new)
table(new$technique)
# A B C
attach(new)
aggregate(exam, by = list(technique), FUN = mean)

boxplot(exam~technique) #VISUAL analysis
summary(aov(exam~technique))
cat("p value < 0.05, reject null hypothesis -> there's a significnat difference")
cat("To check which pair, has that difference")
TukeyHSD(aov(exam~technique))
cat("->-> There is no significant difference between B and C")

m1 = lm(exam~technique+current_grade)
anova(m1)
# m1 = lm(exam~current_grade+technique)
# anova(m1) -> different
