#!/usr/bin/env bash

path1=$1			# full path to bed files directory 1
path2=$2			# full path to bed files directory 2
window=$3			# window around TSS
metric=$4			# can be {asym,norm_1,norm_2}

if [ -d $path1 ]; then
    cat "$path1"/*.bed | ./EDA_tss.sh - 1_aux 2_aux "$window" > tss_1
fi
if [ -d $path2 ]; then
    cat "$path2"/*.bed | ./EDA_tss.sh - 1_aux 2_aux "$window" > tss_2
fi
if [ -f $path1 ]; then
    ./EDA_tss.sh $path1 1_aux 2_aux "$window" > tss_1
fi
if [ -f $path2 ]; then
    ./EDA_tss.sh $path2 1_aux 2_aux "$window" > tss_2
fi
rm -f 1_aux 2_aux

#compare descriptors
python KL_divergence.py tss_1 tss_2 "$metric"
#rm -f tss_{1,2}

