#!/usr/bin/env bash

dsb=$1			# this is the full path to the DSB data bed file *UMI_count*
quality=$2		# filter out low quality reads
resolution=$3		# resolution of the binned genome

#create bed files representing the binned genome
~/SparkleShare/aux.scripts/make-windows.sh $resolution hg19 > "$dsb"__A.bed

#############################################################
#count the number of molecules in each bin
cat "$dsb"| awk -v quality="$quality" '$6 >= quality' |head
# bedtools intersect -a "$dsb"__A.bed -b "$dsb" -c | grep -v "chrM" > "$dsb"__raw_segmented.bed 
# norma=$(cat "$dsb"__raw_segmented.bed | datamash sum 4)
# echo $norma


