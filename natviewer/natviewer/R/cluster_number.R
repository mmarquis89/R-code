#' Cluster Number
#' 
#' This function returns the cluster number that a particular neuron belongs to.
#' @param neuron_name This is the neuron name (i.e. "fru-M-200145")
#' @export
#' @examples 
#' cluster_number("fru-M-200145")

cluster_number <- function(neuron_names){
  list = NULL;
  for (neuron in neuron_names){
    list = c(list, apdf$cluster[apdf$item == fc_gene_name(neuron)])
  }
  
  return(list)
}