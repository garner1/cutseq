#!/bin/usr/env bash

if [ -f /home/garner1/Work/dataset/fastq/XZ237BC185.fastq.gz ]; then
if [ -f /home/garner1/Work/pipelines/cutseq/pattern/XZ237BC185 ]; then
bash main.sh XZ237BC185 human SE /home/garner1/Work/pipelines/cutseq/pattern/XZ237BC185 CATG /home/garner1/Work/dataset/fastq/XZ237BC185.fastq.gz
fi
fi
