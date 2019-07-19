#!/bin/usr/env bash

if [ -f /home/garner1/Work/dataset/fastq/XZ241BC188.fastq.gz ]; then
if [ -f /home/garner1/Work/pipelines/cutseq/pattern/XZ241BC188 ]; then
bash main.sh XZ241BC188 human SE /home/garner1/Work/pipelines/cutseq/pattern/XZ241BC188 AAGCTT /home/garner1/Work/dataset/fastq/XZ241BC188.fastq.gz
fi
fi
