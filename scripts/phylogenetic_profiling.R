library(tidyverse)
library(ggtree)

my_tree <- read.tree(file = "../files/species_tree.newick")

df <- read_tsv("TMBIM_clusters_nodes.csv") %>% 
    count(species, community) %>% 
    pivot_wider(names_from = community, values_from = n)

sp_names <- gsub(" ", "_", df$species)

counts_data <- as.data.frame(df[,-1])
rownames(counts_data) <- sp_names


p <- ggtree(my_tree, branch.length= "none") + 
    geom_tiplab(as_ylab = TRUE) +
    geom_cladelabel(node=MRCA(my_tree,
                              c("Glycine_max","Medicago_truncatula")),
                    label = "Fabaceae", fontsize = 4,
                    align = TRUE, geom = "text",
                    barsize = 0.5, angle = 90, hjust = 0.5, offset.text = .2) +
    geom_cladelabel(node=MRCA(my_tree,
                              c("Arabidopsis_thaliana","Brassica_oleracea")),
                    label = "Brassicaceae", fontsize = 4,
                    align = TRUE, geom = "text",
                    barsize = 0.5, angle = 90, hjust = 0.5, offset.text = .2) +
    geom_cladelabel(node=MRCA(my_tree,
                              c("Sorghum_bicolor","Oryza_sativa")),
                    label = "Poaceae", fontsize = 4,
                    align = TRUE, geom = "text",
                    barsize = 0.5, angle = 90, hjust = 0.5, offset.text = .2) +
    vexpand(0.2, direction = -1) +
    hexpand(0.2, direction = 1)


pdf(file = "Figure_6.pdf")
gheatmap(p, counts_data, offset=0.5, width=0.5, font.size=3, 
         colnames_angle=45, hjust=1) + 
    scale_fill_gradient(na.value = "gray85") +
    theme(axis.text = element_text(size = 8,face = "bold"),
          legend.position = "bottom") +
    labs(fill = "# genes")
dev.off()
