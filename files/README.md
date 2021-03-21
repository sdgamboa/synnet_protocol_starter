
## Supplementary files

Ths folder contains additional files related to generic homology search and phylogenetic inference analyses, which are out of the scope of the book chapter. It is exepected that the user would apply it's own pipeline according to its needs. This folder also contains metadata files and templates for iTOL.

Contents:

[Files description](#files-description)  
[Homology search and phylogenetic inference](#Homology-search-and-phylogenetic-inference)


### Files description

| Files | Description |
| ----- | ----------- |
| [Bax1-I.hmm](./Bax1-I.hmm) | hmm profile used to identify TMBIM proteins. The profile was obtained from [Pfam](http://pfam.xfam.org). |
| [Bax1-I_cutga_c0.8.tar.gz](./Bax1-I_cutga_c0.8.tar.gz) | Compressed output from executing the [hmm_retrieve.sh script](https://github.com/sdgamboa/bash_scripts/blob/master/hmm_retrieve.sh). |
| [TMBIM_proteins.fasta](./TMBIM_proteins.fasta) | All 117 proteins in FASTA format used as example for the book chapter. |
| [TMBIM_proteins.afa](./TMBIM_proteins.afa) | Alignment of all 117 proteins in FASTA format used as example for the book chapter. |
| [TMBIM_proteins.trimmed.afa](./TMBIM_proteins.trimmed.afa) | Trimmed alignment of all 117 proteins in FASTA format used as example for the book chapter.  |
| TMBIM_proteins.trimmed.afa.* | Output files from iqtree2. The [TMBIM_proteins.trimmed.treefile](./TMBIM_proteins.trimmed.afa.treefile) file was used to visualize the SynNet communities in iTOL. |
| [community_colors.txt](./community_colors.txt) | Contains color hex codes for the communities. |
| [create_table.R](./create_table.R) | Script used to create the nodes_metadata.csv file. |
| [iTOL.xlsx](./iTOL.xlsx) | Excel file containing the information for the iTOL templates. |
| [iTOL_template_connections.txt](./iTOL_template_connections.txt) | iTOL template for communities. |
| [iTOL_template_labels.txt](./iTOL_template_labels.txt) | iTOL template for label colors. |
| [iTOL_template_strips.txt](./iTOL_template_strips.txt) | iTOL template for strop colors. |
| [nodes_metadata.csv](./nodes_metadata.csv) | Metadata for the 117 TMBIM proteins used as example for this study. |
| [species_metadata.csv](./species_metadata.csv) | Metadata for the 15 plant species. |
| [species_tree.newick](./species_tree.newick) | Species tree used for phylogenetic profiling. The tree was generated with [ete3](http://etetoolkit.org) and furhter modified in iTOL. |



### Homology search and phylogenetic inference

Homology searches were performed with [HMMER3](http://hmmer.org) implemented in the [hmm_retrieve.sh](https://github.com/sdgamboa/bash_scripts/blob/master/hmm_retrieve.sh) script and using the [Bax1-I.hmm (PF01027)](./Bax1-I.hmm) obtained from [Pfam](http://pfam.xfam.org). The command call was:

    hmm_retrieve.sh -g -c 0.8 -p Bax1-I.hmm full/path/to/synnet_protocol_starter/db/*pep

The results were concatenated in the [TMBIM_proteins.fasta](./TMBIM_proteins.fasta) file and the sequence identifiers in the [TMBIM_id_list.txt](./TMBIM_id_list.txt) file.

For protein alignment and trimming, the hmmalign command of hmmer3 and the [trimAl](http://trimal.cgenomics.org) programs were used, respectively:

    hmmalign --trim --outformat afa Bax1-I.hmm TMBIM_proteins.fasta | sed -e '/>/!s/\./-/g' > TMBIM_proteins.afa
    trimal -in TMBIM_proteins.afa -out TMBIM_proteins.trimmed.afa -gt 0.8

Phylogenetic inference was done with [iqtree2](https://github.com/iqtree/iqtree2):

	iqtree2 --threads-max 3 -m TEST --mset WAG,LG,JTT -B 1000 -alrt 1000 -s TMBIM_proteins.trimmed.afa

Outputs from iqtree2 are TMBIM_proteins.trimmed.afa\*. The [TMBIM_proteins.trimmed.treefile](./TMBIM_proteins.trimmed.afa.treefile) was used to visualize the tree in [iTOL](https://itol.embl.de) in the protocol of the book chapter.




