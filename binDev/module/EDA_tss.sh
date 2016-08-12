#!/usr/bin/env bash

bedfile=$1				# full path to bed file 1; it can be a file or a directory
file1=$2				# name of aux file
file2=$3				# name of aux file
window=$4
cutsites=$5			# ~/Work/pipelines/data/AAGCTT.bed or GAATTC.BED

tss=~/Work/pipelines/data/TSS_uniq_chr-loc-gene.bed

#intersect tss and bedfile
if [ -f $bedfile ];then
    bedtools window -w $window -a $tss -b $bedfile -c |datamash --group 4 sum 5 |LC_ALL=C sort -k1,1 > $file1 & pid1=$!
fi
if [ -d $bedfile ];then
    cat "$bedfile"/*.bed | bedtools window -w $window -a $tss -b - -c |datamash --group 4 sum 5 |LC_ALL=C sort -k1,1 > $file1 & pid1=$!
fi
#intersect tss and cutsites
bedtools window -w $window -a $tss -b $cutsites -c |datamash --group 4 sum 5 |LC_ALL=C sort -k1,1 > $file2 & pid2=$!
wait $pid1
wait $pid2

#create a list of gene,RC,CS,RC/(CS+1); the +1 takes into account the CS=0 case
LC_ALL=C join $file1 $file2 | awk -v OFS="\t" '{print $1,$2,$3,$2/($3+1)}' 

rm -f $file1 $file2
