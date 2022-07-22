#' Get top n elements
#'
#' @param x a vector
#' @param n top n
#'
#' @export
#'
top_n <- function(x,n,decreasing = T){
  sort(x,decreasing = decreasing)[1:n]
}



