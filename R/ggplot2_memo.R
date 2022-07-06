#' Add a line in ggplot
#'
#' @return
#' @export
#'
myplot_addline <- function(){
  ###### 垂直线 ######
  geom_vline(xintercept = 2, linetype = "dotted")
  ###### 水平线 ######
  geom_hline(yintercept = 2, linetype = "dotted")
  ######  斜线  ######
  geom_abline(slope = 1,    # 斜率
              intercept = 0,     # 截距
              color='black',
              linetype = "dashed",
              size=1)
}



#' geom_text memo
#'
#' @return
#' @export
#'
myplot_text <- function(){
  geom_text(aes(label = paste0(round(GMMseeds,2),' -> ',round(KNNseeds,2)),
                hjust = -.1,     # 向右移
                vjust = -.1))     # 向上移
}






