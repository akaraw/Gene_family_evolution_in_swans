 #wget https://downloads.sourceforge.net/project/r8s/r8s1.81.tar.gz
 #tar xf r8s1.81.tar.gz
 #cd r8s1.81/src/
 #mdule load GCC
 #make
 ./r8s1.81/src/r8s -b -f r8s_ctl_file.txt > r8s_tmp.txt
 
 tail -n 1 r8s_tmp.txt | cut -c16- > r8s_ultrametric.txt
 #(((G_aculeatus:187.648478,Oryzias_latipes:187.648478)0.879662:108.235535,Danio_rerio:295.884013)0.940752:112.688530,(((((Coturnix_japonica:69.171296,Gallus_gallus:69.171296)0.683653:51.146876,((Cygnus_olor:44.295854,Cygnus_atratus:44.295854)0.563008:35.713744,Anas_platyrhynchos_platyrhynchos:80.009598)0.569609:40.308575)0.751343:114.928877,Anolis_carolinensis:235.247049)0.470606:45.296714,((((((Canismiliaris:65.571872,Felis_catus:65.571872)0.618573:17.368598,Bos_taurus:82.940470)0.383576:11.059530,Human:94.000000)manris:21.467490,(Mus_musculus:23.736686,Rattus_norvegicus:23.736686)0.786493:91.730804)0.710821:68.947049,Monodelphis_domestica:
 #184.414539)0.463085:48.752317,Ornithorhynchus_anatinus:233.166856)0.517882:47.376907)0.617805:45.584184,Xenopus_tropicalis:326.127947)0.940752:82.444596);
 
 
