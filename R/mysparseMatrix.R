#' create a sparseMatrix
#'
#' @return
#' @export
#'
mysparseMatrix <- function(){
  mat <- Matrix::sparseMatrix(
    i = count.df[,1],
    j = count.df[,2],
    x = count.df[,3],
    dims = c(nrow(obj), length(genes)),
    dimnames = list(obj@barcode, as.character(genes$name))
    )
}
