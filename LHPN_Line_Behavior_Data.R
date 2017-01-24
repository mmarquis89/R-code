
setwd('C:/Users/Wilson Lab/Documents/R/R-code')
library("reshape2", lib.loc="~/R/win-library/3.3")

myData <- read.csv("Compiled GMR Line Data.csv", sep=",", colClasses = "character", header=TRUE)
myData$Raw_Value <- as.numeric(myData$Raw_Value)
myData$Z_Score <- as.numeric(myData$Z_Score)
myData$pVal_Greater <- as.numeric(myData$pVal_Greater)
myData$pVal_Smaller <- as.numeric(myData$pVal_Smaller)
LHNData <- read.csv("LHNData.csv", sep=",")
LHPNs <- paste('R', as.vector(LHNData$LineName[LHNData$Class == "LH-PN"]), sep='')
LHLNs <- paste('R', as.vector(LHNData$LineName[LHNData$Class == "LH-LN"]), sep='')


meltGMR <- melt(myData, id.vars = c("Behavior_Statistic", "Line_Name"))
subGMR <- subset(meltGMR, meltGMR$variable=="Z_Score")
castGMR <- dcast(subGMR[-3], Line_Name ~ Behavior_Statistic)
castLHPNs <- castGMR[castGMR$Line_Name %in% LHPNs, ]
castLHLNs <- castGMR[castGMR$Line_Name %in% LHLNs, ]

castLHLNs <- castLHLNs[castLHLNs$Line_Name %in% c("R23F06", "R34G01"),]
castLHPNs <- castLHPNs[castLHPNs$Line_Name %in% c("R21G11", "R34C04", "37G11", "R44G08", "47G10", "R73B12"),]

allMeans <- colMeans(castGMR[-1], na.rm = TRUE)
LHPNMeans <- colMeans(castLHPNs[-1], na.rm = TRUE)
LHLNMeans <- colMeans(castLHLNs[-1], na.rm = TRUE)

LHPNDiff <- abs(LHPNMeans - allMeans)
LHLNDiff <- abs(LHLNMeans - allMeans)
# 
# plot(allMeans)
# plot(LHPNMeans, col='blue')
# points(LHLNMeans, col= 'red')
# points(allMeans, col='black')




myDf <- data.frame(variable = colnames(castGMR[-1]), All = allMeans, LHPNs = LHPNMeans, LHLNs = LHLNMeans, LHPNDiff = LHPNDiff, LHLNDiff = LHLNDiff)

test <- myDf[order(myDf$LHPNDiff, decreasing =TRUE),] 
head(test,10)

plot(allMeans)
plot(castGMR[2,2:10], y=NULL, col='red')
