#!/bin/usr/env bash

if [ -f /home/garner1/Work/dataset/fastq/XZ244BC188.fastq.gz ]; then
if [ -f /home/garner1/Work/pipelines/cutseq/pattern/XZ244BC188 ]; then
bash main.sh XZ244BC188 human SE /home/garner1/Work/pipelines/cutseq/pattern/XZ244BC188 CATG /home/garner1/Work/dataset/fastq/XZ244BC188.fastq.gz
fi
fi
