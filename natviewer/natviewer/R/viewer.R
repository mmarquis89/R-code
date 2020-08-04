#' Setup new viewer
#' 
#' This function starts a new window with the FCWB surf uploaded at transparency of 0.2
#' @param neuropil Can show neuropil at transparency of 0.1. Defaults to NULL.
#' $RegionList
#'[1] "AME_R"    "LO_R"     "NO"       "BU_R"     "PB"       "LH_R"     "LAL_R"   
#'[8] "SAD"      "CAN_R"    "AMMC_R"   "ICL_R"    "VES_R"    "IB_R"     "ATL_R"   
#'[15] "CRE_R"    "MB_PED_R" "MB_VL_R"  "MB_ML_R"  "FLA_R"    "LOP_R"    "EB"      
#'[22] "AL_R"     "ME_R"     "FB"       "SLP_R"    "SIP_R"    "SMP_R"    "AVLP_R"  
#'[29] "PVLP_R"   "IVLP_R"   "PLP_R"    "AOTU_R"   "GOR_R"    "MB_CA_R"  "SPS_R"   
#'[36] "IPS_R"    "SCL_R"    "EPA_R"    "GNG"      "PRW"      "GA_R"     "AME_L"   
#'[43] "LO_L"     "BU_L"     "LH_L"     "LAL_L"    "CAN_L"    "AMMC_L"   "ICL_L"   
#'[50] "VES_L"    "IB_L"     "ATL_L"    "CRE_L"    "MB_PED_L" "MB_VL_L"  "MB_ML_L" 
#'[57] "FLA_L"    "LOP_L"    "AL_L"     "ME_L"     "SLP_L"    "SIP_L"    "SMP_L"   
#'[64] "AVLP_L"   "PVLP_L"   "IVLP_L"   "PLP_L"    "AOTU_L"   "GOR_L"    "MB_CA_L" 
#'[71] "SPS_L"    "IPS_L"    "SCL_L"    "EPA_L"    "GA_L"  
#' @keywords setup
#' @export
#' @examples 
#' setup()
#' setup(c("FB_L", "FB_R"))
viewer <- function(neuropil = ""){
  plot3d(FCWB, alpha = 0.2)
  for (item in neuropil){
    if (item %in% FCWBNP.surf$RegionList){
      fcwbnpsurf(item, alpha=0.1)
    }
  }
}