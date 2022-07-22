#' Install R packages with C99 standard
#'
#' @param package.name R package name(s)
#' @param via 'CRAN' or 'bioc'(bioconductor)
#'
#' @export
#'
myinstall_with_C99 <- function(package.name,via = 'CRAN'){
  if(via == 'CRAN'){
    withr::with_makevars(c(PKG_CFLAGS = "-std=c11"),
                         install.packages(package.name),
                         assignment = "+=")
  } else if(via == 'bioc'){
    withr::with_makevars(c(PKG_CFLAGS = "-std=c11"),
                         BiocManager::install(package.name),
                         assignment = "+=")
  }
}


#' Install R package with specific version
#'
#' @export
#'
myinstall_version <- function(){
  # 方法1
  packageurl <- "https://cran.r-project.org/src/contrib/Archive/Seurat/Seurat_4.0.5.tar.gz"
  install.packages(packageurl, repos=NULL, type="source")
  # 方法2
  remotes::install_version(package = 'SeuratObject', version = package_version('4.0.2'))
}


#' Install local R package
#'
#' @export
#'
myinstall_local <- function(local.path){
  # local.path <- '/local/txm/software/SnapATAC-master.zip'
  devtools::install_local(local.path)
}




