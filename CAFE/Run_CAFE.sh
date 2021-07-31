#Making species tree ultrametric
#timetree.org > age = 435
make_ultrametric.py -r age SpeciesTree_rooted.txt
#cat SpeciesTree_rooted.txt.ultrametric.tre

(((Oryzias_latipes:128.00000000,Gasterosteus_aculeatus:128.00000000)'14':101.90276097,Danio_rerio:229.90276097)'13':205.42131365,(Xenopus_tropicalis:351.75848322,((Anolis_carolinensis:279.65697667,(((Coturnix_japonica:42.00000000,Gallus_gallus:42.00000000)'11':37.95541635,((Cygnus_olor:6.08027000,Cygnus_atratus:6.08027000)'10':24.24849644,Anas_platyrhynchos:30.32876644)'19':49.62664992)'9':18.08745294,Taeniopygia_guttata:98.04286929)'22':181.61410737)'8':32.24694470,((Monodelphis_domestica:158.59758758,(((Felis_catus:54.32144118,Canis_lupus:54.32144118)'6':23.43351523,Bos_taurus:77.75495641)'30':18.70743276,((Rattus_norvegicus:20.88741740,Mus_musculus:20.88741740)'29':68.93577002,Homo_sapiens:89.82318742)'27':6.63920175)'35':62.13519841)'43':18.32991064,Ornithorhynchus_anatinus:176.92749821)'42':134.97642315)'40':39.85456185)'48':83.56559140);

#Create the lambda tree by copying the above tree and replacing the branch length with lambda index e.g: 1,2,3 etc.
(((Oryzias_latipes:1,Gasterosteus_aculeatus:1)'14':1,Danio_rerio:1)'13':1,(Xenopus_tropicalis:2,((Anolis_carolinensis:3,(((Coturnix_japonica:3,Gallus_gallus:3)'11':3,((Cygnus_olor:3,Cygnus_atratus:3)'10':3,Anas_platyrhynchos:3)'19':3)'9':3,Taeniopygia_guttata:3)'22':3)'8':3,((Monodelphis_domestica:4,(((Felis_catus:4,Canis_lupus:4)'6':4,Bos_taurus:4)'30':4,((Rattus_norvegicus:4,Mus_musculus:4)'29':4,Homo_sapiens:4)'27':4)'35':4)'43':4,Ornithorhynchus_anatinus:4)'42':4)'40':2)'48':1);

awk -F'\t' '{print "(null)\t"$0}' Orthogroups.GeneCount.tsv > tmp.tsv

#''e.g:
#Desc    Orthogroup      Anas_platyrhynchos_platyrhynchos        Anolis_carolinensis     Bos_taurus      Canismiliaris   Coturnix_japonica       Cygnus_atratus  Cygnus_olor     Danio_rerio  Felis_catus      G_aculeatus     Gallus_gallus   Human   Monodelphis_domestica   Mus_musculus    Ornithorhynchus_anatinus        Oryzias_latipes Rattus_norvegicus       Xenopus_tropicalis   Total
#(null)  OG0000000       19      25      102     73      10      13      16      0       65      8       11      47      121     213     33      10      139     47      952
#(null)  OG0000001       38      41      16      28      26      51      12      28      7       17      77      102     42      105     49      19      88      32      778
#(null)  OG0000002       1       0       64      373     0       0       0       6       51      0       0       0       43      6       0       9       68      13      634
#(null)  OG0000003       6       27      61      60      10      4       5       1       53      0       36      74      90      95      10      1       43      12      588
#(null)  OG0000004       0       9       8       32      0       0       0       17      9       30      0       67      70      123     12      29      100     65      571
#(null)  OG0000005       94      13      3       3       12      55      46      0       7       0       77      10      14      24      86      0       16      0       460
#(null)  OG0000006       0       0       0       0       0       0       0       0       0       0       0       0       444     0       0       0       0       0       444
#(null)  OG0000007       6       1       52      48      6       5       7       5       35      1       7       16      68      108     15      1       51      11      443
#(null)  OG0000008       0       42      37      40      1       0       0       1       42      0       0       46      46      75      32      1       29      1       393
#''
#remove the total column from above, without needed to figure out column numbers.
awk -F'\t' '{$NF=""; print $0}' tmp.tsv | rev | sed 's/^\s*//g' | rev | tr ' ' '\t' > mod.tsv

#run size filter finally
#filter the Orthogroups.GeneCount.tsv file to remove OG that have more than 100 proteins in a particular species:
python2 CAFE5/tutorial/clade_and_size_filter.py -i mod.tsv -s -o cafe.input.tsv

#RUN CAFE5
module load GCC
CAFE=/path/to/cafe5
$CAFE -i cafe.input.tsv -t SpeciesTree_rooted.txt.ultrametric.tre -c 20 -y lambda.tre -p #-k 3 -p

#Trees
echo $'#nexus\nbegin trees;'>Significant_trees.tre
grep "*" results\*_asr.tre >>Significant_trees.tre
echo "end;">>Significant_trees.tre

#Counts of significant family
grep -c "y" results/Gamma_family_results.txt

#Gene family expansion
less results/Gamma_clade_results.txt

#cat results/Base_clade_results.txt #The results without Gamma model #$CAFE -i cafe.input.tsv -t SpeciesTree_rooted.txt.ultrametric.tre -c 20 -y lambda.tre
