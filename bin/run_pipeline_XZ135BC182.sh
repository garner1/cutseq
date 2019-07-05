#!/bin/usr/env bash

if [ -f /home/garner1/Work/dataset/fastq/XZ135BC182.fastq.gz ]; then
if [ -f /home/garner1/Work/pipelines/cutseq/pattern/XZ135BC182 ]; then
bash main.sh XZ135BC182 human SE /home/garner1/Work/pipelines/cutseq/pattern/XZ135BC182 CATG /home/garner1/Work/dataset/fastq/XZ135BC182.fastq.gz
fi
fi
