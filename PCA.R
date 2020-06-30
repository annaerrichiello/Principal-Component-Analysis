#principal component analysis 
bad_drivers <- read.csv("https://raw.githubusercontent.com/fivethirtyeight/data/master/bad-drivers/bad-drivers.csv", sep = ",")
head(bad_drivers)
dir.create("data")
save(bad_drivers, file=file.path("data","bad_drivers.rda"))
a <- bad_drivers$Number.of.drivers.involved.in.fatal.collisions.per.billion.miles
b <- bad_drivers$Percentage.Of.Drivers.Involved.In.Fatal.Collisions.Who.Were.Speeding
c <- bad_drivers$Percentage.Of.Drivers.Involved.In.Fatal.Collisions.Who.Were.Alcohol.Impaired
d <- bad_drivers$Percentage.Of.Drivers.Involved.In.Fatal.Collisions.Who.Were.Not.Distracted
e <- bad_drivers$Percentage.Of.Drivers.Involved.In.Fatal.Collisions.Who.Had.Not.Been.Involved.In.Any.Previous.Accidents
f <- bad_drivers$Car.Insurance.Premiums....
g <- bad_drivers$Losses.incurred.by.insurance.companies.for.collisions.per.insured.driver....

bad_drivers <- data.frame(a,b,c,d,e,f,g)
bad_drivers

n <- nrow(bad_drivers) #number of rows
p <- ncol(bad_drivers) #number of columns

# mean and std:
mean <- colMeans(bad_drivers)
std <- apply(bad_drivers, 2, sd)
table <- round(cbind(mean, std),2)
table

## PCA starting from correlation matrix
corr <- cor(bad_drivers)
round(corr,3)


# computation of eigenvalues and eigenvectors:
eigen(corr)
eigenvalues <- eigen(corr)$values
eigenvectors <- eigen(corr)$vectors
eigenvalues
eigenvectors

#proportion of variance explained
pve = eigenvalues/p
pvecum = cumsum(pve)
tab <- round(cbind(eigenvalues,pve*100,pvecum*100),2)
colnames(tab)<-c("eigenvelues", "% variance","% cum variance")
tab
plot(pvecum, xlab="Principal Component", ylab="Proportion of Variance Explained", ylim=c(0,1),type='b')

#Scree Diagram to select the components:
plot(eigenvalues, type="b", main="Scree Diagram", xlab="Number of Component", ylab="Eigenvalues")
abline(h=1, lwd=3, col="red")

#Select 4 components 
eigen(corr)$vectors[,1:4]


#Matrix of the components
comp <- round(cbind(-eigen(corr)$vectors[,1]*sqrt(eigenvalues[1]),-eigen(corr)$vectors[,2]*sqrt(eigenvalues[2]),-eigen(corr)$vectors[,3]*sqrt(eigenvalues[3]),-eigen(corr)$vectors[,4]*sqrt(eigenvalues[4])),5)
rownames(comp)<-row.names(table)
colnames(comp)<-c("Comp1","Comp2","Comp3","Comp4")
comp

#communality
communality<-comp[,1]^2+comp[,2]^2+comp[,3]^2+comp[,4]^2
comp<-cbind(comp,communality)
comp


#scores
bad_drivers.scale <- scale(bad_drivers, T, T)
score <- bad_drivers.scale%*%eigenvectors[,1:4]

# score diagram
scores<-round(cbind(-score[,1]/sqrt(eigenvalues[1]),-score[,2]/sqrt(eigenvalues[2]),-score[,3]/sqrt(eigenvalues[3]),-score[,4]/sqrt(eigenvalues[4])),4)
plot(scores, main="Scores plot")
text(scores, rownames(bad_drivers))
abline(v=0,h=0,col="red")
# Loadings plot
plot(comp[,1:4], main="Loadings plot", xlim=range(-1,1))
text(comp, rownames(comp))
abline(v=0,h=0,col="red")



