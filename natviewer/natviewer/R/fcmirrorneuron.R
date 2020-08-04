#' Mirror neurons
#' 
#' This function returns the mirrored neuron. The bounding box is the FCWB.surf.
#' @param fcneuron This is the name of the original neuron.
#' @export
#' @examples 
#' fcmirrorneuron("fru-M-200145")

fcmirrorneuron <- function(fcneuron){
  neuron = mirror(subset(dps, idid==fc_idid(fcneuron)), boundingbox(FCWB.surf), mirrorAxis = 'X', transform = 'flip')
  return(neuron)
}