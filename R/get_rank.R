#' Get ranks of a series of numerics with names
#'
#' @param x a series of numerics with names
#'
#' @return each element's rank
#' @export
#'
get_rank <- function(x){
  if(is.null(names(x))){
    names(x) <- 1:length(x)
  }
  rank <- 1:length(x)
  names(rank) <- sort(x,decreasing = T) %>% names()
  rank <- rank[names(x)]
  return(rank)
}



#' Get quantile of a number in a vector
#'
#' @param data a vector
#' @param x a number
#'
#' @return the quantile of the number
#' @export
#'
get_quantile <- function(data,x){
  which.min(abs(sort(data) - x))/length(data)
}

