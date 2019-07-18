#!/bin/usr/env bash

if [ -f /home/garner1/Work/dataset/fastq/XZ239BC188.fastq.gz ]; then
if [ -f /home/garner1/Work/pipelines/cutseq/pattern/XZ239BC188 ]; then
bash main.sh XZ239BC188 human SE /home/garner1/Work/pipelines/cutseq/pattern/XZ239BC188 AAGCTT /home/garner1/Work/dataset/fastq/XZ239BC188.fastq.gz
fi
fi
