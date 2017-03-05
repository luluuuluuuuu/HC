HC <- function(clus1, distancetable, linkage) {
  source("discalc.R")
  clus2 <- list()
  used <- NULL
  i <- 1
  for (cluster1 in 1:length(clus1)) {
    nearestDistance <- Inf
    if (!cluster1 %in% used) { 
      for (cluster2 in 1:length(clus1)) {
        if (!cluster2%in%used && cluster1!=cluster2) {
          switch(linkage,
                 single = calcdistance <- min(distancetable[clus1[[cluster1]], clus1[[cluster2]]]),
                 complete = calcdistance <- max(distancetable[clus1[[cluster1]], clus1[[cluster2]]]),
                 average = calcdistance <- sum(distancetable[clus1[[cluster1]], clus1[[cluster2]]])/(length(clus1[[cluster1]]*length(clus1[[cluster2]]))),
                 centroid = c(distancetable[which(distancetable==Inf)] <- 0,
                   calcdistance <- discalc(colSums(nci[clus1[[cluster1]],])/length(clus1[[cluster1]]), colSums(nci[clus1[[cluster2]],])/length(clus1[[cluster2]])))
          ) 
          distance <- calcdistance
          if (distance < nearestDistance) {   
            nearestDistance <- distance
            nearestclus <- c(cluster1, cluster2)    #for each each pair of clusters, go through elements
          }
        }
      }
      clus2[[i]] <- c(clus1[[nearestclus[1]]], clus1[[nearestclus[2]]])
      used <- c(used,nearestclus)
      i = i + 1
    }
  }
  return(clus2)
}