#' read_h5ad_as_Seurat
#'
#' @param h5ad_file_name
#'
#' @export
#'
read_h5ad_as_Seurat <- function(h5ad_file_name){
  # h5ad_file_name <- "/mdshare/node8/txmdata/scREGION/Cortex_plot/raw_data/atac_cortex.h5ad"
  library(reticulate)
  library(Seurat)
  # python_path <- system("which python",intern = TRUE)
  python_path = '/home/timo/anaconda3/bin/python3'
  use_python(python_path)
  message(paste0('Using python: ',python_path))
  numpy <- import("numpy")
  pandas <- import("pandas")
  scanpy <- import("scanpy")
  adata <- scanpy$read(h5ad_file_name)
  count_mtx <- Matrix::t(adata$X)
  dimnames(count_mtx) <- list(rownames(adata$var),rownames(adata$obs))
  message('Createing Seurat object...')
  SeuratObj <- CreateSeuratObject(count_mtx,meta.data = adata$obs)
  return(SeuratObj)
}


