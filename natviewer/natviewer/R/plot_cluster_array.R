#' Plot Array of Clusters
#' 
#' This function plots an array of clusters. It takes input of array of cluster number as integers from 1 to 809.
#' @param cluster_no array of cluster numbers
#' @param color Can set all clusters to a single color; defaults to plottting each cluster randomly among rainbow.
#' @export
#' @examples 
#' plot_cluster_array(1:809, color = 'blue')

plot_cluster_array <- function(cluster_list, color = NULL)
{
  for (cluster_no in cluster_list){
    if (is.null(color)){
      plot_cluster(cluster_no, color = rainbow(10)[sample(length(rainbow(10)),1)])
    }else{
      plot_cluster(cluster_no, color)
    }
    
  }
}