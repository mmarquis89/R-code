
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
highConf <- c("TH-F-000005","TH-F-000011","TH-M-000071","TH-M-000030","TH-M-000013","TH-F-300067","TH-F-100046","TH-F-000012",
                "TH-F-100101", "TH-F-300078")
lowConf <- c("TH-F-000007","TH-M-100021","TH-M-100041","TH-M-100044","TH-M-100071","TH-M-200035","TH-M-200052","TH-M-200056",
             "TH-M-200062","TH-M-100010","TH-M-100008","TH-M-100006","TH-M-100005","TH-M-000069","TH-M-000042","TH-M-000031",
             "TH-F-300052","TH-F-300004","TH-F-200035","TH-F-100110","TH-F-100105","TH-F-000098","TH-F-000086","TH-F-000081",
             "TH-F-000037","TH-M-300048")
allCells <-c("TH-F-000005","TH-F-000011","TH-M-000071","TH-M-000030","TH-M-000013","TH-F-300067","TH-F-100046","TH-F-000012",
             "TH-F-100101", "TH-F-300078","TH-F-000007","TH-M-100021","TH-M-100041","TH-M-100044","TH-M-100071","TH-M-200035","TH-M-200052","TH-M-200056",
             "TH-M-200062","TH-M-100010","TH-M-100008","TH-M-100006","TH-M-100005","TH-M-000069","TH-M-000042","TH-M-000031",
             "TH-F-300052","TH-F-300004","TH-F-200035","TH-F-100110","TH-F-100105","TH-F-000098","TH-F-000086","TH-F-000081",
             "TH-F-000037","TH-M-300048")
regionLabels <- read.csv("RegionLabels.csv")

# Initiate Plotting window
plot3d(FCWB)

# Loop through plots
counterI = 1

currSet <- allCells

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
  plot3dfc(currSet[counterI], col = 'red', soma = TRUE, db=dps)
  print(paste("Neuron:", currSet[counterI]))
  
  inputChar <- readline(prompt="Enter to plot next neuron, 'x' to exit ")
  
  npop3d(rgl.ids()$id[2:length(rgl.ids()$id)])
  
  if(inputChar == ""){
    if(counterI == length(currSet)){
      counterI = 1
    }else{
      counterI = counterI + 1
    }
  } else if(inputChar == "x"){
    break
  }
}
rgl.close()
