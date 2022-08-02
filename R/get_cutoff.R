#' Get cutoff based on the best F1 score
#'
#' @param value a vector of values
#' @param labels the labels of a vector of values
#' @param true_label true labels
#' @param plot whether to plot
#' @param min.F1 the minimum F1
#' @param alternative_cutoffs alternative cutoffs
#'
#' @return Return the best cutoff
#' @export
#'
get_cutoff <- function(value,labels,true_label = 'TRUE',min.F1 = NULL,alternative_cutoffs = NULL, plot = F){
  # value <- a
  # labels <- final_seed_meta$kendall_pred
  # true_label <- 'gdT'
  if(true_label != 'TRUE'){
    true_label <- labels == true_label
  }
  if(is.null(alternative_cutoffs)){
    inf_value <- value[is.finite(value)]
    alternative_cutoffs <- seq(min(inf_value),max(inf_value),length.out = 50)
  }
  alternative_cutoffs_benchmark <- sapply(alternative_cutoffs,function(cutoff){
    cutoff_label <- value > cutoff
    P <- MLmetrics::Precision(true_label,cutoff_label,positive = 'TRUE')
    R <- MLmetrics::Recall(true_label,cutoff_label,positive = 'TRUE')
    F1 <- MLmetrics::F1_Score(true_label,cutoff_label,positive = 'TRUE')
    c(Precision = P,Recall = R,F1 = F1)
  })
  if(is.null(min.F1)){
    best_cutoff_idx <- which.max(alternative_cutoffs_benchmark[3,])
  } else{
    best_cutoff_idx <- which(alternative_cutoffs_benchmark[3,] > min.F1)[1]
  }
  best_cutoff <- alternative_cutoffs[best_cutoff_idx]

  if(plot == TRUE){
    library(ggplot2)
    plot_df <- data.frame(alternative_cutoffs = alternative_cutoffs,
                          Precision = alternative_cutoffs_benchmark[1,],
                          Recall = alternative_cutoffs_benchmark[2,],
                          F1 = alternative_cutoffs_benchmark[3,])
    plot_df$is_best_cutoff <- ' '
    plot_df$is_best_cutoff[which(plot_df$alternative_cutoffs == best_cutoff)] <- as.character(round(best_cutoff,2))

    p1 <- ggplot(plot_df,aes(x = alternative_cutoffs,y = F1)) +
      geom_point() +
      geom_text(aes(label = round(F1,2),hjust = -0.2, vjust = -0.3)) +
      geom_vline(xintercept = best_cutoff, linetype = "dotted")

    p2 <- ggplot(plot_df,aes(x = Recall,y = Precision)) +
      geom_point(aes(color = is_best_cutoff)) +
      geom_text(aes(label = round(F1,2),hjust = -0.2, vjust = -0.3)) +
      Seurat::NoLegend()

    ggpubr::ggarrange(plotlist = list(p1, p2), ncol = 1, nrow = 2) %>% print()
  }
  return(best_cutoff)
}
