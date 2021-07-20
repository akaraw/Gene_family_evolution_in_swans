#Making species tree ultrametric
#timetree.org
#Estimated time of divergence between "Xenopus tropicalis" and "Danio rerio" = 435
python2 ../OrthoFinder/tools/make_ultrametric.py -r 435 SpeciesTree_rooted.txt

#cat SpeciesTree_rooted.txt.ultrametric.tre
''
((Danio_rerio:324.802,(G_aculeatus:205.918,Oryzias_latipes:205.918):118.884):110.198,(Xenopus_tropicalis:342.173,((Anolis_carolinensis:244.489,
((Coturnix_japonica:74.8034,Gallus_gallus:74.8034):51.0573,((Cygnus_olor:46.7045,Cygnus_atratus:46.7045):34.21,Anas_platyrhynchos_platyrhynchos:80.9145):44.9462):118.629):44.1254,
(Ornithorhynchus_anatinus:232.925,(Monodelphis_domestica:186.553,(((Bos_taurus:76.996,(Canismiliaris:58.0353,Felis_catus:58.0353):18.9606):13.4607,Human:90.4567)
:23.9457,(Mus_musculus:35.6819,Rattus_norvegicus:35.6819):78.7204):72.1505):46.3717):55.6903):53.5585):92.8267);
''

#Create the lambda tree by copying the above tree and replacing the branch length with lambda index e.g: 1,2,3 etc.
((Danio_rerio:1,(G_aculeatus:1,Oryzias_latipes:1):1):1,(Xenopus_tropicalis:1,((Anolis_carolinensis:1,((Coturnix_japonica:2,Gallus_gallus:2):2,((Cygnus_olor:2,Cygnus_atratus:2):2,Anas_platyrhynchos_platyrhynchos:2):2):2):3,(Ornithorhynchus_anatinus:3,(Monodelphis_domestica:4,(((Bos_taurus:4,(Canismiliaris:4,Felis_catus:4):4):4,Human:4):4,(Mus_musculus:4,Rattus_norvegicus:4):4):4):3):1):1):1);

awk -F'\t' '{print "(null)\t"$0}' Orthogroups.GeneCount.tsv > tmp.tsv

''
Desc    Orthogroup      Anas_platyrhynchos_platyrhynchos        Anolis_carolinensis     Bos_taurus      Canismiliaris   Coturnix_japonica       Cygnus_atratus  Cygnus_olor     Danio_rerio  Felis_catus      G_aculeatus     Gallus_gallus   Human   Monodelphis_domestica   Mus_musculus    Ornithorhynchus_anatinus        Oryzias_latipes Rattus_norvegicus       Xenopus_tropicalis   Total
(null)  OG0000000       19      25      102     73      10      13      16      0       65      8       11      47      121     213     33      10      139     47      952
(null)  OG0000001       38      41      16      28      26      51      12      28      7       17      77      102     42      105     49      19      88      32      778
(null)  OG0000002       1       0       64      373     0       0       0       6       51      0       0       0       43      6       0       9       68      13      634
(null)  OG0000003       6       27      61      60      10      4       5       1       53      0       36      74      90      95      10      1       43      12      588
(null)  OG0000004       0       9       8       32      0       0       0       17      9       30      0       67      70      123     12      29      100     65      571
(null)  OG0000005       94      13      3       3       12      55      46      0       7       0       77      10      14      24      86      0       16      0       460
(null)  OG0000006       0       0       0       0       0       0       0       0       0       0       0       0       444     0       0       0       0       0       444
(null)  OG0000007       6       1       52      48      6       5       7       5       35      1       7       16      68      108     15      1       51      11      443
(null)  OG0000008       0       42      37      40      1       0       0       1       42      0       0       46      46      75      32      1       29      1       393
''
#remove the total column from above, without needed to figure out column numbers.
awk -F'\t' '{$NF=""; print $0}' tmp.tsv | rev | sed 's/^\s*//g' | rev | tr ' ' '\t' > mod.tsv

#run size filter finally
#filter the Orthogroups.GeneCount.tsv file to remove OG that have more than 100 proteins in a particular species:
python2 CAFE5/tutorial/clade_and_size_filter.py -i mod.tsv -s -o cafe.input.tsv

#RUN CAFE5
$CAFE -i cafe.input.tsv -t SpeciesTree_rooted.txt.ultrametric.tre -c 20 -y lambda.tre


