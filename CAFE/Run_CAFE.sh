#Making species tree ultrametric


awk -F'\t' '{print "(null)\t"$0}' Orthogroups.GeneCount.tsv > tmp.tsv

""
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
""
#remove the total column from above, without needed to figure out column numbers.
awk -F'\t' '{$NF=""; print $0}' tmp.tsv | rev | sed 's/^\s*//g' | rev | tr ' ' '\t' > mod.tsv

#run size filter finally
#filter the Orthogroups.GeneCount.tsv file to remove OG that have more than 100 proteins in a particular species:
python2 CAFE5/tutorial/clade_and_size_filter.py -i mod.tsv -s -o cafe.input.tsv

