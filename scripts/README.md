## Scripts

### [build_synnet.sh](./build_synnet.sh)

This script creates a SynNet takin as inputs FASTA and BED files.

Print usage:

    ./build_synnet.sh

Print help:

    ./build_synnet.sh -h


### [extract_subnetwork.sh](./extract_subnetwork.sh)

This scripts extracts a subnetwork from a SynNet with a list of ids in a text file.

Print usage:

    ./extract_subnetwork.sh


### [get_node_table.sh](./get_node_table.sh) and [get_node_table_clusters.sh](./get_node_table_clusters.sh)

These scripts have the same functionality, they create a metadata table for nodes taking as inputs a SynNet (`get_node_table.sh`) or community (`get_node_table_clusters.sh`) file and a [metadata table](../files/nodes_metadata.csv). The only differece is the fields where the scripts look for the network edges (columns 3 and 4 for `get_node_table.sh`, and columns 1 and 2 for `get_node_table.clusters.sh`).

Print usage:

    ./get_node_table.sh
    ./get_npde_table_clusters.sh
 
 
### [phylogenetic_profiling.R](./phylogenetic_profiling.R)

R script used to create a phylogenetic profiling figure. Instructions about how to use it come in the book chapter.

