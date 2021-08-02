###Running hmmerscan instead of treefam_scan.pl
#hmmer version 3.1
for i in *.fa
do
base=$(basename $i ".fa")
hmmscan --tblout test_dir/test --cpu 20 -E 1e-3 --noali hmm_lib/TreeFam9 $i
grep -v "#\|^$" test_dir/test |sed -e 's/  */\t/g'| sort -k3,3n -k5,5g | awk '!($3 in a){a[$3];print}' > ${base}.txt
./line.sh 1 ${base}.txt > final.${base}.tmp

