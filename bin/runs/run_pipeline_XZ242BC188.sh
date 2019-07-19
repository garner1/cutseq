#!/bin/usr/env bash

if [ -f /home/garner1/Work/dataset/fastq/XZ242BC188.fastq.gz ]; then
if [ -f /home/garner1/Work/pipelines/cutseq/pattern/XZ242BC188 ]; then
bash main.sh XZ242BC188 human SE /home/garner1/Work/pipelines/cutseq/pattern/XZ242BC188 AAGCTT /home/garner1/Work/dataset/fastq/XZ242BC188.fastq.gz
fi
fi
