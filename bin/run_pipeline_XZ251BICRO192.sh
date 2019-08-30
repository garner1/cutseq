#!/bin/usr/env bash

if [ -f /home/garner1/Work/dataset/fastq/XZ251BICRO192.fastq.gz ]; then
if [ -f /home/garner1/Work/pipelines/cutseq/pattern/XZ251BICRO192 ]; then
bash main.sh XZ251BICRO192 human SE /home/garner1/Work/pipelines/cutseq/pattern/XZ251BICRO192 CATG /home/garner1/Work/dataset/fastq/XZ251BICRO192.fastq.gz
fi
fi
