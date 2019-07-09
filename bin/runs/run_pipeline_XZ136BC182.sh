#!/bin/usr/env bash

if [ -f /home/garner1/Work/dataset/fastq/XZ136BC182.fastq.gz ]; then
if [ -f /home/garner1/Work/pipelines/cutseq/pattern/XZ136BC182 ]; then
bash main.sh XZ136BC182 human SE /home/garner1/Work/pipelines/cutseq/pattern/XZ136BC182 CATG /home/garner1/Work/dataset/fastq/XZ136BC182.fastq.gz
fi
fi
