
#setwd('C:/Users/Wilson Lab/Documents/R/R code')

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
dps <-read.neuronlistfh('C://Users//Wilson Lab//Documents//R//rpkg-flycircuit//data//dpscanon.rds')
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

mainLabels <- c("LH_L", "SIP_L", "SLP_L", "SMP_L", "AVLP_L", "CRE_L", "MB_ML_L", "MB_PED_L", "MB_VL_L", "PVLP_L") 
activeLabels = mainLabels[c(2,3,6,10)]
al <- 0.2

# Loop through plots
counterI = 1
counterJ= 1

lenI <- length(LHN_types)
lenJ <- length(downstreamClusters)

while (TRUE){

  # Plot region labels if applicable
  if(!is.na(activeLabels[1] )){
    fcwbnpsurf(activeLabels, alpha=al)
  }
  
  # CLUSTER EXEMPLARS (I)
  #plot3dfc(as.character(clusterInfo$Exemplar[counterI]), col='red', soma=TRUE, db=dps)
  #print(paste("Cluster:", clusterInfo$Cluster[counterI]))
  
  # INDIVIDUAL LHNS (J)
  #plot3dfc(as.character(validLHNs$FlyCircuit_ID[counterJ]), col='blue', soma=TRUE, db=dps)
  #print(paste("LHN:", validLHNs$FlyCircuit_ID[counterJ]))
  
  # LHN TYPES (I)
  plot3dfc(as.character(validLHNs$FlyCircuit_ID[(validLHNs$Type) == LHN_types[counterI]]), col = 'blue', soma=TRUE, db=dps)
  print(paste("LHN type:", LHN_types[counterI]))
  
  # DOWNSTREAM CLUSTERS (J)
  plot3dfc(as.character(clusterList$Neuron[clusterList$Cluster == downstreamClusters[counterJ]]), col = 'red', soma=TRUE, db=dps)
  #print(paste("Cluster:", downstreamClusters[counterJ]))
  
  # LHN CLUSTERS (J)
  #plot3dfc(as.character(LHN_clusterList$Neuron[LHN_clusterList$Cluster == LHNs[counterJ]]), col = 'red', soma=TRUE, db=dps)
  #print(paste("LHN cluster:", LHNs[counterJ]))
  
  # INDIVIDUAL ATYPICAL LHNS (J)
  #plot3dfc(as.character(miscLHNs[counterJ]), col = 'blue', soma=TRUE, db=dps)
  #print(paste("LHN type:", validLHNs$Type[validLHNs$FlyCircuit_ID==miscLHNs[counterJ]]))
  
  # INDIVIDUAL NEURONS OF A DOWNSTREAM CLUSTER (J)
  #clusterNeurons = clusterList$Neuron[clusterList$Cluster == 876]
  #plot3dfc(as.character(clusterNeurons[counterJ]), col='red', soma=TRUE, db=dps)
  #print(paste("Downstream neuron:", clusterNeurons[counterJ]))
  
  inputChar <- readline(prompt="[enter] for next J \n 'p' for previous J \n 'n' for next I \n 'b' for previous I \n 'x' to exit ")
  
  npop3d(rgl.ids()$id[2:length(rgl.ids()$id)])
  
  if(inputChar == ""){
      if(counterJ < lenJ) {
        counterJ <- counterJ + 1
      } else{
        counterJ = 1
        counterI = counterI + 1
      }
  } else if(inputChar== "p"){
      if(counterJ > 1){
        counterJ <- counterJ - 1
      }
  } else if(inputChar == "n"){
    counterJ = 1
      if(counterI < lenI){
        counterI = counterI + 1
      } else {
        counterI = 1
    }
  } else if(inputChar == "b"){
    counterJ = 1
    if(counterI > 1){
      counterI = counterI - 1
    }      
  } else if(inputChar == "x"){
    break
  }
}

