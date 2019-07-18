#!/bin/usr/env bash

if [ -f /home/garner1/Work/dataset/fastq/XZ248BC185.fastq.gz ]; then
if [ -f /home/garner1/Work/pipelines/cutseq/pattern/XZ248BC185 ]; then
bash main.sh XZ248BC185 human SE /home/garner1/Work/pipelines/cutseq/pattern/XZ248BC185 CATG /home/garner1/Work/dataset/fastq/XZ248BC185.fastq.gz
fi
fi
