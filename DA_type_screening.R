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
DA_neurons <- read.csv("DA_types.csv")
regionLabels <- read.csv("RegionLabels.csv")
DA_types <- sort(unique(DA_neurons$Type))


# Initiate Plotting window
plot3d(FCWB)

# Loop through plots
counterI <- 1
counterJ <- 1

mainLabels <- c("AL_L","AVLP_L","CRE_L","FLA_L","GNG",
                "IB_L","ICL_L","IPS_L","IVLP_L","LAL_L",
                "LH_L","MB_ML_L","MB_PED_L","MB_VL_L","PLP_L",
                "PRW","PVLP_L","SAD","SCL_L","SIP_L",
                "SLP_L","SMP_L","SPS_L","VES_L") 
activeLabels = mainLabels[c(17,19)]
al <- 0.5

while (TRUE){
  
  # Plot region labels if applicable
  if(!is.na(activeLabels[1])){
    fcwbnpsurf(activeLabels, alpha=al)
  }
  
  # Plot selected neuron
  # plot3dfc(currSet[counterI], col = 'red', soma = TRUE, db=dps)
  # print(paste("Neuron:", currSet[counterI]))
  # 
  # Plot next neuron type
  plot3dfc(as.character(DA_neurons$NeuronID[DA_neurons$Type==DA_types[counterI]]), color = 'green', soma=TRUE, db=dps)
  if(counterI < length(DA_types)){
    plot3dfc(as.character(DA_neurons$NeuronID[DA_neurons$Type==DA_types[counterI+1]]), color = 'red', soma=TRUE, db=dps)
  }
  
  # # Highlight each neuron in a cluster
  # plot3dfc(as.character(DA_neurons$NeuronID[DA_neurons$Type=="1A"][counterI]), color = 'green', soma=TRUE, db=dps)
  # plot3dfc(as.character(DA_neurons$NeuronID[DA_neurons$Type=="1A"]), color = 'red', soma=TRUE, db=dps)
  
  print(paste("Neuron type: ", DA_types[counterI]))
  inputChar <- readline(prompt="[Enter] to plot next type \n 'p' for previous type \n 'x' to exit ")
  
  npop3d(rgl.ids()$id[2:length(rgl.ids()$id)])
  
  if(inputChar == ""){
    if(counterI == length(DA_types)){
      counterI = 1
    }else{
      counterI = counterI + 1
    }
  }else if(inputChar== "p"){
      counterI = counterI - 1
  }else if(inputChar == "x"){
    break
  }
}
rgl.close()