#' Get adjacency matrix from a sample-feature matrix
#'
#' @param data a matrix whose rows represent samples and columns represent features
#' @param k how many k nearest neighbors to build adjacency matrix
#'
#' @return Returns a adjacency matrix
#' @export
#'
get_adjacency_mat <- function(data,k = 20){
  Seurat_NNHelper <- utils::getFromNamespace("NNHelper", "Seurat")
  KNN <- Seurat_NNHelper(data, k = (k+1), method = "rann")@nn.idx
  tmp <- apply(KNN,1,function(row){
    i <- rep(row[1],length(row)-1)
    j <- row[-1]
    return(list(i=i,j=j))
  })
  adjacency_mat <- Matrix::sparseMatrix(i = unlist(lapply(tmp,function(x){x$i})),
                                        j = unlist(lapply(tmp,function(x){x$j})),
                                        x = 1,
                                        dims = c(nrow(KNN), nrow(KNN)))
  return(adjacency_mat)
}
