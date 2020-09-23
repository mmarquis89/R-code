library(neuprintr)
library(hemibrainr)
library(colormap)

conn = neuprint_login()

# Load query neuron
queryNeuronID = "294436967"
queryNeuron = neuprint_read_neurons(queryNeuronID)
queryNeuron = queryNeuron[[1]]
pointsList = queryNeuron$d
segList = queryNeuron$SegList

# Load list of brain region ROIs
roiList = c('AL(R)',	'AVLP(R)',	'CA(R)', 'CRE(R)',	'EPA(R)',	'FLA(R)',	'GNG',	'GOR(R)',	'IB',
            'ICL(R)',	'IPS(R)',	'LAL(R)',	'LH(R)',	'PED(R)',	'PLP(R)',	'POC',	'PRW',	'PVLP(R)',
            'SAD', 'SCL(R)',	'SIP(R)',	'SLP(R)',	'SMP(R)',	'SPS(R)',	'VES(R)',	'WED(R)')

# Load synapse count data
df = read.csv(paste("C:\\Users\\Wilson Lab\\Google Drive\\Lab Work\\LH-DAN_connectomics_analysis", 
                    "\\prePost_synapse_count_data.csv", sep=""))

# Select subset of synapse count data by current query neuron
currData = df[df$bodyID == queryNeuronID,]

# Create colormap and assign colors to each brain region
cm = colormap(colormap=colormaps$viridis, nshades=100)

# Open new plotting window
nopen3d()
par3d(windowRect=c(50, 50, 1000, 900))

# Loop through and plot neuron segments for each ROI in the appropriate color 
for (i in 1:length(roiList)){
  currROI = roiList[i]
  print(currROI)
  currROI_mesh = neuprint_ROI_mesh(currROI)
  currROI_points = pointsinside(pointsList, surf=currROI_mesh)
  if (any(currROI_points)){
    for (i in 1:length(segList)){
      currX = pointsList$X[segList[[i]]]
      currY = pointsList$Y[segList[[i]]]
      currZ = pointsList$Z[segList[[i]]]
      
      inROI = currROI_points[segList[[i]][1]]
      
      if (inROI == TRUE) {
        currCol = cm[currData$pctPre[currData$roiName == currROI]]
        lines3d(currX, currY, currZ, col=currCol, lwd=2)
      }
    }
  }
}

# TODO: 
#   Increase colormap visual contrast by scaling from 0-67 and/or choosing a different one
#   Load all meshes into a list first and then refer back to them (for potential plotting later)
#   Make sure the points that fall outside any of the brain regions (e.g. primary neurite) get plotted
#   Allow for averaging the two PPM1201 neuron's brain region percentages together for plotting
#   Figure out why the fuck I can't plot PPL201 without getting an error



