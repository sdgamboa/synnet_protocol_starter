#! /bin/bash

sed -i -e '/>/s/^>/>al__/' al.pep
sed -i -e '/>/s/^>/>cc__/' cc.pep
sed -i -e '/>/s/^>/>si__/' si.pep


sed -i -e 's/\t/\tal__/' al.bed
sed -i -e 's/\t/\tcc__/' cc.bed
sed -i -e 's/\t/\tsi__/' si.bed


for f in $(ls -1 *pep | sed -e 's/\..*$//')
do
	sed -i -e "s/^/"$f"__/" $f.bed
done



sed -e 's/__/_/g' *bed
