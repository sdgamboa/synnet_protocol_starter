
## Supplementary files

Ths folder contains additional files related to generic homology search and phylogenetic inference analyses, which are out of the scope of the book chapter. It is exepected that the user would apply it's own pipeline according to its needs. This folder also contains metadata files and templates for iTOL. Below, there is a description of how some of the data was obtain.

Contents:

[Files description](#files-description)  
[Pipeline](#pipeline)


### Files description



### Pipeline


Protein alignment and trimming:

	hmmalign --trim --outformat afa Bax1-I.hmm TMBIM_proteins.fasta | sed -e '/>/!s/\./-/g' > TMBIM_proteins.afa
	trimal -in TMBIM_proteins.afa -out TMBIM_proteins.trimmed.afa -gt 0.8

Phylogenetic inference:

	iqtree2 --threads-max 3 -m TEST --mset WAG,LG,JTT -B 1000 -alrt 1000 -s TMBIM_proteins.trimmed.afa



