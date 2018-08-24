#!/usr/bin/env bash

bam1=$1
bam2=$2
newdir=$3

mkdir $newdir
samtools merge $newdir/merged.bam $bam1 $bam2
cd $newdir
samtools sort merged.bam -o merged.sorted.bam
samtools index merged.sorted.bam
umi_tools dedup -I merged.sorted.bam --paired -S merged.deduplicated.bam --edit-distance-threshold 2 -L merged.group.log
bam2bed < merged.deduplicated.bam | cut -f-17 > merged.deduplicated.bed
