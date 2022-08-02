#' Add a line in ggplot
#'
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
              size = .5)     # 粗细
}



#' geom_text memo
#'
#' @export
#'
myplot_text <- function(){
  geom_text(aes(label = paste0(round(GMMseeds,2),' -> ',round(KNNseeds,2)),
                hjust = -.1,     # 向右移
                vjust = -.1))     # 向上移
}


#' Density plot
#'
#' @export
#'
myplot_density <- function(){
  # 根据count数调整密度图高度
  ggplot(data, aes(x, fill = group.by, colour = group.by)) +
    geom_density(aes(y = after_stat(count),alpha = 0.5)) +
    scale_fill_manual(values=c("#00BFC4", "#F8766D")) +
    scale_color_manual(values=c("#00BFC4", "#F8766D"))
  # 上下拉满
  ggplot(data, aes(x, fill = group.by, colour = group.by)) +
    geom_density(position = "fill",aes(y = after_stat(count),alpha = 0.5)) +
    scale_fill_manual(values=c("#00BFC4", "#F8766D")) +
    scale_color_manual(values=c("#00BFC4", "#F8766D"))
  # 累加密度
  ggplot(data, aes(x, fill = group.by, colour = group.by)) +
    geom_density(position = "fill",aes(y = after_stat(count),alpha = 0.5)) +
    scale_fill_manual(values=c("#00BFC4", "#F8766D")) +
    scale_color_manual(values=c("#00BFC4", "#F8766D"))
}


#' Scatter plot with density plot of x and y axis
#'
#' @export
#'
myplot_scatter_with_density <- function(){
  # 点图
  p1 <- ggplot(data) +
    geom_point(aes(x = GMSS, y = NMSS, size = size.by, color = group.by, shape = shape.by)) +
    scale_size(range = c(0.1, 3))
  # x轴的密度图
  p2 <- ggplot(data, aes(x = GMSS, color = group.by)) +
    geom_density(aes(y = after_stat(count), fill = group.by,
                     alpha = 0.2)) + scale_y_continuous(expand = c(0,0)) +
    theme_void() +
    NoLegend() +
    ggtitle('') +
    theme(axis.title = element_blank(),
          axis.text = element_blank(),
          axis.ticks = element_blank())
  # y轴的密度图
  p3 <- ggplot(DATA, aes(x = NMSS, color = group.by)) +
    geom_density(aes(y = after_stat(count), fill = group.by,
                     alpha = 0.2)) + scale_y_continuous(expand = c(0, 0)) +
    theme_void() +
    coord_flip() + NoLegend() +
    theme(axis.title = element_blank(),
          axis.text = element_blank(),
          axis.ticks = element_blank()) +
  # final plot
  p <- p1 %>%
    aplot::insert_top(p2, height = 0.2) %>%
    aplot::insert_right(p3, 0.2)

}




#' Barplot
#'
#' @export
#'
myplot_bar <- function(){
  ggplot(data,aes(x = dataset, y = value, fill = cells,group = cells)) +
    geom_bar(aes(color = cells),stat = "identity",position = position_dodge(width = 0.8,preserve = 'single'),width = 0.7) +
    geom_text(aes(label = round(value,2)),size = 3,position = position_dodge(.8),vjust = -0.2) +
    coord_cartesian(ylim = c(0, 1))

  # count作为高度
  ggplot(data = data,aes(x = Month)) +
    geom_bar(width = 0.8,aes(fill = Institute)) +
    geom_text(stat='count', aes(label=..count..), vjust= -0.1) +
    theme(axis.text.x = element_text(angle = 45, hjust = 0.5, vjust = 0.5))
}


#' Combine several ggplots
#'
#' @export
#'
myplot_combine <- function(){
  ggpubr::ggarrange(plotlist = list(p1,p2,p3,p4),ncol = 1,nrow = 4)
}




#' Heatmap with fraction inside
#'
#' @export
#'
myplot_heat <- function(){
  ggplot(predictions, aes(Var1, Var2, fill = Freq)) +
    geom_tile()
    scale_fill_gradient(name = "Number of cells",low = "#ffffc8", high = "#7d0025")  +
    xlab("Predicted cell type") +
    ylab("True cell type") +
    theme_cowplot() +
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1)) +
    geom_text(aes(label = round(Freq * 100,2)),size = 3)
}


#' myplot_pie
#'
#' @export
#'
myplot_pie <- function(){
  pie_data <- data.frame(table(data$Institute))
  colnames(pie_data) <- c('Institutes','Freqency')
  pie_data$Percentage = pie_data$Freq/sum(pie_data$Freq)*100
  pie_data$label = rev(paste0(pie_data$Institutes,'\n',pie_data$Freqency,'篇\n',round(pie_data$Freq/sum(pie_data$Freq)*100,2),'%'))
  fig2 <- ggplot(pie_data, aes(x = "", y = Percentage, fill = Institutes)) +
    geom_bar(stat = "identity") +
    coord_polar(theta = "y") +
    geom_text(aes(y= 100-(cumsum(Percentage)-Percentage/2), x= 1.1),
              label = rev(pie_data$label)) +
    labs(x = '', y = '') +
    cowplot::theme_nothing()
}


