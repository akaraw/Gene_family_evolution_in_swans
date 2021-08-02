###Running hmmerscan instead of treefam_scan.pl
#hmmer version 3.1
for i in *.fa
do
base=$(basename $i ".fa")
hmmscan --tblout ${base}.txt --cpu 20 -E 1e-3 --noali hmm_lib/TreeFam9 $i
grep -v "#\|^$" ${base}.txt |sed -e 's/  */\t/g'| sort -k3,3n -k5,5g | awk '!($3 in a){a[$3];print}' > tmp.${base}.txt
./line.sh 1 tmp.${base}.txt > ${base}
file=${base}
awk 'NR==1 { print "Desc""\t"FILENAME }; 1' "$file" > temp && mv temp final.${base}.tsv
rm ${base} tmp.${base}.txt 
done 
