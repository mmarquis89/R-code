#' Cluster Exemplar Array
#' 
#' This function returns the an array of cluster examplars given the cluster numbers.
#' @param cluster_list This is the list of cluster numbers.
#' @export
#' @examples 
#' cluster_exemplar_array(1:10)

cluster_exemplar_array <- function(cluster_list)
{
  results = vector()
  for (cluster_no in cluster_list){
    results = c(results,cluster_exemplar(cluster_no))
  }
  return(results)
}