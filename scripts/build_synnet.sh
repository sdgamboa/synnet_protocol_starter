#! /bin/bash

## Define functions
display_usage() {

    echo -e "\nUsage:" 
    echo -e "\n\t$0 [-k 6 -s 5 -m 25 -p 4] <LIST_OF_SPECIES>"
    echo -e "\nIf you need more help, execute:"
    echo -e "\n\t$0 -h\n"

}

display_help() {
    echo -e "\nUSAGE:"
    echo -e "\n\t$0 [-k 6 -s 5 -m 25 -p 4] <LIST_OF_SPECIES>"
    echo -e "\nDESCRIPTION:"
    echo -e "\n\tThis script builds a synteny network (SynNet). This script is a
        modified version of the original SynNet pipeline, which can be found at
        https://github.com/zhaotao1987/SynNet-Pipeline. Please, refer to the
        original source for the most up-to-date version."
    echo -e "\nDEPENDENCIES:"
    echo -e "\n\tDiamond\t It can be downloaded at https://github.com/bbuchfink/diamond."
    echo -e "\n\tMCScanX\t It can be downloaded at https://github.com/wyp1125/MCScanX."
    echo -e "\nOPTIONS:"
    echo -e "\n\t-k\tNumber of hits for Diamond. Default: 6."
    echo -e "\n\t-s\tNumber of anchors for MCScanX. Default: 5."
    echo -e "\n\t-m\tNumber of gaps allowed between anchors (MCScanX). Default: 25."
    echo -e "\n\t-p\tNumber of CPUs for Diamond and MCScanX. Default: 4."
    echo -e "\nREFERENCES:"
    echo -e "\n\tZhao, T., Holmer, R., de Bruijn, S., Angenent, G. C., van den
        Burg, H. A., & Schranz, M. E. (2017). Phylogenomic synteny network
        analysis of MADS-box transcription factor genes reveals lineage-specific
        transpositions, ancient tandem duplications, and deep positional
        conservation. The Plant Cell, 29(6), 1278-1292."
    echo -e "\n\tZhao, T., & Schranz, M. E. (2017). Network approaches for plant
        phylogenomic synteny analysis. Current opinion in plant biology, 36, 129-134.\n"

}


parallel_MCScanX() {
    while [ $(jobs -p | wc -l) -ge "$CPUS" ]; do
        sleep 1
    done
}


## Defaut options. These will be overwritten if they're specified when the
## script is called.

HITS=6
ANCHORS=5
GAPS=25
CPUS=4

## Options
options_list=()
while getopts ":k:s:m:p:h" option; do
    case $option in
        k)
            options_list+=("-k $OPTARG")
            HITS="$OPTARG" ;;
        s)
            options_list+=("-s $OPTARG")
            ANCHORS="$OPTARG" ;;
        m)
            options_list+=("-m $OPTARG")
            GAPS="$OPTARG" ;;
        p)
            options_list+=("-p $OPTARG")
            CPUS="$OPTARG" ;;
        h)
            display_help
            exit ;;
        *)
            echo -e "\nUnknown option: $option"
            exit ;;
    esac
done

shift $[ $OPTIND - 1 ]

## If a single input file is not given, then display usage:
## This part comes after options, so -h can be executed.

if [ "$#" -eq 0 ]
then
    display_usage
    exit
elif [ "$#" -gt 1 ]
then
    echo -e "\nError: A single file containing a list of species must be passed as input."
    display_usage
    exit
fi

## Make sure input file exists, otherwise display usage:

if [ -s $1 ]
then
    :
else
    echo -e "\nError: File not found."
    display_usage
    exit
fi

## Read list of species and save it as an array
readarray species_list < $1
echo Building a SynNet for ${#species_list[@]} species: ${species_list[@]}

## test
DATE=$(date +%Y%m%d-%H%M%S)

echo " "
echo Results will be saved in synnetOutput."$DATE".k"$HITS"s"$ANCHORS"m"$GAPS"p"$CPUS"

## Create a new directory
w_dir=$(echo synnetOutput."$DATE".k"$HITS"s"$ANCHORS"m"$GAPS"p"$CPUS")
mkdir $w_dir
cd $w_dir

echo 
echo "#############################################"
echo "    Step 1 - Homology search with Diamond"
echo "#############################################"
echo

echo -e "Step 1.1 - Make Diamond database\n"

mkdir ../DiamondDB

for i in ${species_list[@]}
do
    echo -e "[$(date +%H"h"%M"m"%S"s")]\tCreating Diamond database for $i...\n"
    diamond makedb --quiet --in ../$i.pep -d ../DiamondDB/$i -p $CPUS
done

echo -e "Step 1.2 - Run homology searches\n"

for sp1 in ${species_list[@]}
do
    for sp2 in ${species_list[@]}
    do
        echo -e "\tRunning homology search $sp1 against $sp2...\n"
        diamond blastp --quiet \
        -q ../$sp1.pep -d ../DiamondDB/$sp2.dmnd -o "$sp1"_"$sp2" -p $CPUS \
        --max-hsps 1 --no-self-hits -k $HITS
    done
done

echo 
echo "#############################################"
echo "   Step 2 - Synteny detection with MCScanX"
echo "#############################################"
echo

echo -e "\nStep 2.1 - Intra-species\n"

for sp1 in ${species_list[@]}
do
	for sp2 in ${species_list[@]}
	do
		if [ $sp1 == $sp2 ]
		then
			parallel_MCScanX
			(
			mv "$sp1"_"$sp2" $sp1.blast
			cat ../$sp1.bed > $sp1.gff
			echo -e "[$(date +%H"h"%M"m"%S"s")]\tDetecting synteny for $sp1...\n"
			MCScanX $sp1 -s $ANCHORS -m $GAPS > /dev/null 2>&1
			duplicate_gene_classifier $sp1 > /dev/null 2>&1
			detect_collinear_tandem_arrays -g $sp1.gff -b $sp1.blast -c $sp1.collinearity -o $sp1.tandem.collinear > /dev/null 2>&1
			)&
		fi
	done
done

wait

			
echo -e "\nStep 2.2 - Inter-species\n"


for sp1 in ${species_list[@]}
do
	for sp2 in ${species_list[@]}
	do
		if [ $sp1 != $sp2 ]
		then
			parallel_MCScanX
			(
			cat "$sp1"_"$sp2" "$sp2"_"$sp1" > "$sp1"_"$sp2".blast
			cat ../"$sp1".bed ../"$sp2".bed > "$sp1"_"$sp2".gff
			echo -e "[$(date +%H"h"%M"m"%S"s")]\tDetecting synteny for $sp1 and $sp2...\n"
			MCScanX	-a -b 2 "$sp1"_"$sp2" -s $ANCHORS -m $GAPS > /dev/null 2>&1
			
			cat "$sp1"_"$sp2".blast "$sp1".blast "$sp2".blast > "$sp1"_"$sp2".all.blast
            detect_collinear_tandem_arrays -g "$sp1"_"$sp2".gff -b "$sp1"_"$sp2".all.blast \
            -c "$sp1"_"$sp2".collinearity -o "$sp1"_"$sp2".tandem.collinear > /dev/null 2>&1
            grep -o -E ","  "$sp1"_"$sp2".tandem.collinear|wc -l > "$sp1"_"$sp2".tandem.collinear.added			
			)&
		fi
    done
done

wait

echo 
echo "#############################################"
echo "        Step 3 - Generate SynNet file"
echo "#############################################"
echo

for f in $(ls -1 *collinearity | sed -e 's/\..*$//')
do
	sed 's/^/'$f'/' $f.collinearity >> tmp1
done

# awk '{if($0~/.*score/){split($0,a,"=");print a[1]}else{print $0"\t"a[2]}}' tmp1 > tmp2

awk '{if($0~/.*score/){split($0,a,"=");print a[1]}else{print $0"\t"a[2]"\t"a[4]}}' tmp1 > tmp2

sed '/#/d; s/e_value//g; s/ //g; s/:/b/g; s/minus//g; s/plus//g' tmp2 > tmp3

awk '{print $1"\t"$5"\t"$2"\t"$3"\t"$6}' tmp3 > SynNet_k"$HITS"s"$ANCHORS"m"$GAPS".csv

rm tmp*

echo -e "\nJob done! $(date)\n"
