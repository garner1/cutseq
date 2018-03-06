#!/usr/bin/env bash

parallel "samtools merge merged_XZ{}.bam XZ{}_BICRO65/outdata/*.deduplicated.bam XZ{}/outdata/*.deduplicated.bam" ::: 74 75 76 77 78

parallel "samtools sort merged_XZ{}.bam -o temporary_{}.bam" ::: 74 75 76 77 78
parallel "samtools index temporary_{}.bam" ::: 74 75 76 77 78

parallel "umi_tools dedup -I temporary_{}.bam -S {}_merged.deduplicated.bam --edit-distance-threshold 2 -L {}_group.log" ::: 74 75
parallel "umi_tools dedup -I temporary_{}.bam -S {}_merged.deduplicated.bam --edit-distance-threshold 2 -L {}_group.log" ::: 76
parallel "umi_tools dedup -I temporary_{}.bam -S {}_merged.deduplicated.bam --edit-distance-threshold 2 -L {}_group.log" ::: 77
parallel "umi_tools dedup -I temporary_{}.bam -S {}_merged.deduplicated.bam --edit-distance-threshold 2 -L {}_group.log" ::: 78
