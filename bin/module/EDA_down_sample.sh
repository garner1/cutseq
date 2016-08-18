#!/usr/bin/env bash

in=$1				# input bed file
size=$2				# size of the random sample

# for ind in $(seq 2);do
#     out="$ind"__$(echo "$in"|tr '/' '_')
#     cat $in | awk '$6>=10' | shuf -n $size -o $out -
# done


parallel "temp_{}=$(mktemp);cp $in $temp_{};cat $temp_{} | awk '\$6>=10' | shuf -n $size -o {}__$(echo $in|tr '/' '_') -"  ::: $(seq 2)
