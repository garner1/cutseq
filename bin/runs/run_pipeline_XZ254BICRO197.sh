#!/bin/usr/env bash

if [ -f /home/garner1/Work/dataset/fastq/XZ254BICRO197.fastq.gz ]; then
if [ -f /home/garner1/Work/pipelines/cutseq/pattern/XZ254BICRO197 ]; then
bash main.sh XZ254BICRO197 human SE /home/garner1/Work/pipelines/cutseq/pattern/XZ254BICRO197 CATG /home/garner1/Work/dataset/fastq/XZ254BICRO197.fastq.gz
fi
fi
