#' Cluster Exemplar
#' 
#' This function returns the cluster examplar as the gene name.
#' @param cluster_no This is the cluster number, as an int.
#' @export
#' @examples 
#' cluster_exemplar(150)

cluster_exemplar <- function(cluster_no){
  return(as.character(apdf$exemplar[apdf$cluster==cluster_no][1, drop=TRUE]))
}