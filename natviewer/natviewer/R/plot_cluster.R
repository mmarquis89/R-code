#' Plot Single Cluster
#' 
#' This function plots a single cluster. It takes input of cluster number as an integer from 1 to 809.
#' @param cluster_no Integer of cluster number.
#' @param color Can set color; defaults to a random color in the existing palette.
#' @export
#' @examples 
#' plot_cluster(1, color = 'blue')

plot_cluster <- function(cluster_no, color=palette()[sample(length(palette()),1)]){
  list <- apdf$item[apdf$cluster==cluster_no]
  plot3dfc(list, col = color)
}