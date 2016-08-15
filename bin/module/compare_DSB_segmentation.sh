#!/usr/bin/env bash

dsb1=$1			# this is the full path to the DSB data bed file *UMI_count*
dsb2=$2			# this is the full path to the DSB data bed file *UMI_count*
quality=$3		# filter out low quality reads
resolution=$4		# resolution of the binned genome
metric=$4			# can be {asym,norm_1,norm_2}

/home/garner1/SparkleShare/RESTSEQ/bin/module/DSB_segmentation.sh $dsb1 $quality $resolution & pid1=$!
/home/garner1/SparkleShare/RESTSEQ/bin/module/DSB_segmentation.sh $dsb2 $quality $resolution & pid2=$!
wait $pid1
wait $pid2

temp_file_1=$(mktemp)
bedtools unionbedg -i "$dsb1"__normed_segmented_q"$quality"_res"$resolution".bed "$dsb2"__normed_segmented_q"$quality"_res"$resolution".bed -header -names PROB1 PROB2 > ${temp_file_1}

temp_file_2=$(mktemp)
tail -n +2 ${temp_file_1} | cut -f4 > ${temp_file_2}

temp_file_3=$(mktemp)
tail -n +2 ${temp_file_1} | cut -f4 > ${temp_file_3}

python ~/Work/pipelines/restseq/bin/module/KL_divergence.py ${temp_file_2} ${temp_file_3} "$metric"

rm -f ${temp_file_1} ${temp_file_2} ${temp_file_3}




