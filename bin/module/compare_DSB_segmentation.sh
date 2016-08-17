#!/usr/bin/env bash

dsb1=$1			# this is the full path to the DSB data bed file *UMI_count*
dsb2=$2			# this is the full path to the DSB data bed file *UMI_count*
quality=$3		# filter out low quality reads
resolution=$4		# resolution of the binned genome
metric=$5		# can be {asym,norm_1,norm_2}

~/SparkleShare/RESTSEQ/bin/module/DSB_segmentation.sh $dsb1 $quality $resolution & pid1=$!
~/SparkleShare/RESTSEQ/bin/module/DSB_segmentation.sh $dsb2 $quality $resolution & pid2=$!
wait $pid1
wait $pid2

temp_file_1=$(mktemp)
bedtools unionbedg -i "$dsb1"__raw_segmented_q"$quality"_res"$resolution".bed "$dsb2"__raw_segmented_q"$quality"_res"$resolution".bed -header -names COUNT1 COUNT2 > ${temp_file_1}

temp_file_2=$(mktemp)
tail -n +2 ${temp_file_1} | cut -f4 > ${temp_file_2}

temp_file_3=$(mktemp)
tail -n +2 ${temp_file_1} | cut -f5 > ${temp_file_3}

echo "$dsb1"
echo "$dsb2"
python ~/SparkleShare/RESTSEQ/bin/module/KL_divergence.py ${temp_file_2} ${temp_file_3} "$metric"
tail -n +2 ${temp_file_1} | datamash sum 4 sum 5 | awk '{OFS="\t"; print $1,$2,($1+$2)/2}'


rm -f ${temp_file_1} ${temp_file_2} ${temp_file_3} "$dsb1"__{raw,normed}_segmented_q"$quality"_res"$resolution".bed "$dsb2"__{raw,normed}_segmented_q"$quality"_res"$resolution".bed




