#!/bin/usr/env bash

if [ -f /home/garner1/Work/dataset/fastq/XZ234BC188.fastq.gz ]; then
if [ -f /home/garner1/Work/pipelines/cutseq/pattern/XZ234BC188 ]; then
bash main.sh XZ234BC188 human SE /home/garner1/Work/pipelines/cutseq/pattern/XZ234BC188 CATG /home/garner1/Work/dataset/fastq/XZ234BC188.fastq.gz
fi
fi
