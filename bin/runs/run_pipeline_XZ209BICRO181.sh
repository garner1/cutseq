#!/bin/usr/env bash

if [ -f /home/garner1/Work/dataset/fastq/cutseq/XZ209BICRO181.fastq.gz ]; then
if [ -f /home/garner1/Work/pipelines/cutseq/pattern/XZ209BICRO181 ]; then
bash main.sh XZ209BICRO181 human SE /home/garner1/Work/pipelines/cutseq/pattern/XZ209BICRO181 AAGCTT /home/garner1/Work/dataset/fastq/cutseq/XZ209BICRO181.fastq.gz
fi
fi
