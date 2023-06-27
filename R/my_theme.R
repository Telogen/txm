#' my ggplot2 theme memo
#'
#' @export
#'
my_theme <- function(){
  theme_bw() +
    theme(panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          plot.title = element_text(hjust = 0.5,size = 15),
          legend.text = element_text(size = 12),
          legend.title = element_text(size = 14),
          axis.title.x = element_blank(),
          axis.title.y = element_text(size = 15),
          axis.text.x = element_text(color = 'black',size = 12,angle = 45,hjust = 1),
          axis.text.y = element_text(color = 'black',size = 12),
          axis.ticks.y.left = element_blank())
}
