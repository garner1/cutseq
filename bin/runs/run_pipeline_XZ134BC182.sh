#!/bin/usr/env bash

if [ -f /home/garner1/Work/dataset/fastq/XZ134BC182.fastq.gz ]; then
if [ -f /home/garner1/Work/pipelines/cutseq/pattern/XZ134BC182 ]; then
bash main.sh XZ134BC182 human SE /home/garner1/Work/pipelines/cutseq/pattern/XZ134BC182 CATG /home/garner1/Work/dataset/fastq/XZ134BC182.fastq.gz
fi
fi
