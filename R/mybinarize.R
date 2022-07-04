#' Binarize matrix
#'
#' @param object a matrix
#'
#' @return a binarized matrix
#' @export
#'
mybinarize <- function(object){
  if (inherits(x = object, what = "dgCMatrix")) {
    methods::slot(object = object, name = "x") <-
      rep.int(x = 1, times = length(x = methods::slot(object = object, name = "x")))
  }
  else {
    object[object > 1] <- 1
  }
  return(object)
}

