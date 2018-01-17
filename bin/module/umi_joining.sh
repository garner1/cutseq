#!/usr/bin/env bash

# THE OUTPUT BAM FILE WILL CONTAIN IN THE "CO" TAG THE UMI STRING

input=$1
aux=$2
out=$3

bedtools bamtobed -i $input | awk '$6 == "+"' | awk '{OFS="\t";print $4,$1,$2,"+"}' > $aux/forward & pid1=$! # if + strand DSB location is the second field
bedtools bamtobed -i $input | awk '$6 == "-"' | awk '{OFS="\t";print $4,$1,$3,"-"}' > $aux/reverse & pid2=$! # if - strand DSB location is the third field
wait $pid1
wait $pid2
cat $aux/forward $aux/reverse | LC_ALL=C sort --parallel=8 --temporary-directory=$HOME/tmp -k2,2 -k3,3n | awk '{OFS="\t";print $2,$3,$3+1,$1,"1",$4}' > $out/dsb_locations_dedup.bed
