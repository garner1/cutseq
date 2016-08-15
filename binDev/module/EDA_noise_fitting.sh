#!/usr/bin/env bash

file1=$1				# can be {all,xz13,xz14,xz19,xz20,xz21,xz22,xz23,xz24,xz1920,xz2122,xz2324}
file2=$2			# this is the local dataset to be compared with the mean dataset
resolution=$3			# resolution of the binned genome

#create bed files representing the binned genome
~/Work/pipelines/aux.scripts/make-windows.sh $resolution hg19 > A.bed
#############################################################
cat ~/Work/dataset/restseq/"$file1"/outdata/?_?.bed | LC_ALL=C sort -k1,1 -k2,2n | LC_ALL=C uniq -c |
awk -v OFS='\t' '{print $2,$3,$3+1,$1}' > ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed
bedtools intersect -a A.bed -b ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed -c > ~/Work/dataset/restseq/binned_raw_1.bed
cat ~/Work/dataset/restseq/"$file2"/outdata/?_?.bed | LC_ALL=C sort -k1,1 -k2,2n | LC_ALL=C uniq -c |
awk -v OFS='\t' '{print $2,$3,$3+1,$1}' > ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed
bedtools intersect -a A.bed -b ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed -c > ~/Work/dataset/restseq/binned_raw_2.bed


