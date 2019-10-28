#!/bin/usr/env bash

if [ -f /home/garner1/Work/dataset/fastq/NZ11/NZ11BICRO195.fastq.gz ]; then
if [ -f /home/garner1/Work/pipelines/cutseq/pattern/NZ11BICRO195 ]; then
bash main.sh NZ11BICRO195 human SE /home/garner1/Work/pipelines/cutseq/pattern/NZ11BICRO195 /home/garner1/Work/dataset/fastq/NZ11/NZ11BICRO195.fastq.gz
fi
fi
