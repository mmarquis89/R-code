#' Pop Cluster
#' 
#' This function pops a cluster from the viewer.
#' @param cluster_no cluster number
#' @export
#' @examples 
#' pop_cluster(1)

pop_cluster <- function(cluster_no){
  list <- apdf$item[apdf$cluster==cluster_no]
  pop3dfc(list)
}