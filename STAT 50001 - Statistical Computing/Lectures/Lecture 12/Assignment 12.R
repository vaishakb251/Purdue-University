#Q1
data <- c(62,84,17,16,21)
data
chisq.test(data)
cat("Reject the null hypothesis i.e. proportion is not the same")

#Q2
# data <- c(46,29,29,38,27,22,24,25,33,29,17,19,11,19,14)
# A <- matrix(data, nrow = 5, byrow = T)
# dimnames(A) <- list(Countries = c("United States","China","Russia","Britain","Germany"))
# category = c("Gold","Silver","Bronze")
# A
# barplot(A, col = c(1,2,3,4,5),legend = rownames(A),cex.legend = 0.4)

#Q2
us = c(46,29,29)
china = c(38,27,22)
russia = c(24,25,33)
britain = c(29,17,19)
germany = c(11,19,14)
names(us) = c("Gold","Silver","Bronze")
Q2 = rbind(us, china, russia, britain, germany)
Q2
barplot(Q2, col = c(1,2,3,4,5), beside = T, legend = rownames(Q2), y.lim = c(0,200))
box()
#Q2 need to check a2z

#Q3
very_happy = c(271,261,82,20)
pretty_happy = c(247,567,231,53)
no_too_happy = c(33,103,92,36)
names(very_happy) = c("Excellent","Good","Fair","Poor")
Q3 <- rbind(very_happy,pretty_happy,no_too_happy)
Q3
chisq.test(Q3)
cat("Reject the null hypothesis i.e we conclude that health and happiness are dependant")


p_buckled = c(56,8)
p_unbuckled = c(2,16)
names(p_buckled) = c("c_buckled","c_unbuckled")
Q4 <- rbind(p_buckled,p_unbuckled)
Q4
chisq.test(Q4)
cat("Reject the null Hypothesis i.e we conclude that parent buckled dependant on the child buckled")


install.packages("UsingR")
library(UsingR)
dataset("mandms")
mandms
data <- c(15,34,7,19,29,24)

p_milkchoco = c(1/10,3/10,1/10,1/10,2/10,2/10)
chisq.test(data,p=p_milkchoco)
cat("Fail to reject the null hypothesis i.e. we cannot tell it is not from milk chocolate")

p_peanut = c(2/10,2/10,1/10,1/10,2/10,2/10)
chisq.test(data,p=p_peanut)
cat("Reject the null hypothesis i.e. we can tell it is not from peanut")

# p_peanutButter = c(2/10,2/10,2/10,0/10,2/10,2/10)
# chisq.test(data,p=p_peanutButter)
# cat("Fail to reject the null hypothesis i.e. we cannot tell it is not from milk chocolate")



............
