#INITIALIZE
#Set path
setwd('C:/Users/Jenny/Documents/Code')

# Load flycircuit and nat packages
library(nat)
library(nat.flybrains)
library(nat.nblast)
library(flycircuit)
library(knitr)
library(rgl)
library(ggplot2)
library(alphashape3d)
library(morgenstemning)
library(frulhns)
library(grid)
library(filehash)
library(natviewer)
library(devtools)
library(roxygen2)
library(dendroextras)


# Use NULL device for rgl plots
options(rgl.useNULL=FALSE)

# Allow production of figures using RGL
knit_hooks$set(rgl = hook_rgl)
opts_chunk$set(dev=c('png','pdf'))

# set that as default all by all score matrix
options('flycircuit.scoremat'="\\Users\\Jenny\\Documents\\Code\\flycircuit\\data\\allbyallblastcv4.5.ff")

# load neuron list 
# the actual neuron data will be downloaded and cached to your machine on demand
dps<-read.neuronlistfh("http://flybrain.mrc-lmb.cam.ac.uk/si/nblast/flycircuit/dpscanon.rds",
                       localdir=getOption('flycircuit.datadir'))
remotesync(dps,download.missing = TRUE)

# set default neuronlist
options('nat.default.neuronlist'='dps')
options(rgl.antialias = TRUE)

apres16k.p0=load_si_data('apres16k.p0.rds')
apdf=as.data.frame(apres16k.p0)