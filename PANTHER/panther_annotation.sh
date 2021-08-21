#First download the PANTHER Database Version 15.0 or 16.0 (current is better) as an interpro5 package.
#Then use the longest ISoforms of the peptides of selected species
#In the working directory containing the species proteomes
function interpro (){
  genome=$1
  threads=$2
  base=$(basename "$1" ".fa")
  interproscan

for i in *fa
do
base=$(basename $i ".fa")
interpro $i
done

#Then use the tab delimited format to calculate the number of genes in each family/subfamily etc:
#Use the out put to create a CAFE stadrad gene family file using the R script in this repositry (I used subfamily as it has borader application in the downstream analysis process)
#run CAFE5
#Wanted to calculate seperate lambda for avian/reptilian clade and the rest of the tree
$CAFE -i cafe.input.tsv -t SpeciesTree_rooted.txt.ultrametric.tre -c 20 -y lambda.tre -p -k 2 -o run #Here I used the species tree generated from the Orthofinder with -M msa -S blast options


