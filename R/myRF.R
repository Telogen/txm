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
