#!/bin/bash

COL=$1
FILE=$2

awk -v col="$COL" -F $'\t' '   {c[$col]++}
                 END{
                     for (i in c) printf("%s\t%s\n",i,c[i])
                 }' $FILE

#Counting genes in each family and print treefamily id and the number of genes in the family
