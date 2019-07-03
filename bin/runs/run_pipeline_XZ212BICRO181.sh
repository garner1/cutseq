#!/bin/usr/env bash

if [ -f /home/garner1/Work/dataset/fastq/cutseq/XZ212BICRO181.fastq.gz ]; then
if [ -f /home/garner1/Work/pipelines/cutseq/pattern/XZ212BICRO181 ]; then
bash main.sh XZ212BICRO181 human SE /home/garner1/Work/pipelines/cutseq/pattern/XZ212BICRO181 CATG /home/garner1/Work/dataset/fastq/cutseq/XZ212BICRO181.fastq.gz
fi
fi
