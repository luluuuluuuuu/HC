source("initialclus.R")
source("HC.R")
source("discalc.R")
nci <- read.table("nci.data.txt")
nci <- t(nci)
label <- read.table("label.txt")
distancetable <- matrix(rep(Inf, nrow(nci)*nrow(nci)), nrow(nci), nrow(nci))

for (i in 1:nrow(nci)) {
  for (j in 1:nrow(nci)) {
    distancetable[i,j] <- discalc(nci[i,], nci[j,])
  }
}
distancetable[which(distancetable==0)] <- Inf

clus1 <- initialclus(distancetable)
clus2 <- HC(clus1, distancetable, "average")
clus3 <- HC(clus2, distancetable, "average")
clus4 <- HC(clus3, distancetable, "average")
clus5 <- HC(clus4, distancetable, "average")
root <- HC(clus5, distancetable, "average")

performance <- 0
for (i in 1:length(clus2)) {
  performance <- performance + nlevels(as.factor(c(label[clus2[[i]],])))
}
