library(indicspecies)
pc=read.csv("Species_for_primer.csv", header=TRUE)
abund = pc[,4:ncol(pc)]
Chemotype = pc$Chemotype
inv = multipatt(abund, Chemotype, func = "r.g", control = how(nperm=9999))
summary(inv)

#Boxplot visualisation of OTU5
pc=read.csv("Species_for_primer.csv", header=TRUE)
sub_pc = data.frame(Chemotype=pc$Chemotype, OTU5=pc$OTU5)

library(ggplot2)
library(reshape2)

sub_pc_m = melt(sub_pc, id = "Chemotype")

gg = ggplot(sub_pc_m, aes(x = variable, y = value, fill = Chemotype)) + 
     geom_boxplot(colour = "black", position = position_dodge(0.5)) +
     geom_vline(xintercept = c(1.5,2.5,3.5), colour = "grey85", size = 1.2) +
     theme(legend.title = element_text(size = 12, face = "bold"), 
     legend.text = element_text(size = 10, face = "bold"), legend.position = "right", 
     axis.text.x = element_text(face = "bold",colour = "black", size = 12), 
     axis.text.y = element_text(face = "bold", size = 12, colour = "black"), 
     axis.title.y = element_text(face = "bold", size = 14, colour = "black"), 
     panel.background = element_blank(), 
     panel.border = element_rect(fill = NA, colour = "black"), 
     legend.key=element_blank()) + 
     labs(x= "", y = "Relative Abundance (%)", fill = "Chemotype") + 
     scale_fill_manual(values = c("steelblue2", "steelblue4"))
