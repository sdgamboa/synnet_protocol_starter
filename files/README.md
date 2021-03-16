

Ths folder contains additional files regarding metadata and specific protein sequences.


Protein alignment and trimming:

	hmmalign --trim --outformat afa Bax1-I.hmm TMBIM_proteins.fasta | sed -e '/>/!s/\./-/g' > TMBIM_proteins.afa
	trimal -in TMBIM_proteins.afa -out TMBIM_proteins.trimmed.afa -gt 0.8

Phylogenetic inference:

	iqtree2 --threads-max 3 -m TEST --mset WAG,LG,JTT -B 1000 -alrt 1000 -s TMBIM_proteins.trimmed.afa


