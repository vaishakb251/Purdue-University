################################################## Q1

# a
q1 <- read.table("https://jse.amstat.org/datasets/normtemp.dat.txt")
head(q1)
names(q1) = c("Temp","Gender","Hrate")
colnames(q1)
attach(q1)
length(q1)
# dim(q1)
cat("There are 3 variables in the given dataset")

# b
head(q1,5)

# c
hist(Temp, col = rainbow(4))
cat("Can't say using the histogram")
shapiro.test(Temp)
cat("Here, the pvalue = 0.2332, which is > 0.05. Thus, we fail to reject the null hypothesis that conclude that the data comes from normally distributed as we don't have enough evidence to prove the data is not normally distributed.")

# d
t.test(Temp, mu = 98.6) # not mean, it has to be mu
cat("Here,the pvalue < 0.05. Thus, we reject the null hypothesis, and conclude that true population mean is not really 98.6 degrees F")

# e
table(q1$Gender)
boxplot(Temp~Gender, col = c(2,3), main = "Boxplot of Temperature based on Gender", names = c("Male","Female"))
t.test(Temp~Gender)
cat("Here, the pvalue = 0.02394, which is less than 0.05. Thus, we reject the null hypothesis and conclude that average temperature of males and females are not equal.")

################################################## Q2

q2 <- read.table("https://media.pearsoncmg.com/cmg/pmmg_mml_shared/mathstatsresources/Akritas/DriveDurat.txt",header = T)
head(q2)
attach(q2)
dim(q2)
names(q2)
boxplot(duration~route, col = c(2,3), names = c("Standard","New"), main = "Boxplot of Duration based on new types")
table(q2$route)
t.test(duration~route, alt = "greater")
# Lesser the duration, the faster it is. That's why, since we are dealing with duration though 1(standard) comes before 2(New), we put 'greater', instead of 'lesser'
cat("Here, the pvalue < 0.05. Thus, we can conclude that New route is faster than standard route")

################################################## Q3

# a
q3 <- read.csv("C:/Users/PNW_checkout/Downloads/sem2/0. Coursework/Data science/Lab/Lab 2/Lab2 Data.csv")
head(q3)

# b
names(q3)

# c
attach(q3)
boxplot(Height~Sex, names = c("Male","Female"), col = c("darkblue","pink"), main = "Boxplot of Height based on Sex")

# d
boxplot(Weight~Sex, names = c("Male","Female"), col = c("darkblue","pink"), main = "Boxplot of Weight based on Sex")

# e
t.test(Weight~Sex)
cat("Here, the pvalue = 0.0005471, which is less than 0.05. Thus we reject the null hypothesis and conclude that there is a significant difference in the average weight between males and females")

# f
t.test(Height~Sex, alt = "greater")
cat("Here, the pvalue = 0.0001364, which is less than 0.05. Thus we reject the null hypothesis and conclude that the height of male is significantly higher than that of females.")

################################################## Q4

# a
q4 <- read.table("https://lib.stat.cmu.edu/jcgs/tu", skip = 4, header = T)
head(q4)
dim(q4)
cat("There are 136 rows and 7 columns")

# b
attach(q4)
sum(q4$TRT == 2)
# or subset method, or table method
cat("Thus, there are 69 individuals received treatment 2.")

