#!/usr/bin/env bash

exp=$1

# sort all bam files
parallel -k "~/Work/pipelines/aux.scripts/GC-content.sh {}" ::: ~/Work/dataset/restseq/"$exp"/outdata/*.bam
