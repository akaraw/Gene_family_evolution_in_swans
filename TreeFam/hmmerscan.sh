###Running hmmerscan instead of treefam_scan.pl
##https://github.com/Ensembl/treefam_tools/tree/master/treefam_scan
#hmmer version 3.3.2
#mkdir hmm_lib
#cd hmm_lib/
#wget http://www.treefam.org/static/download/treefam9.hmm3.tar.gz
#tar -xzvf treefam9.hmm3.tar.gz
#mv treefam9.hmm3 TreeFam9
#hmmpress TreeFam9

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
