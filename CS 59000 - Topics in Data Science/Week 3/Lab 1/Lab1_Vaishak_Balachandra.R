########## q1

# a
url <- "https://users.stat.ufl.edu/~winner/data/atltime1004a.dat"
q1 <- read.table(url)
head(q1,6)
tail(q1)
dim(q1)

# b
names(q1)
sum(q1$V6 == 0)
cat("There are 88 flights got cancelled")
# or
data_new = subset(q1, q1$V6==0)
dim(data_new)
cat("There are 88 flights got cancelled")
summary(q1)


# c
length(table(q1$V3))
cat("93 flights from Atlanta")

########## q2

# a
# file.choose()
q2 <- read.csv("C:\\Users\\PNW_checkout\\Downloads\\sem2\\0. Coursework\\Data science\\Lab\\Lab 1\\aids.csv")
head(q2)
attach(q2)

# b
dim(q2)
cat("There are 570 rows and 7 columns")

# c
colnames(q2)

# d
summary(delay)

# e
hist(delay, main = "Histogram of Delay", col = rainbow(7))
#?hist

# f
?aggregate
aggregate(data.frame(q2), by = list(year), FUN = mean)

# g
aggregate(data.frame(q2), by = list(year, quarter), FUN = mean)

########## q3

install.packages("readxl")
library(readxl)
# file.choose()
q3 <- read_xlsx("C:\\Users\\PNW_checkout\\Downloads\\sem2\\0. Coursework\\Data science\\Lab\\Lab 1\\region.xlsx", sheet = "East")
head(q3)
dim(q3)
names(q3) = c("Month", "Product_A","Product_B","Product_C","Product_D")
boxplot(q3[,-1], col = rainbow(3), main = "Boxplot Distribution of the Region \nbased on Data Type")
