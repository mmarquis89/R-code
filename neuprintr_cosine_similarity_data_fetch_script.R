library(neuprintr)
library(hemibrainr)

conn = neuprint_login()


neuronList = neuprint_search("PPM12.*|PPL.*|PAL.*|PLP210.*|PAM.*", field="name")

# # Just take the first neuron of each type for the PAM cluster
# PAMlist = PAMlist[match(unique(PAMlist$name), PAMlist$name),]

# neuronList = rbind(neuronList, PAMlist)

# neuronList = neuprint_search("PAM.*|PPL1.*", field="name")

for (i in 1:length(neuronList$bodyid)) {
  print(c(i, " of ", length(neuronList$bodyid)))
  
  # Get upstream and downstream partners for the current neuron ID
  us_partners = neuprint_simple_connectivity(neuronList$bodyid[i], prepost = "PRE", conn=conn)
  ds_partners = neuprint_simple_connectivity(neuronList$bodyid[i], prepost = "POST", conn=conn)
  
  if (length(us_partners) != length(ds_partners)){
    next
  }
  
  # Add directionality column and concatenate 
  us_partners$partnerDirection = "upstream"
  ds_partners$partnerDirection = "downstream"
  names(us_partners)[names(us_partners) == "input"] = "partnerID"
  names(ds_partners)[names(ds_partners) == "output"] = "partnerID"
  all_partners = rbind(us_partners, ds_partners)
  
  # Rename columns
  names(all_partners)[names(all_partners) == "name"] = "partnerName"
  names(all_partners)[names(all_partners) == "type"] = "partnerType"
  names(all_partners)[names(all_partners) == "input"] = "partnerID"
  names(all_partners)[names(all_partners) == paste(neuronList$bodyid[i], "_weight", sep = "")] = "synapseCount"
  
  # Add columns with information about the query neuron
  md = neuprint_get_meta(neuronList$bodyid[i])
  all_partners$neuronID = neuronList$bodyid[i]
  all_partners$neuronName = md$name
  all_partners$neuronType = md$type
  all_partners$status = md$status
  
  # Rearrange columns
  all_partners = all_partners[,c(6:9, 1:3, 5, 4)]
  
  # Append to main table
  if (i == 1) {
    tbl = all_partners
  }else{
    tbl = rbind(tbl, all_partners)
  }
}

# Get additional metadata fields for all unique partner IDs 
# (size, cropped status, and total number of pre/post synapses)
unique_partners = unique(tbl$partnerID)
md = neuprint_get_meta(unique_partners)
md = md[c("bodyid", "pre", "post", "status", "statusLabel", "cropped", "voxels")]
names(md)[names(md) == "bodyid"] = "partnerID"
names(md)[names(md) == "pre"] = "partnerPreCount"
names(md)[names(md) == "post"] = "partnerPostCount"
names(md)[names(md) == "voxels"] = "partnerSize"
names(md)[names(md) == "status"] = "partnerStatus"
names(md)[names(md) == "statusLabel"] = "partnerStatusLabel"
names(md)[names(md) == "cropped"] = "partnerCropped"


# Merge metadata into the main data frame
tbl = merge(tbl, md, by = "partnerID")

# Rearrange columns
tbl = tbl[,c(2:5, 1, 6:15)]

# Save main table as a .csv file
save_dir = "C:\\Users\\Wilson Lab\\Google Drive\\Lab Work\\LH-DAN_connectomics_analysis"
write.csv(tbl, paste(save_dir, "\\", "cosine_similarity_analysis_data_all_DANs.csv", sep = ""),
          row.names = FALSE)
