
# Load neuron
typeC <- read.neuron('C:/Users/Wilson Lab/Google Drive/Lab Work/Type C tracing files/2017_May_29_exp1-000.swc-000.swc', class="neuron")
# part1 <- test[[1]]
# realNeuron <- part1

# Load registration
path <- "C:/Users/Wilson Lab/Documents/MATLAB/R-code/Registration/Registration/warp/FCWB_biocytin_01_warp_m0g80c8e1e-1x26r4.list/registration.txt"

# Apply registration
x <- as.cmtkreg(path)
typeCReg <- xform(typeC, x)

# Plot registered neuron
plot3d(typeCReg)

# Add the original brain to the 3D display, for context
plot3d(FCWB) # IS2, JFRC2, FCWB, T1, IBNWB, Cell07

# Write the registered neuron to an .swc file
write.neuron(typeCReg, 'C:/Users/Wilson Lab/Documents/MATLAB/registeredNeuron', format='swc')

# Make sure file saved correctly
myNeuron = read.neuron('C:/Users/Wilson Lab/Documents/MATLAB/registeredNeuron.swc', class='neuron')
plot3d(myNeuron, WithNodes = FALSE, col = 'red')
plot3d(FCWB)


exemplarA <- "TH-F-300078"
exemplarB <- "TH-F-100046"
exemplarC <- typeC
exemplarD <- "TH-F-300067"
exemplarPPM2 <- "TH-M-100010"
exemplarANT <- "TH-M-000048"
exemplarANT_PLPC <- "TH-F-000023"


dps<-read.neuronlistfh("http://flybrain.mrc-lmb.cam.ac.uk/si/nblast/flycircuit/dpscanon.rds",
                       localdir=getOption('flycircuit.datadir'))


# DAN type examples
listA <- c("TH-F-300078", "TH-M-000071", "TH-F-000011")
listB <- c("TH-F-000012", "TH-F-100046", "TH-M-000013", "TH-M-000030")
listD <- c("TH-F-300052", "TH-F-300067", "TH-M-000042", "TH-M-200035", "TH-M-300048")

plot3d(FCWB)
plot3dfc(exemplarA, db=dps, col='blue')
plot3dfc("VGlut-F-200115", db = dps, col='red')











plot3d(FCWB)

# Clear every rgl object except the first (i.e. FCWB)
npop3d(rgl.ids()$id[2:length(rgl.ids()$id)])

#plot3d(typeC, WithNodes = FALSE, col = 'blue')
plot3dfc(exemplarANT_PLPC, db=dps, col = 'blue')

mainLabels <- c("AL_L","AVLP_L","CRE_L","FLA_L","GNG",
                "IB_L","ICL_L","IPS_L","IVLP_L","LAL_L",
                "LH_L","MB_ML_L","MB_PED_L","MB_VL_L","PLP_L",
                "PRW","PVLP_L","SAD","SCL_L","SIP_L",
                "SLP_L","SMP_L","SPS_L","VES_L", "ATL_L") 


mirrorLabels <- c("AL_R", "AVLP_R","CRE_R","FLA_R","GNG",
                  "IB_R","ICL_R","IPS_R","IVLP_R","LAL_R",
                  "LH_R","MB_ML_R","MB_PED_R","MB_VL_R","PLP_R",
                  "PRW","PVLP_R","SAD","SCL_R","SIP_R",
                  "SLP_R","SMP_R","SPS_R","VES_R", "ATL_R")  


activeLabels <- mainLabels[c(11, 19, 7, 8, 23, 25)]

# Plot region labels if applicable
if(!is.na(activeLabels[1])){
  fcwbnpsurf(activeLabels, alpha=0.4)
}

