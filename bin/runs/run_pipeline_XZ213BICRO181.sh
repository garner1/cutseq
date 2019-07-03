#!/bin/usr/env bash

if [ -f /home/garner1/Work/dataset/fastq/cutseq/XZ213BICRO181.fastq.gz ]; then
if [ -f /home/garner1/Work/pipelines/cutseq/pattern/XZ213BICRO181 ]; then
bash main.sh XZ213BICRO181 human SE /home/garner1/Work/pipelines/cutseq/pattern/XZ213BICRO181 CATG /home/garner1/Work/dataset/fastq/cutseq/XZ213BICRO181.fastq.gz
fi
fi
