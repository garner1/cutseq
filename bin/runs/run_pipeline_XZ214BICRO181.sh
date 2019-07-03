#!/bin/usr/env bash

if [ -f /home/garner1/Work/dataset/fastq/cutseq/XZ214BICRO181.fastq.gz ]; then
if [ -f /home/garner1/Work/pipelines/cutseq/pattern/XZ214BICRO181 ]; then
bash main.sh XZ214BICRO181 human SE /home/garner1/Work/pipelines/cutseq/pattern/XZ214BICRO181 CATG /home/garner1/Work/dataset/fastq/cutseq/XZ214BICRO181.fastq.gz
fi
fi
