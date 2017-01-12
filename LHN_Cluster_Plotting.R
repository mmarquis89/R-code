
setwd('C:/Users/Wilson Lab/Documents/R/R code')

# Allow production of figures using RGL
library(knitr)
library(rgl)
knit_hooks$set(rgl = hook_rgl)
opts_chunk$set(dev=c('png','pdf'))

# Load flycircuit and nat packages
library(flycircuit)
library(nat)
library(nat.nblast)
library(nat.flybrains)

# Load data
dps <-read.neuronlistfh('C://Users//Wilson Lab//Documents//R//R code//rpkg-flycircuit//data//dpscanon.rds')
LHNs <- read.csv("FlyCircuitLHNs.csv")
clusterInfo <- read.csv("DownstreamClusters.csv")
clusterList <- read.csv("DownstreamClusterList.csv")
LHN_clusters <- read.csv("LHN_clusters.csv")
LHN_clusterList <- read.csv("LHNClusterList.csv")
regionLabels <- read.csv("RegionLabels.csv")

validLHNs <-LHNs[LHNs$Available_in_Jefferis_data == 'Yes', ]
LHN_types <- sort(unique(validLHNs$Type))
downstreamClusters <- unique(clusterList$Cluster)
LHNs <- unique(LHN_clusterList$Cluster)
miscLHNs <- validLHNs$FlyCircuit_ID[grep("^Aty", validLHNs$Type)]

# Initiate Plotting window
plot3d(FCWB)

# Loop through plots
counterI = 1
counterJ= 1

lenI <- length(miscLHNs)
lenJ <- length(downstreamClusters)

targetCluster = 28
targetLHN = 339

mainLabels <- c("LH_L", "SIP_L", "SLP_L", "SMP_L", "AVLP_L", "CRE_L", "MB_ML_L", "MB_PED_L", "MB_VL_L", "PVLP_L") 
activeLabels = mainLabels[c(2,3,6,10)]
al <- 0.5
  
while (TRUE){
  
  # Plot region labels if applicable
  if(!is.na(activeLabels[1])){
    fcwbnpsurf(activeLabels, alpha=al)
  }
  
  # Plot selected downstream cluster
  plot3dfc(as.character(clusterList$Neuron)[clusterList$Cluster == targetCluster], col = 'red', soma = TRUE, db=dps)
  print(paste("Cluster:", targetCluster))
  
  if(is.numeric(targetLHN)){
    # Plot LHN cluster if applicable
    plot3dfc(as.character(LHN_clusterList$Neuron[LHN_clusterList$Cluster == targetLHN]), col = 'blue', soma = TRUE, db=dps)
    print(paste('LHN cluster:', targetLHN))
  } else {
    # Plot LHN type if applicable
    plot3dfc(as.character(validLHNs$FlyCircuit_ID[validLHNs$Type == targetLHN]), col = 'blue', soma = TRUE, db=dps)
    print(paste('LHN type:', targetLHN))
    }
  
  clusterIn <- readline(prompt="Enter cluster ID to plot, 'x' to exit, or [enter] to continue with current cluster ")
  LHNIn <- type.convert(readline(prompt="Enter LHN(s) to plot, 'x' to exit, or [enter] to continue with current LHN(s) "), as.is=TRUE)
  
  # Clear every rgl object except the first (i.e. FCWB)
  npop3d(rgl.ids()$id[2:length(rgl.ids()$id)])
  
  if (clusterIn == "x" || LHNIn == "x") {
    break
  }
  
  if (clusterIn != ""){
    targetCluster = clusterIn
  }
  
  if (LHNIn != ""){
    targetLHN = LHNIn
  }
  
}
