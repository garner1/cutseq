#!/usr/bin/env bash

out=$1
quality=$2

# echo "Filter out centromeres and telomeres"
file=$out/q"$quality".bed
ref=~/Work/pipelines/data/hg19-telomere-centromere-telomere.bed
bedtools intersect -v -a $file -b $ref > $out/chr-loc-umi_q"$quality"
# echo Done
