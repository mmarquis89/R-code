#' Cluster Scan
#' 
#' This function scans through a list of clusters (integers), allowing the user to select clusters that will be returned as an array of integers.
#' @param clusterlist List of cluster numbers to scan through. Default is 1:1052.
#' @param color has default 'magenta1'
#' @export
#' @examples 
#' cluster_scan(1:10)

cluster_scan <- function(clusterlist = 1:1052, color = 'black'){
  
  results <- vector()
  i=1
  while (i<length(clusterlist)+1){
    cluster_no = clusterlist[i]
    plot_cluster(cluster_no, 'black')
    choice <- readline(prompt=paste("C#:",toString(cluster_no),", Enter 'y' to select, 'b' to go back, 'c' to cancel, or [enter] to continue  "))
    if (choice == "c"){
      npop3d(slow=FALSE)
      break
    } else if (choice == "y"){
      npop3d(slow=FALSE)
      results = c(results, cluster_no)
      i = i+1
    } else if (choice == "b"){
      npop3d(slow=FALSE)
      i = i-1
    } else{
      npop3d(slow=FALSE)
      i = i+1
    }
  }
  return(results)
}