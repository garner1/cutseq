#!/bin/usr/env bash

if [ -f /home/garner1/Work/dataset/fastq/NZ17BC198.fastq.gz ]; then
if [ -f /home/garner1/Work/pipelines/cutseq/pattern/NZ17BC198 ]; then
bash main.sh NZ17BC198 human SE /home/garner1/Work/pipelines/cutseq/pattern/NZ17BC198 CATG /home/garner1/Work/dataset/fastq/NZ17BC198.fastq.gz
fi
fi
