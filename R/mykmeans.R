#' Perform kmeans with multiple 'k's and automatically select the best k
#'
#' Perform kmeans with multiple 'k's and automatically select the best k with the maximum silhouette
#'
#' @param x numeric matrix of data, or an object that can be coerced to such a matrix.
#' @param k a set of candidate centers
#'
#' @return returns an object of class "kmeans".
#' @export
#'
#'
mykmeans <- function(x,k){
  sil <- sapply(k,function(one_k){
    KM_out <- kmeans(x,one_k,iter.max = iter.max)
    cluster::silhouette(KM_out$cluster,dist(x))[,3] %>% mean() %>% return()
  })
  best_k <- k[which.max(sil)]
  OUT <- kmeans(x,best_k)
  return(OUT)
}



