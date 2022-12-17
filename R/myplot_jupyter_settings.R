#' my_plot_jupyter_settings
#'
#' @param width
#' @param height
#'
#' @return todo
#' @export
#'
myplot_jupyter_settings <- function(width = 10,height = 10){
  options(repr.plot.width=width, repr.plot.height= height, repr.plot.res=120)
}


