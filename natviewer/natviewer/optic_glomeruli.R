#Optic glomeruli work
#write.table(optic_glomeruli, file = "natviewer/optic_glomeruli.txt", sep="\t")

optic_glomeruli<-read.table("natviewer/optic_glomeruli.txt", header=TRUE, sep="\t")$x

ognl = fcneuroncluster(optic_glomeruli)
ognl_subset = sample(ognl, 100)
ognl_score = nblast_allbyall(ognl_subset)
hcognl <- nhclust(scoremat = ognl_score)
dognl <- colour_clusters(hcognl, k=5)
labels(dognl) <- cluster_number(fc_neuron(labels(dognl)))

plot(dognl)
open3d()
plot3d(hcognl, k=5, db=ognl_subset, soma=T)

viewer()
OG_link = cluster_scan(clusters[!(clusters %in% optic_glomeruli)])
