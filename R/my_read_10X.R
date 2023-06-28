#' my_read_10X
#'
#' @param feature_file
#' @param cell_file
#' @param mtx_file
#'
#' @return
#' @export
#'
my_read_10X <- function (feature_file, cell_file, mtx_file) {
  counts <- Matrix::readMM(file = mtx_file)
  cell.barcodes <- as.data.frame(data.table::fread(cell_file, header = FALSE))$V1
  feature.names <- as.data.frame(data.table::fread(feature_file, header = FALSE))$V1
  dimnames(counts) <- list(feature.names,cell.barcodes)
  return(counts)
}




