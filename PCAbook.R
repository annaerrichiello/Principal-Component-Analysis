
# number of row and num of column 
n <- nrow(bad_drivers)
p <- ncol(bad_drivers)


# mean and std
mean <- colMeans(bad_drivers)
std <- apply(bad_drivers, 2, sd)

## PCA stating from covariance matrix
# covariance:
s <- cov(bad_drivers)
# The goal is to calculate the eigenvalues and eigenvectors of the calculated covariance matrix:
eigen(s)
autoval <- eigen(s)$values
autovec <- eigen(s)$vectors


## PCA starting form correlation matrix
# correlation:
rho <- cor(bad_drivers)

# The goal is to calculate the eigenvalues and eigenvectors of the calculated correlation matrix:
eigen(rho)
autoval <- eigen(rho)$values
autovec <- eigen(rho)$vectors

# Analysis of the eigenvalues
pvarsp = autoval/p
pvarspcum = cumsum(pvarsp)
pvarsp


#### princomp function:
acp<-princomp(bad_drivers, cor=T)
summary(princomp(bad_drivers, cor=T))
# select how many components:
screeplot(princomp(bad_drivers, cor=T))
# plot of the scores:
plot(princomp(bad_drivers, cor=T)$scores)
text(princomp(bad_drivers, cor=T)$scores, rownames(bad_drivers))
abline(h=0, v=0)
## biplot 
biplot(acp)


### book code
states=row.names(bad_drivers)
states
names(bad_drivers)
apply(bad_drivers, 2, mean)
apply(bad_drivers, 2, var)
pr.out=prcomp(bad_drivers, scale=TRUE)
names(pr.out)
pr.out$center
pr.out$scale
pr.out$rotation
dim(pr.out$x)
biplot(pr.out, scale=0)
pr.out$rotation=-pr.out$rotation
pr.out$x=-pr.out$x
biplot(pr.out, scale=0)
pr.out$sdev
pr.var=pr.out$sdev^2
pr.var
pve=pr.var/sum(pr.var)
pve
plot(pve, xlab="Principal Component", ylab="Proportion of Variance Explained", ylim=c(0,1),type='b')
plot(cumsum(pve), xlab="Principal Component", ylab="Cumulative Proportion of Variance Explained", ylim=c(0,1),type='b')
a=c(1,2,8,-3)
cumsum(a)

