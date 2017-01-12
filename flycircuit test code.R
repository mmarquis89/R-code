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

# plot a single neuron
plot3dfc("VGlut-F-200257")

# plot top 10 nblast matches for that neuron
clear3d()
plot3dfc("fru-M-200266", col='black', lwd=3)
sc=fc_nblast("fru-M-200266")
top10sc=sort(sc, decreasing = T)[1:10]
plot3dfc(names(top10sc), soma=T)


# Load a neuron
neuron_to_bridge <- kcs20[[1]]

# Display the neuron in 3D
nopen3d()
plot3d(neuron_to_bridge)

# Add the original brain to the 3D display, for context
plot3d(FCWB) # IS2, JFRC2, FCWB, T1, IBNWB, Cell07

# Bridge the FCWB neuron into JFRC2 space
neuron_in_jfrc2 <- xform_brain(neuron_to_bridge, FCWB, JFRC2)

# Plot the bridged neuron in 3D, along with the JFRC2 brain
nopen3d()
plot3d(neuron_in_jfrc2)
plot3d(JFRC2)

# Convert names
geneNames = fc_gene_name(LHN_names)
write.csv(fc_neuron(geneNames), "ValidNeurons.csv" )