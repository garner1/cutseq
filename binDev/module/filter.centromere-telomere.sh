#!/usr/bin/env bash

input=$1
output=$2

echo "Filter out centromeres and telomeres"
ref=~/Work/pipelines/data/hg19-telomere-centromere-telomere.bed
bedtools intersect -v -abam $input -b $ref > $output
echo Done
