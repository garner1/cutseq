#!/bin/usr/env bash

if [ -f /home/garner1/Work/dataset/fastq/MS16/MS16BICRO195.fastq.gz ]; then
if [ -f /home/garner1/Work/pipelines/cutseq/pattern/MS16BICRO195 ]; then
bash main.sh MS16BICRO195 human SE /home/garner1/Work/pipelines/cutseq/pattern/MS16BICRO195 CATG /home/garner1/Work/dataset/fastq/MS16/MS16BICRO195.fastq.gz
fi
fi
