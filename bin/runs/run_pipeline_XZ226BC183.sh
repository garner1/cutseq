#!/bin/usr/env bash

if [ -f /home/garner1/Work/dataset/fastq/XZ226BC183.fastq.gz ]; then
if [ -f /home/garner1/Work/pipelines/cutseq/pattern/XZ226BC183 ]; then
bash main.sh XZ226BC183 human SE /home/garner1/Work/pipelines/cutseq/pattern/XZ226BC183 CATG /home/garner1/Work/dataset/fastq/XZ226BC183.fastq.gz
fi
fi
