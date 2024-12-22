Q1 <- read.table("http://www.statsci.org/data/oz/ms212.txt", header = T)
head(Q1)
dim(Q1)
attach(Q1)
table(Ran)
S <- subset(Q1, Ran == 2)
head(S)
t.test(S$Pulse1, S$Pulse2, paired = T) # since the same set of students we are using, paired  = TRUE
cat("Since p-value < 0.05, we reject the null hypothesis. There is sufficient evidence to conclude that there is a significant difference in pulse rates before and after sitting.")
R <- subset(Q1, Ran == 1)
head(R)
dim(R)
t.test(R$Pulse2, R$Pulse1, mu = 10, alt = "greater", paired = T)
cat("Since p-value < 0.05, we reject the null hypothesis. There is sufficient evidence to conclude that the average pulse rate increase after running is greater than 10 bpm.")




install.packages("PASWR")
library(PASWR)
data("Water")
head(Water)
attach(Water)
str(Water)
boxplot(Sodium~Source)
var.test(Sodium~Source)
cat("Since the p-value is less than 0.05, we reject the null hypothesis. This means that there is strong evidence to suggest that the variances of sodium content from Source X and Source Y are different.")


prop.test(x = c(180,238), n = c(580,600))
cat("Since the p-value is less than 0.05, we reject the null hypothesis. This means that there is significant statistical evidence that the proportions of Catholics and secular individuals in favor of capital punishment for persons.")


Q4 <- read.csv("C:\\Users\\PNW_checkout\\Downloads\\vaishak\\PNW_COURSE-WORK\\FALL24\\STATISTICAL COMPUTING\\Assignment\\Assignment 10\\q4.csv", header = T)
head(Q4)
dim(Q4)
boxplot(Q4$Metabolic.rate~Q4$Sex)
t.test(Q4$Metabolic.rate~Q4$Sex)
cat("Fail to reject the null hypothesis: There is no significant difference in the metabolic rates between genders (p-value = 0.4564).")
# also
# if variance_equal, more appropriate is as below
var.test(Q4$Metabolic.rate~Q4$Sex)
cat("Fail to reject the null hypothesis: There is no significant difference in variances between the groups (p-value = 0.1161).")
# if var.test p value > 0.05, then
t.test(Q4$Metabolic.rate~Q4$Sex, var.equal = T)
cat("Fail to reject the null hypothesis: There is no significant difference in the mean metabolic rates between genders (p-value = 0.4966).")



Q5 <- read.table("C:\\Users\\PNW_checkout\\Downloads\\vaishak\\PNW_COURSE-WORK\\FALL24\\STATISTICAL COMPUTING\\Assignment\\Assignment 10\\babiesI.data", header = T)
attach(Q5)
dim(Q5)
head(Q5)
sum(Q5$smoke == "9")  
head(Q5,20)
clean_data <- subset(Q5,smoke!=9)
dim(clean_data)
t.test(bwt~smoke, data = clean_data, alt = "greater")
cat("Reject the null hypothesis: There is significant evidence (p-value < 2.2e-16) that newborn babies of smoker moms have significantly lower birth weights than those of non-smoker moms.")




# install.packages("xlsx") -> range = "A1:D47" not working
# readxl package -> read_excel
install.packages(readxl)
library(readxl)
data1 <- read_excel("C:\\Users\\PNW_checkout\\Downloads\\vaishak\\PNW_COURSE-WORK\\FALL24\\STATISTICAL COMPUTING\\Assignment\\Assignment 10\\Hurricane.xlsx", range = "A1:D47")
data2 <- read_excel("C:\\Users\\PNW_checkout\\Downloads\\vaishak\\PNW_COURSE-WORK\\FALL24\\STATISTICAL COMPUTING\\Assignment\\Assignment 10\\Hurricane.xlsx", range = "E1:H47")
head(data1)
dim(data1)
head(data2)
dim(data2)
data <- rbind(data1, data2)
head(data)
dim(data)
attach(data)
boxplot(Death~Gender)
t.test(Death~Gender, alt = "greater")
cat("Reject the null hypothesis. This suggests that female-named hurricanes, on average, cause more deaths than male-named hurricanes.")




install.packages("MASS")
library(MASS)
data("birthwt")
tab <- table(birthwt$smoke, birthwt$low)
prop.test(tab)
cat("p value is 0.03958 < 0,05, There is a significant higher fraction of low-weight births among smokers.")

