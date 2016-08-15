#!/usr/bin/env bash

out=$1
quality=$2

ref=~/Work/pipelines/data/consensusBlacklist.bed

# echo "Filter out blacklist"
file="$out"/chr-loc-umi_q"$quality"
bedtools intersect -v -a $file -b $ref > $out/auxfiltered
mv $out/auxfiltered $file
# echo Done
