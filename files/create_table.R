
library(tidyverse)

data1 <- read_tsv("TMBIM_id_list.txt", col_names = "id")
data2 <- read_tsv("species_metadata.csv")

data1 <- data1 %>% 
    mutate(sp = str_remove(id, "_.*$"))

merged_data <- left_join(data1, data2, by = c("sp" = "abbreviation"))

write_tsv(merged_data, "nodes_metadata.csv")



