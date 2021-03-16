library(tidyverse)

df <- read_tsv("TMBIM_clusters_nodes.csv") %>% 
    arrange(family)

df <- df %>% 
    count(species, family, community)

p1 <- ggplot(data = df, 
       mapping = aes(x = community, y = species, fill = n)) +
    geom_tile() +
    scale_fill_viridis_c() +
    facet_wrap(~family, ncol = 1, scales = "free_y",
               strip.position = "right") +
    theme_classic() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1),
          axis.text.y = element_text(face = "italic"))

p1

ggsave("Figure_6.pdf", p1,
       width = 5, height = 6)
