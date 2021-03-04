#Visualization for Fig.6A
A <- read.csv(file="Data_for_dendogram.txt", header=TRUE, row.names=1, sep="\t")
X <- as.matrix(A)
dist_mat <- dist(X, method = 'binary')
hclust_avg <- hclust(dist_mat, method = 'average')
plot(hclust_avg)

library(ape)
class(hclust_avg)
my_tree <- as.phylo(hclust_avg)
write.tree(phy=my_tree, file="Beta_dendrogram.nwk")

library(phytools)
tree <- read.tree(file="Beta_dendrogram.nwk")
B <- read.csv(file="Data_for_dendogram.txt", header=TRUE, row.names=1, sep="\t")
Y <- as.matrix(B)
phylo.heatmap(tree, Y, labels=FALSE, legend=FALSE, colors= c("white","navy"))
