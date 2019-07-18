#!/bin/usr/env bash

if [ -f /home/garner1/Work/dataset/fastq/XZ228BC188.fastq.gz ]; then
if [ -f /home/garner1/Work/pipelines/cutseq/pattern/XZ228BC188 ]; then
bash main.sh XZ228BC188 human SE /home/garner1/Work/pipelines/cutseq/pattern/XZ228BC188 AAGCTT /home/garner1/Work/dataset/fastq/XZ228BC188.fastq.gz
fi
fi
