#!/bin/usr/env bash

if [ -f /home/garner1/Work/dataset/fastq/XZ246BC188.fastq.gz ]; then
if [ -f /home/garner1/Work/pipelines/cutseq/pattern/XZ246BC188 ]; then
bash main.sh XZ246BC188 human SE /home/garner1/Work/pipelines/cutseq/pattern/XZ246BC188 CATG /home/garner1/Work/dataset/fastq/XZ246BC188.fastq.gz
fi
fi
