Q1 = scan()
Q1
shapiro.test(Q1)
cat("Reject the null hypothesis i.e. Not from a Normal Distribution")
# can also be verified by
qqnorm(Q1)


Q2 = scan()
Q2
shapiro.test(Q2)
cat("Reject the null hypothesis i.e. Not from a Normal Distribution")
install.packages("PASWR")
library(PASWR)
SIGN.test(Q2, md = 1770, conf.level = 0.9)
cat("Fail to reject the null hypothesis i.e. we have no evidence to conclude that the median pay differ by $1770")
qqnorm(Q2)


install.packages("UsingR")
library(UsingR)
data("exec.pay")
head(exec.pay)
summary(exec.pay)
shapiro.test(exec.pay)
cat("Reject the null hypothesis, i.e. not a normal distribution")
library(PASWR)
SIGN.test(exec.pay, md = 22, alt = "greater")
cat("Reject the null hypothesis i.e. median pay is more than $220000")
