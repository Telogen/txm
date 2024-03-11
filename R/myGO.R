
#' myGO
#'
#' @param genes
#'
#' @return
#' @export
#'
#' @examples
myGO <- function(genes,title = NULL,term_num = 10){
  library(clusterProfiler)
  library(org.Hs.eg.db)
  x <- genes
  eg <- clusterProfiler::bitr(x, fromType="SYMBOL", toType=c("ENTREZID","ENSEMBL"),
                              OrgDb="org.Hs.eg.db")
  genelist <- eg$ENTREZID
  genelist <- genelist[-duplicated(genelist)]
  go <- enrichGO(genelist, OrgDb = org.Hs.eg.db, ont='ALL',pAdjustMethod = 'BH',
                 pvalueCutoff = 0.05,qvalueCutoff = 0.2,keyType = 'ENTREZID')
  if(is.null(go)){
    return('no significant GO term')
  } else{
    dotplot(go,showCategory = term_num) + ggtitle(title)
  }
}
