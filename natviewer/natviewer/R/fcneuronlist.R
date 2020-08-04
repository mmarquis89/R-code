#' Return neurons
#' 
#' This function returns the neuron belonging to a given fc name as a neuronlist.
#' @param fcneuronnames This is the name of the neuron (i.e. "fru-M-200145")
#' @export
#' @examples 
#' fcneuronlist(c("fru-M-200145", "fru-M-200500"))

fcneuronlist <- function(fcneuronnames){
  return (subset(dps, which(fc_neuron(idid) %in% fcneuronnames)))
}