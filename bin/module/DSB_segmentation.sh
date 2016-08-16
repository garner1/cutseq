#!/usr/bin/env bash

dsb=$1			# this is the full path to the DSB data bed file *UMI_count*
quality=$2		# filter out low quality reads
resolution=$3		# resolution of the binned genome

#create bed files representing the binned genome
temp_file_0=$(mktemp)
~/SparkleShare/aux.scripts/make-windows.sh $resolution hg19 > ${temp_file_0}

#############################################################
#count the number of molecules in each bin
cat "$dsb"| awk -v quality="$quality" '$6 >= quality' |
bedtools intersect -a ${temp_file_0} -b stdin -c | grep -v "chrM" > "$dsb"__raw_segmented_q"$quality"_res"$resolution".bed 

# rm -f "$dsb"__raw_segmented_q"$quality"_res"$resolution".bed



