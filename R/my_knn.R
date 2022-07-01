weighted_knn <- function(nn.idx,nn.dist,labels){
  sapply(1:nrow(nn.idx),function(row_idx){
    one_nn_idx <- nn.idx[row_idx,]
    one_nn_dist <- nn.dist[row_idx,]
    nn_labels <- labels[one_nn_idx]
    one_nn_weight <- (max(one_nn_dist) - one_nn_dist) / (max(one_nn_dist) - min(one_nn_dist))
    labels_impact <- sapply(unique(nn_labels),function(label){
      sum(one_nn_weight[which(nn_labels == label)])
    })
    pred <- names(labels_impact)[which.max(labels_impact)]
    score <- max(labels_impact)/sum(labels_impact)
    names(score) <- pred
    return(score)
  })
}

ss_knn <- function(nn.idx,nn.dist,labels = labels){
  sapply(1:nrow(nn.idx),function(row_idx){
    one_nn_idx <- nn.idx[row_idx,]
    one_nn_dist <- nn.dist[row_idx,]
    nn_labels <- local_ref_labels[one_nn_idx]
    labels_impact <- sapply(unique(nn_labels),function(label){
      exp(-one_nn_dist[which(nn_labels == label)]) %>% mean()
    })
    pred <- names(labels_impact)[which.max(labels_impact)]
    score <- max(labels_impact)/sum(labels_impact)
    names(score) <- pred
    return(score)
  })
}

normal_knn <- function(nn.idx,nn.dist,labels = labels){
  sapply(1:nrow(nn.idx),function(row_idx){
    one_nn_idx <- nn.idx[row_idx,]
    nn_labels <- local_ref_labels[one_nn_idx]
    TAB <- table(nn_labels)
    pred <- names(TAB)[which.max(TAB)]
    score <- max(TAB)/sum(TAB)
    names(score) <- pred
    return(score)
  })
}


#' Several K Nearest Neighbors (KNN) methods
#'
#' @param train The train dataset whose rows are samples and columns are features
#' @param labels Labels of the train dataset
#' @param test The test dataset whose rows are samples and columns are features
#' @param k Number of neighbors
#' @param method Knn method; can be one of "weighted", "Shieh", "normal"
#' @param dist.metric Distance metric; can be one of "euclidean", "cosine", "manhattan",
# "hamming"
#' @param verbose Whether to display messages
#'
#' @return Return a data frame containing a predicted labels column and a score column.
#' @export
#'

my_knn <- function(train,labels,test,k,method = 'weighted',dist.metric = 'cosine',verbose = T){
  if(verbose == T){
    message(paste0('Finding knn based on ',dist.metric,' distance metric'))
  }
  Seurat_NNHelper <- utils::getFromNamespace("NNHelper", "Seurat")
  KNN <- Seurat_NNHelper(data = train, query = test,k = k, method = "annoy",metric = dist.metric)
  nn.idx <- KNN@nn.idx
  nn.dist <- KNN@nn.dist

  if(verbose == T){
    message(paste0('Predicting labels using ',method,' knn method'))
  }
  if (method == 'weighted'){
    raw_pred <- weighted_knn(nn.idx,nn.dist,labels)
  } else if (method == 'Shieh'){
    raw_pred <- ss_knn(nn.idx,nn.dist,labels)
  } else if (method == 'normal'){
    raw_pred <- normal_knn(nn.idx,nn.dist,labels)
  }
  out <- data.frame(pred_labs = names(raw_pred),
                    score = as.numeric(raw_pred))
  return(out)
}
