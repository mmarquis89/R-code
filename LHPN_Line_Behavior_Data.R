
setwd('C:/Users/Wilson Lab/Documents/R')
library("reshape2", lib.loc="~/R/win-library/3.3")
load("GMR_line_Data.RData")
LHNData <- read.csv("LHNData.csv", sep=",")
behaviors <-read.csv("Behaviors.csv", head=FALSE, sep=",")
behaviors <- as.vector(behaviors[[1]])

LHPNs <- as.array(LHNData$LineName[LHNData$Class == "LH-PN"])
LHLNs <- LHNData$LineName[LHNData$Class == "LH-LN"]

GMR <- mydata[-5]
meltGMR <- melt(GMR)
test <- subset(meltGMR,variable == "zscore")
test <- test[-3]
castGMR <- dcast(test, lineName ~ field)

  
test <- subset(GMR, as.vector(GMR$field) %in% behaviors)

test <- GMR[,as.vector(GMR$field) %in% behaviors] 

a <- head(as.vector(GMR$field))

