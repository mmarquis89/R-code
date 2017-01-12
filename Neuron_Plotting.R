
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

targetNeuron = "fru-F-700078"

mainLabels <- c("LH_L", "SIP_L", "SLP_L", "SMP_L", "AVLP_L", "CRE_L", "MB_ML_L", "MB_PED_L", "MB_VL_L", "PVLP_L", "SCL_L", "ICL_L", "IPS_L", "SPS_L") 
activeLabels = mainLabels[c(10,11,12,13,14)]
al <- 0.5

while (TRUE){
  
  # Plot region labels if applicable
  if(!is.na(activeLabels[1])){
    fcwbnpsurf(activeLabels, alpha=al)
  }
  
  # Plot selected neuron
  plot3dfc(targetNeuron, col = 'red', soma = TRUE, db=dps)
  #print(paste("Cluster:", targetCluster))
  
  neuronIn <- type.convert(readline(prompt="Enter neuron to plot, 'x' to exit "), as.is=TRUE)
  
  npop3d(rgl.ids()$id[2:length(rgl.ids()$id)])
  
  if (neuronIn == "x") {
    break
  }
  
  targetNeuron = neuronIn
  
}
