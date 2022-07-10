#' Get ranks of a series of numerics with names
#'
#' @param x a series of numerics with names
#'
#' @return each element's rank
#' @export
#'
get_rank <- function(x){
  rank <- 1:length(x)
  names(rank) <- sort(x,decreasing = T) %>% names()
  rank <- rank[names(x)]
  return(rank)
}

