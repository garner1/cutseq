#!/usr/bin/env bash

dsb1=$1			# this is the full path to the DSB data bed file *UMI_count*
dsb2=$2			# this is the full path to the DSB data bed file *UMI_count*
quality=$3		# filter out low quality reads
resolution=$4		# resolution of the binned genome

/home/garner1/SparkleShare/RESTSEQ/bin/module/DSB_segmentation.sh $dsb1 $quality $resolution & pid1=$!
/home/garner1/SparkleShare/RESTSEQ/bin/module/DSB_segmentation.sh $dsb2 $quality $resolution & pid2=$!
wait $pid1
wait $pid2

temp_file=$(mktemp)
bedtools unionbedg -i "$dsb1"__normed_segmented_q"$quality"_res"$resolution".bed "$dsb2"__normed_segmented_q"$quality"_res"$resolution".bed -header -names PROB1 PROB2 > ${temp_file}

head ${temp_file}
rm -f ${temp_file}




