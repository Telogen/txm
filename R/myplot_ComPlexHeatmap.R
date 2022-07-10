#' ComPlexHeatmap memo code
#'
#' @return
#' @export
#'
myplot_Heatmap <- function(){
  Heatmap(data,
          cluster_rows = F,cluster_columns = F,show_column_names = F,show_row_names = T,
          bottom_annotation = HeatmapAnnotation(celltype = labels))
}













