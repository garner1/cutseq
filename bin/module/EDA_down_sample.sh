#!/usr/bin/env bash

in=$1				# input bed file
size=$2				# size of the random sample

for ind in $(seq 2);do
    out="$ind"__$(echo "$in"|tr '/' '_')
    shuf -n $size -o $out $in
done
