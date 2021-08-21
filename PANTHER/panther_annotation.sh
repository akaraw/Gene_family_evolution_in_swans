#First download the PANTHER Database Version 15.0 or 16.0 (current is better) as an interpro5 package.
#Then use the longest ISoforms of the peptides of selected species
#In the working directory containing the species proteomes

for i in *fa
do
base=$(basename $i ".fa")
interproscan
done

#Then use the tab delimited format to calculate the number of genes in each family/subfamily etc:
#Use the out put to create a CAFE stadrad gene family file using the R script in this repositry (I used subfamily as it has borader application in the downstream analysis process)
#run CAFE5


