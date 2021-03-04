library(reshape2)
library(tidyr)
library(ggplot2)
library(viridis)

data <- read.csv(file = "Beta_shared_OGs.txt", header=T, sep="\t")

get_lower_tri <-function(data){data[upper.tri(data)] <- NA 
return(data)}

lower_tri <- get_lower_tri(data)

melted_tri <- melt(lower_tri)

ggheatmap <- ggplot(melted_tri, aes(Genome, variable, fill = value))+
 geom_tile(color = "white")+
scale_fill_viridis(option="magma", direction=-1, limits=c(0, 100)) +
  theme_minimal()+ # minimal theme
 theme(axis.text.x = element_text(angle = 45, vjust = 1, 
    size = 12, hjust = 1))+
 coord_fixed()

ggheatmap
