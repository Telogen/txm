# plot_ROC
#' plot ROC curve
#'
#' @param true
#' @param pred_prob
#' @param length.out
#' @param return_df
#'
#' @return either a plot (default) or a result dataframe(return_df = T)
#' @export
#'
plot_ROC <- function(true,pred_prob,length.out = 50,return_df = F){
  cutoffs <- seq(floor(min(pred_prob)),ceiling(max(pred_prob)),length.out = length.out)
  cutoffs

  ROC_df <- sapply(cutoffs,function(cutoff){
    # cutoff <- 10
    pred <- case_when(pred_prob > cutoff ~ 1,.default = 0)
    df <- data.frame(pred = pred, true = true)
    # FPR: false positive rate 假阳性率
    FPR <- sum(df[which(df$true == 0),]$pred)/sum(df$true == 0)
    # TPR: true positive rate 真阳性率
    TPR <- sum(df[which(df$true == 1),]$pred)/sum(df$true == 1)
    c(FPR = FPR,
      TPR = TPR,
      cutoff = cutoff)
  }) %>% t() %>% as.data.frame()
  ROC_df
  ROC_df %<>%
    rbind(c(1,1,1),.)
  if(return_df){
    return(ROC_df)
  } else{
    p <- ggplot(ROC_df,aes(x = FPR, y = TPR)) +
      geom_polygon(data = rbind(ROC_df,c(1,0,0)),fill = "lightblue",alpha = 0.8,rule = 'winding') +
      geom_point() +
      geom_path() +
      geom_path(aes(1,0)) +
      # geom_text_repel(aes(label = cutoff)) +
      xlim(0,1) +
      ylim(0,1) +
      theme_bw() +
      ggtitle(paste0('ROC curve\n AUC = ',
                     -round(pracma::trapz(ROC_df$FPR,ROC_df$TPR),3))) +
      theme(plot.title = element_text(hjust = 0.5,size = 15))
    return(p)
  }
}






#' plot P-R Curve
#'
#' @param true
#' @param pred_prob
#' @param length.out
#' @param return_df
#'
#' @return either a plot (default) or a result dataframe(return_df = T)
#' @export
#'
plot_PRC <- function(true,pred_prob,length.out = 50,return_df = F){
  cutoffs <- seq(floor(min(pred_prob)),ceiling(max(pred_prob)),length.out = length.out)
  cutoffs

  PR_df <- sapply(cutoffs,function(cutoff){
    # cutoff <- 1
    pred <- case_when(pred_prob > cutoff ~ 1,.default = 0)
    df <- data.frame(pred = pred, true = true)
    presion <- sum(df[which(df$pred == 1),]$true)/sum(df[which(df$pred == 1),]$pred)
    recall <- sum(df[which(df$true == 1),]$pred)/sum(df[which(df$true == 1),]$true)
    c(presion = presion,
      recall = recall,
      cutoff = cutoff)
  }) %>% t() %>% as.data.frame()
  PR_df %<>%
    rbind(c(0,1,0),.) %>%
    rbind(c(1,0,999)) %>%
    mutate(F1 = (2*presion*recall)/(presion+recall)) %>%
    filter(F1 != 'NaN')
  if(return_df){
    return(PR_df)
  } else{
    p <- ggplot(PR_df,aes(x = presion, y = recall)) +
      geom_polygon(data = rbind(PR_df,c(0,0,999,999)),fill = "lightblue",alpha = 0.8,rule = 'winding') +
      geom_point() +
      geom_path() +
      # geom_text_repel(aes(label = cutoff)) +
      xlim(0,1) +
      ylim(0,1) +
      theme_bw() +
      ggtitle(paste0('PR curve\nAUPR = ',
                     round(pracma::trapz(PR_df$presion,PR_df$recall),3),
                     '\nF1-max = ',round(max(PR_df$F1),3))) +
      theme(plot.title = element_text(hjust = 0.5,size = 15))
    return(p)
  }
}











#' get_cutoffs
#'
#' @param true
#' @param pred_score
#' @param expected_precision0
#' @param expected_precision1
#' @param plot
#'
#' @return
#' @export
#'
get_cutoffs <- function(true,pred_score,
                        expected_precision0 = 0.9,
                        expected_precision1 = 0.9,
                        plot = F){
  # true <- retro_data_159$诊断分组;pred_score <- retro_data_159$总分
  cutoffs <- seq(floor(min(pred_score)),ceiling(max(pred_score)),length.out = 100)
  cutoffs

  cutoffs_precision <- sapply(cutoffs,function(cutoff){
    # cutoff <- 6
    pred <- case_when(pred_score > cutoff ~ 1,.default = 0)
    df <- data.frame(pred = pred, true = true)
    head(df)
    df_pred0 <- df[which(df$pred == 0),]
    precision0 <- 1 - sum(df_pred0$true)/nrow(df_pred0)
    df_pred1 <- df[which(df$pred == 1),]
    precision1 <- sum(df_pred1$true)/nrow(df_pred1)
    out <- c(cutoff,precision0,precision1)
    out
  }) %>% t() %>% as.data.frame()
  colnames(cutoffs_precision) <- c('cutoff','precision0','precision1')
  cutoffs_precision
  precision0_cutoff <- filter(cutoffs_precision,precision0 > expected_precision0)$cutoff %>% max()
  precision1_cutoff <- filter(cutoffs_precision,precision1 > expected_precision1)$cutoff %>% min()
  precision0_cutoff
  precision1_cutoff

  if(plot){
    p1 <- cutoffs_precision %>%
      ggplot(aes(x = cutoff, y = precision0)) +
      geom_point() +
      geom_line() +
      geom_text(aes(x = precision0_cutoff, y = expected_precision0,label = round(precision0_cutoff,2)),hjust = -0.2) +
      geom_hline(yintercept = expected_precision0, linetype = "dotted") +
      theme_bw() +
      ggtitle('Precision of 0')

    p2 <- cutoffs_precision %>%
      ggplot(aes(x = cutoff, y = precision1)) +
      geom_point() +
      geom_line() +
      geom_text(aes(x = precision1_cutoff, y = expected_precision1,label = round(precision1_cutoff,2)),hjust = 1) +
      geom_hline(yintercept = expected_precision1, linetype = "dotted") +
      theme_bw() +
      ggtitle('Precision of 1')

    p3 <- data.frame(true = true,pred_score = pred_score) %>%
      ggplot(aes(x = factor(true),y = pred_score)) +
      geom_boxplot() +
      geom_jitter() +
      xlab('diagnosis') +
      ylab('score') +
      geom_hline(yintercept = precision0_cutoff, linetype = "dashed") +
      geom_hline(yintercept = precision1_cutoff, linetype = "dashed") +
      theme_bw()

    print(p1 | p2 | p3)
  }
  print(c(precision0_cutoff,precision1_cutoff)  )
}




