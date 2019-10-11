#!/bin/usr/env bash

if [ -f /home/garner1/Work/dataset/fastq/NZ12/NZ12BICRO195.fastq.gz ]; then
if [ -f /home/garner1/Work/pipelines/cutseq/pattern/NZ12BICRO195 ]; then
bash main.sh NZ12BICRO195 human SE /home/garner1/Work/pipelines/cutseq/pattern/NZ12BICRO195 CATG /home/garner1/Work/dataset/fastq/NZ12/NZ12BICRO195.fastq.gz
fi
fi
