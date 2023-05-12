
#' my_liftover
#'
#' @param peaks
#' @param from_to 'hg19_hg38'
#'
#' @return
#' @export
#'
#' @examples
my_liftover <- function(peaks,from_to = 'hg19_hg38'){
  if(from_to == 'hg19_hg38') {
    path <- '/mdshare/node8/txmdata/scATAC_seq/AtacAnnoR/data/genome_files/hg19ToHg38.over.chain'
    ch <- rtracklayer::import.chain(path)
    one_liftover <- function(peak){Signac::GRangesToString(rtracklayer::liftOver(Signac::StringToGRanges(peak), ch)[[1]][1])}
    # one_liftover('chr19-44821468-44827058')
    if(length(peaks) > 1000){
      out_peaks <- pbmcapply::pbmclapply(peaks,one_liftover,mc.cores = 10) %>% unlist()
    } else{
      out_peaks <- lapply(peaks,one_liftover) %>% unlist()
    }
  }
  return(out_peaks)
  # which(hg38_peaks == '--')
}

