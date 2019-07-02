#!/bin/usr/env bash

if [ -f /home/garner1/Work/dataset/fastq/cutseq/XZ216BICRO181.fastq.gz ]; then
if [ -f /home/garner1/Work/pipelines/cutseq/pattern/XZ216BICRO181 ]; then
bash main.sh XZ216BICRO181 human SE /home/garner1/Work/pipelines/cutseq/pattern/XZ216BICRO181 CATG /home/garner1/Work/dataset/fastq/cutseq/XZ216BICRO181.fastq.gz
fi
fi
