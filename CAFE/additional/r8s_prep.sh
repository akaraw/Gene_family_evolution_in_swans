 python2 CAFE5/tutorial/prep_r8s.py -i SpeciesTree_rooted.txt -o r8s_ctl_file.txt -s 35157236 \
 -p 'Human,Canismiliaris' -c '94'
 
#NEXUS
begin trees;
tree nj_tree = [&R] ((Danio_rerio:0.196035,(G_aculeatus:0.142943,Oryzias_latipes:0.152243)0.879662:0.0852112)0.940752:0.0748265,(Xenopus_tropicalis:0.24057,((Anolis_carolinensis:0.173431,((Coturnix_japonica:0.058523,Gallus_gallus:0.0424233)0.683653:0.0344506,((Cygnus_olor:0.0314775,Cygnus_atratus:0.032302)0.563008:0.0233585,Anas_platyrhynchos_platyrhynchos:0.080877)0.569609:0.0354346)0.751343:0.0881321)0.470606:0.032535,(Ornithorhynchus_anatinus:0.232844,(Monodelphis_domestica:0.123894,(((Bos_taurus:0.0679487,(Canismiliaris:0.0753141,Felis_catus:0.0591201)0.618573:0.0219604)0.383576:0.0143532,Human:0.0503002)0.468457:0.0224789,(Mus_musculus:0.0157411,Rattus_norvegicus:0.0394059)0.786493:0.0608318)0.710821:0.063739)0.463085:0.0395128)0.517882:0.0484803)0.617805:0.043567)0.940752:0.0748265);
End;
begin rates;
blformat nsites=35157236 lengths=persite ultrametric=no;
collapse;
mrca manris Human Canismiliaris;
fixage taxon=manris age=94;
divtime method=pl algorithm=tn cvStart=0 cvInc=0.5 cvNum=8 crossv=yes;
describe plot=chronogram;
describe plot=tree_description;
