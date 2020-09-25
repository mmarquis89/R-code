
library(neuprintr)
library(hemibrainr)
library(colormap)
library(base)

# ==================================================================================================
# LOCAL FUNCTIONS
# ==================================================================================================

# Returns (uniqueROIs, segROIs)
assign_ROIs <- function(pointsList, segList, roiList, roiMeshes) {
  
  # Determine which points belong to which ROIs
  print('Assigning ROIs to points...')
  pointROIs = vector(mode="character", nrow(pointsList))
  for (iRoi in 1:length(roiList)){
    currROI = roiList[iRoi]
    currROI_points = pointsinside(pointsList, surf=roiMeshes[[iRoi]])
    pointROIs[currROI_points] = currROI
  }
  pointROIs[pointROIs == ""] = "None"
  pointsList$roiNames = pointROIs;
  uniqueROIs = unique(pointsList$roiNames)
  
  # Determine which segments belong to which ROIs (going by most common point ROI)
  print("Assigning ROIs to segments...")
  segROIs = vector(mode="character", length(segList))
  for (iSeg in 1:length(segList)){
    segPoints = pointsList[segList[[iSeg]],]
    currRoiNames = segPoints$roiNames
    if (any(currRoiNames != "None")){
      segROIs[iSeg] = names(sort(table(segPoints$roiNames[segPoints$roiNames != "None"])))[1]  
    }else{
      segROIs[iSeg] = "None"
    }
  }
  return(list("uniqueROIs" = uniqueROIs, "segROIs" = segROIs))
}

# Returns (roiColors)
assign_colors <- function(currData, uniqueROIs, cmapName, nShades){
  print('Assigning colors to ROIs...')
  cm = colormap(colormap=colormaps[[cMapName]], nshades=nShades)
  if (cMapName == "bluered"){
    cm = rev(cm)
  }
  roiColors = vector(mode="character")
  for (iRoi in 1:length(uniqueROIs)){
    if (uniqueROIs[iRoi] == "None"){
      roiColors[iRoi] = "#000000"
    }else{
      roiColors[iRoi] = cm[1 + currData$pctPre[currData$roiName == uniqueROIs[iRoi]]]
    }
  }
  
  return(roiColors)# Return values
}

# ==================================================================================================  

conn = neuprint_login()

# Load list of brain region ROIs
roiList = c('AL(R)',	'AVLP(R)',	'CA(R)', 'CRE(R)',	'EPA(R)',	'FLA(R)',	'GNG',	'GOR(R)',	'IB',
            'ICL(R)',	'IPS(R)',	'LAL(R)',	'LH(R)',	'PED(R)',	'PLP(R)',	'POC',	'PRW',	'PVLP(R)',
            'SAD', 'SCL(R)',	'SIP(R)',	'SLP(R)',	'SMP(R)',	'SPS(R)',	'VES(R)',	'WED(R)')

# Load the meshes for each ROI
print('Loading ROI meshes...')
roiMeshes = list()
for (i in 1:length(roiList)){
  roiMeshes[[i]] = neuprint_ROI_mesh(roiList[i])  
}

# Load synapse count data
df = read.csv(paste("C:\\Users\\Wilson Lab\\Google Drive\\Lab Work\\LH-DAN_connectomics_analysis", 
                    "\\prePost_synapse_count_data.csv", sep=""))

queryNeuronIDs = c("328533761", "294436967", "792040520", "950229431")
cMapNames = c("viridis", "plasma", "bluered")
for (iCell in 1:length(queryNeuronIDs)){
  
  # Load query neuron
  print('Fetching neuron data...')
  queryNeuronID = queryNeuronIDs[iCell]
  queryNeuron = neuprint_read_neurons(queryNeuronID)
  queryNeuron = queryNeuron[[1]]
  pointsList = queryNeuron$d
  segList = queryNeuron$SegList
  
  # Select subset of synapse count data by current query neuron
  currData = df[df$bodyID == queryNeuronID,]
  
  # Assign ROIs to all segments
  output = assign_ROIs(pointsList, segList, roiList, roiMeshes)
  uniqueROIs = output$uniqueROIs
  segROIs = output$segROIs
  
  for (iPlot in 1:length(cMapNames)){
    
    # Create colormap and assign colors to each brain region
    cMapName = cMapNames[iPlot]
    roiColors = assign_colors(currData, uniqueROIs, cmapName, 100)
    
    # Open new plotting window
    nopen3d()
    par3d(windowRect=c(50, 50, 1000, 900))
    
    # Loop through and plot neuron segments for each ROI in the appropriate color 
    print("Plotting lines...")
    t1 = Sys.time()
    for (iSeg in 1:length(segList)){
      segRoiName = segROIs[iSeg];
      currCol = roiColors[uniqueROIs == segRoiName]
      currSegPoints = pointsList[segList[[iSeg]], ]
      lines3d(currSegPoints$X, currSegPoints$Y, currSegPoints$Z, col=currCol, lwd=2)
    } 
    t2 = Sys.time()
    print(t2 - t1)
  
  }
}
# TODO: 
#   Allow for averaging the two PPM1201 neuron's brain region percentages together for plotting
# 
# # 
# devList = rgl.dev.list()
# sceneList = vector(mode="list", length(devList))
# for (i in 1:length(devList)){
#   print(i)
#   rgl.set(devList[[i]])
#   sceneList[[i]] = scene3d()
}
# save("sceneList", file="C:\\Users\\Wilson Lab\\Documents\\MATLAB\\R-code\\colormap_test_scenes_allTypes_full_range.RData")
