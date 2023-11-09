#' volcano_plot
#'
#' @param de_genes
#' @param log2FC
#' @param padj
#' @param highlight_num
#'
#' @return
#' @export
#'
volcano_plot <- function(de_genes, log2FC = 0.2, padj = 0.05,highlight_num = 10){
  library(Seurat)
  library(tidyverse)
  library(ggrepel)

  # log2FC = 0.2
  # padj = 0.05
  # highlight_num <- 10

  cluster1.markers <- de_genes
  cluster1.markers$threshold="ns";
  cluster1.markers[which(cluster1.markers$avg_log2FC  > log2FC & cluster1.markers$p_val_adj <padj),]$threshold="up";
  cluster1.markers[which(cluster1.markers$avg_log2FC  < (-log2FC) & cluster1.markers$p_val_adj < padj),]$threshold="down";
  cluster1.markers$threshold=factor(cluster1.markers$threshold, levels=c('down','ns','up'))
  cluster1.markers$name <- ''
  cluster1.markers$name[1:highlight_num] <- rownames(cluster1.markers)[1:highlight_num]

  ggplot(data=cluster1.markers, aes(x=avg_log2FC, y=-log10(p_val_adj), color=threshold)) +
    geom_point(alpha=0.8, size=0.8) +
    geom_text_repel(aes(label = name)) +
    geom_vline(xintercept = c(-log2FC, log2FC), linetype=2, color="grey")+
    geom_hline(yintercept = -log10(padj), linetype=2, color="grey")+
    xlab(bquote(Log[2]*FoldChange))+
    ylab(bquote(-Log[10]*italic(P.adj)) )+
    theme_classic(base_size = 14) +
    scale_color_manual('',labels=c(paste0("down(",table(cluster1.markers$threshold)[[1]],')'),'ns',
                                   paste0("up(",table(cluster1.markers$threshold)[[3]],')' )),
                       values=c("blue", "grey","red" ) )+
    guides(color=guide_legend(override.aes = list(size=3, alpha=1)))

}
