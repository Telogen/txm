#' Get cutoff based on the best F1 score
#'
#' @param value
#' @param labels
#' @param true_label
#' @param plot
#'
#' @return Return the best cutoff
#' @export
#'
get_cutoff <- function(value,labels,true_label = 'TRUE',plot = F){
  # value <- a
  # labels <- final_seed_meta$kendall_pred
  # true_label <- 'gdT'
  if(true_label != 'TRUE'){
    true_label <- labels == true_label
  }
  alternative_cutoffs <- seq(min(value),max(value),length.out = 50)
  alternative_cutoffs_benchmark <- sapply(alternative_cutoffs,function(cutoff){
    cutoff_label <- value > cutoff
    P <- MLmetrics::Precision(true_label,cutoff_label)
    R <- MLmetrics::Recall(true_label,cutoff_label)
    F1 <- MLmetrics::F1_Score(true_label,cutoff_label)
    c(Precision = P,Recall = R,F1 = F1)
  })
  best_cutoff_idx <- which.max(alternative_cutoffs_benchmark[3,])
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
      geom_point() +
      geom_text(aes(label = is_best_cutoff,hjust = -0.2, vjust = -0.3))

    ggpubr::ggarrange(plotlist = list(p1, p2), ncol = 1, nrow = 2) %>% print()
  }
  return(best_cutoff)
}