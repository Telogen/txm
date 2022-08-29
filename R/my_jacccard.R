#' my_jacccard
#'
#' @param vec_b
#' @param vec_a
#'
#' @return
#' @export
#'
my_jacccard <- function(vec_a,vec_b){
  length(intersect(vec_a,vec_b))/length(union(vec_a,vec_b))
}



