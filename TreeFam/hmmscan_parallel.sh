#!/bin/bash

genome=$1
seqkit split $genome -p 24
function hmmer() {
n=$(basename "$1")
hmmscan --tblout ${n}.txt --cpu 1 -E 1e-5 --noali hmm_lib2/TreeFam9 $1
}
base=$(basename $genome ".fa")
export -f hmmer
find $genome.split/ -type f -name "*fa" | parallel -j 24 hmmer {}
cat ${base}.part_0* > ${base}.txt
rm ${base}.part_0*
grep -v "#\|^$" ${base}.txt |sed -e 's/  */\t/g'| sort -k3,3n -k5,5g | awk '!($3 in a){a[$3];print}' > tmp.${base}.txt
./line.sh 1 tmp.${base}.txt > ${base}
file=${base}
awk 'NR==1 { print "Desc""\t"FILENAME }; 1' "$file" > temp && mv temp final.${base}.tsv
rm ${base} tmp.${base}.txt rm ${base}.txt
