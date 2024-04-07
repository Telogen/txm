#' Random forest code memo
#'
#' @param train The train dataset whose rows are samples and columns are features
#' @param labels Labels of the train dataset
#' @param test The test dataset whose rows are samples and columns are features
#' @param verbose Whether to display messages
#'
#' @return todo
#' @export
#'
#' @importFrom randomForest randomForest
myRF <- function(train,labels,test,verbose = T){
  train <- as.data.frame(train)
  train$labels <- as.factor(labels)
  model <- randomForest::randomForest(labels ~ ., data = train, importance=TRUE, proximity=TRUE)
  if (verbose == T){
    print(randomForest::varImpPlot(model, main = "variable importance"))
  }
  pred <- predict(model,newdata = test)
  return(pred)
}







#' Random forest with cross validation
#'
#' @param trainx trainx
#' @param trainy trainy
#' @param n.fold n.fold
#' @param seed seed
#'
#' @return dataframe of true and pred_prob
#' @export
RF_CV <- function(trainx,trainy,n.fold = 5,seed = 123){
  # trainx <- data_retro_multihot;trainy <- data_retro$诊断分组;n.fold = 5;seed = 123

  names(trainy) <- 1:length(trainy)
  set.seed(seed)
  split_idx <- split(sample(1:length(trainy)), 1:n.fold)
  pred_prob_list <- lapply(1:5,function(fold_idx){
    # fold_idx <- 2
    test_idx <- split_idx[[fold_idx]]
    train_idx <- unlist(split_idx[-fold_idx],use.names = F)

    testx <- trainx[test_idx,]
    testy <- trainy[test_idx]
    train <- trainx[train_idx,]
    train$label <- as.factor(trainy[train_idx])
    # train$labels <- as.factor(data_retro$诊断分组)
    model <- randomForest::randomForest(label ~ ., data = train, importance = T, proximity = T, ntree=100)
    pred <- predict(model, newdata = testx,type = 'prob')[,'1']
    # pred <- predict(model, newdata = testx); get_benchmark(testy,pred)
    head(pred)
    head(testy)
    pred
  })
  pred_prob_list
  sampled_idx <- unlist(split_idx,use.names = F)
  pred_probs <- unlist(pred_prob_list,use.names = F)
  df <- data.frame(true = trainy[sampled_idx],
                   pred_prob = pred_probs)
  df
}






