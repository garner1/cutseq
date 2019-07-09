#!/bin/usr/env bash

if [ -f /home/garner1/Work/dataset/fastq/XZ137BC182.fastq.gz ]; then
if [ -f /home/garner1/Work/pipelines/cutseq/pattern/XZ137BC182 ]; then
bash main.sh XZ137BC182 human SE /home/garner1/Work/pipelines/cutseq/pattern/XZ137BC182 CATG /home/garner1/Work/dataset/fastq/XZ137BC182.fastq.gz
fi
fi
