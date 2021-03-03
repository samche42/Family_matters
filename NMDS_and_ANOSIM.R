pc = read.csv("tmp.txt", header= TRUE, sep="\t")

#make community matrix - extract columns with abundance information
com = pc[,3:ncol(pc)]

#turn abundance data frame into a matrix
m_com = as.matrix(com)

set.seed(123)
nmds = metaMDS(m_com, distance = "bray")
nmds

#extract NMDS scores (x and y coordinates)
data.scores = as.data.frame(scores(nmds))

#add columns to data frame 
data.scores$Sample = pc$Sample
data.scores$Sponge = pc$Sponge
 
head(data.scores)

library(ggplot2)

plot1 = ggplot(data.scores, aes(x = NMDS1, y = NMDS2)) + 
    geom_point(size = 4, aes(colour = Sponge))+ 
    theme(axis.text.y = element_text(colour = "black", size = 12, face = "bold"), 
    axis.text.x = element_text(colour = "black", face = "bold", size = 12), 
    legend.text = element_text(size = 12, face ="bold", colour ="black"), 
    legend.position = "right", axis.title.y = element_text(face = "bold", size = 14), 
    axis.title.x = element_text(face = "bold", size = 14, colour = "black"), 
    legend.title = element_text(size = 14, colour = "black", face = "bold"), 
    panel.background = element_blank(), panel.border = element_rect(colour = "black", fill = NA, size = 1.2),
    legend.key=element_blank()) + 
    labs(x = "NMDS1", colour = "Group", y = "NMDS2") 
 
plot1

ano = anosim(m_com, pc$Sponge, distance = "bray", permutations = 9999)
ano
