plot_density <- function(data,x,y = NULL,group.by = NULL,size.by = NULL,shape.by = NULL,mode = 'normal'){
  if(is.null(y)){
    if(mode == 'fill'){
      ggplot(data, aes_string(x, fill = group.by, colour = group.by)) +
        geom_density(position = "fill",aes(y = after_stat(count),alpha = 0.5)) +
        scale_fill_manual(values=c("#00BFC4", "#F8766D")) +
        scale_color_manual(values=c("#00BFC4", "#F8766D"))
    } else if(mode == 'aggragate'){
      ggplot(data, aes_string(x, fill = group.by, colour = group.by)) +
        geom_density(position = "fill",aes(y = after_stat(count),alpha = 0.5)) +
        scale_fill_manual(values=c("#00BFC4", "#F8766D")) +
        scale_color_manual(values=c("#00BFC4", "#F8766D"))
    } else if(mode == 'normal'){
      ggplot(data, aes_string(x, fill = group.by, colour = group.by)) +
        geom_density(aes(y = after_stat(count),alpha = 0.5)) +
        scale_fill_manual(values=c("#00BFC4", "#F8766D")) +
        scale_color_manual(values=c("#00BFC4", "#F8766D"))
    }
  } else{
    p1 <- ggplot(data) +
      geom_point(aes_string(x = x, y = y, size = size.by, color = group.by, shape = shape.by)) +
      scale_size(range = c(0.1, 3))
    p2 <- ggplot(data, aes_string(x = x, color = group.by)) +
      geom_density(aes(y = after_stat(count), fill = group.by,
                       alpha = 0.2)) + scale_y_continuous(expand = c(0,0)) +
      theme_void() +
      theme(axis.title = element_blank(),axis.text = element_blank()) +
      NoLegend() +
      ggtitle(paste0(DATA$kendall_pred[1],
           " T:", table(DATA$kendall_pred_booltrue)["TRUE"],
           " F:", table(DATA$kendall_pred_booltrue)["FALSE"])) +
      theme(plot.title = element_text(hjust = 0)) + theme(plot.title = element_text(vjust = -3))
    p3 <- ggplot(DATA, aes(x = y, color = group.by)) +
      geom_density(aes(y = after_stat(count), fill = group.by,
                       alpha = 0.2)) + scale_y_continuous(expand = c(0, 0)) +
      theme_void() +
      theme(axis.title = element_blank(), axis.text = element_blank(), axis.ticks = element_blank()) +
      coord_flip() + NoLegend()
    p <- p1 %>% insert_top(p2, height = 0.2) %>% insert_right(p3, 0.2)
  }
}
