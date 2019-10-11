#!/bin/usr/env bash

if [ -f /home/garner1/Work/dataset/fastq/XZ250BICRO192.fastq.gz ]; then
if [ -f /home/garner1/Work/pipelines/cutseq/pattern/XZ250BICRO192 ]; then
bash main.sh XZ250BICRO192 human SE /home/garner1/Work/pipelines/cutseq/pattern/XZ250BICRO192 CATG /home/garner1/Work/dataset/fastq/XZ250BICRO192.fastq.gz
fi
fi
