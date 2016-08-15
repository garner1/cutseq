#!/usr/bin/env bash

file1=$1			# full path to bed file 1
file2=$2			# full path to bed file 2
resolution=$3			# resolution of the binned genome
metric=$4			# can be {asym,norm_1,norm_2}

#create bed files representing the binned genome
~/Work/pipelines/aux.scripts/make-windows.sh $resolution hg19 > A.bed
#############################################################
# prepare the mean descriptor
cat $file1 | LC_ALL=C sort -k1,1 -k2,2n | LC_ALL=C uniq -c |
awk -v OFS='\t' '{print $2,$3,$3+1,$1}' > file1.bed
#count the number of molecules in each bin
bedtools intersect -a A.bed -b file1.bed -c > binned_raw_file1.bed
cat binned_raw_file1.bed | cut -f4 > file1

cat $file2 | LC_ALL=C sort -k1,1 -k2,2n | LC_ALL=C uniq -c |
awk -v OFS='\t' '{print $2,$3,$3+1,$1}' > file2.bed
#count the number of molecules in each bin
bedtools intersect -a A.bed -b file2.bed -c > binned_raw_file2.bed
cat binned_raw_file2.bed | cut -f4 > file2

#rm -f binned_raw_file{1,2}.bed file{1,2}.bed
#############################################################
python ~/Work/pipelines/restseq/bin/module/KL_divergence.py file1 file2 $metric
#############################################################################

