
myGO <- function(genes){
  library(clusterProfiler)
  library(org.Hs.eg.db)
  x <- genes
  eg <- bitr(x, fromType="SYMBOL", toType=c("ENTREZID","ENSEMBL"), OrgDb="org.Hs.eg.db"); head(eg)
  genelist <- eg$ENTREZID
  genelist <- genelist[-duplicated(genelist)]
  go <- enrichGO(genelist, OrgDb = org.Hs.eg.db, ont='ALL',pAdjustMethod = 'BH',pvalueCutoff = 0.05,
                 qvalueCutoff = 0.2,keyType = 'ENTREZID')
  barplot(go,showCategory=20,drop=T)
  dotplot(go,showCategory=50)
}
