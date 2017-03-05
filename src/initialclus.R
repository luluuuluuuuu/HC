initialclus <- function(distancetable) {
  clus1 <- list()
  i <- 1
  used <- NULL
  for (k in 1:nrow(distancetable)) {
    if (!k %in% used) {
      if (length(used) == 0) {
        clus1[[i]] <- c(k, match(min(distancetable[k,]), distancetable[k,]))
      } else {
        clus1[[i]] <- c(k, match(min(distancetable[k,-used]), distancetable[k,]))
      }
      used <- unique(c(used,clus1[[i]]))
      i = i + 1
    }
  }
  return(clus1)
}