install.packages("BSDA")
library(BSDA)
nsize(b = 0.2, sigma = 1.2, conf.level = 0.98, type = "mu")


nsize(b=0.1, p = 9/40, conf.level=0.9, type="pi")


# q3 already solved

install.packages("pwr")
library(pwr)
power=cbind(NULL,NULL)
for(i in seq(0.1,1.5,0.1)){
        p1=power.t.test(d=i,power = 0.8,sig.level=0.05,alt="two.sided",type="two.sample")
        power=rbind(power,cbind(p1$d,p1$n))}
power
plot(power,xlab="Effect Size", ylab="Sample Size ", main="Effect Size vs Sample Size",type="b",col=2, lwd = 2, pch = 17)
