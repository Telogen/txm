#' TF-IDF
#'
#' @param object a matrix
#'
#' @return a matrix
#' @export
#'
mytfidf <- function (object){
  npeaks <- Matrix::colSums(x = object)
  tf <- Matrix::tcrossprod(x = object, y = Matrix::Diagonal(x = 1/npeaks))
  rsums <- Matrix::rowSums(x = object)
  idf <- ncol(x = object)/rsums
  norm.data <- Matrix::Diagonal(n = length(x = idf), x = idf) %*% tf
  dimnames(norm.data) <- dimnames(object)
  return(norm.data)
}
