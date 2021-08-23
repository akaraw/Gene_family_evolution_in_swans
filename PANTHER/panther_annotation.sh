#First download the PANTHER Database Version 15.0 or 16.0 (current is better) as an interpro5.52-86.0 package.
#Then use the longest ISoforms of the peptides of selected species
#In the working directory containing the species proteomes
function interpro (){
  genome=$1
  threads=$2
  base=$(basename "$1" ".fa")
  interproscan.sh -b ${base} -iprlookup -cpu $threads -T ${TMPDIR} dra -appl PANTHER -f tsv -i $genome
  
for i in *fa
do
base=$(basename $i ".fa")
interpro $i
done

#Getting family count
for i in *.tsv
do base=$(basename $i ".tsv"); cut -f1,5 $i | grep -v ":SF" > ${base}.txt
./line.sh 2 ${base}.tsv > tmp
mv tmp final.${base}.list
done

#Getting subfamily count
for i in *.tsv ; do base=$(basename $i ".tsv"); cut -f1,5 $i | grep ":SF" > ${base}.txt; ./line.sh 2 ${base}.txt > tmp; mv tmp ${base}.list; done

#Full sub family list
cut -f1 interproscan-5.52-86.0/data/panther/15.0/names.tab | cut -d"." -f1,2 | sort | uniq | grep -v ".mag" | sed 's/\./:/g' > panther_sf_acc.list
#Use the out put to create a CAFE stadrad gene family file using the R script in this repositry (I used subfamily as it has borader application in the downstream analysis process)

#run CAFE5
#Wanted to calculate seperate lambda for avian/reptilian clade and the rest of the tree
$CAFE -i cafe.input.tsv -t SpeciesTree_rooted.txt.ultrametric.tre -c 20 -y lambda.tre -p -k 2 -o run #Here I used the species tree generated from the Orthofinder with -M msa -S blast options


