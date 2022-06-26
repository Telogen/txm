#' Perform kmeans with multiple 'k's and automatically select the best k
#'
#' Perform kmeans with multiple 'k's and automatically select the best k with the maximum average silhouette
#'
#' @param x numeric matrix of data, or an object that can be coerced to such a matrix.
#' @param k a set of candidate centers.
#' @param iter.max the maximum number of iterations allowed.
#'
#' @return returns an object of class "kmeans".
#'
#' @importFrom cluster silhouette
#'
#' @export

mykmeans <- function(x,k,iter.max = 10){
  sil <- sapply(k,function(one_k){
    KM_out <- kmeans(x,one_k,iter.max = iter.max)
    cluster::silhouette(KM_out$cluster,dist(x))[,3] %>% mean() %>% return()
  })
  best_k <- k[which.max(sil)]
  OUT <- kmeans(x,best_k)
  message(paste0('Best k is ',best_k, ', with maximum average silhouette ',round(max(sil),3)))
  return(OUT)
}



