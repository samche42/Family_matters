library(pheatmap)

#Read in count data
data = read.csv("non_zero_cats.txt", header= TRUE, sep="\t", row.names =1)

#Convert data to matrix
df_num = as.matrix(data)

#Convert to presence/absence
df_num[df_num>0] <-1

#Get the default plot (allows you to look at clustering)
default <- pheatmap(df_num, main = "default_heatmap", fontsize = 2)

#Read in gene info
gene_info = read.csv("gene_info.txt", header= TRUE, sep="\t", row.names =1)

#Read in sponge host info 
sponge_info = read.csv("sponge_info.txt", header= TRUE, sep="\t", row.names =1)

#Add in categorical info
cats <- pheatmap(df_num, annotation_row = gene_info, annotation_col = sponge_info)

less_cats <- pheatmap(df_num, annotation_row = gene_info, annotation_col = sponge_info, cluster_rows = FALSE, annotation_legend = FALSE, fontsize = 3)

final <- pheatmap(df_num, annotation_row = gene_info, annotation_col = sponge_info, cluster_rows = FALSE, cutree_cols = 3,legend = FALSE, fontsize = 3)
