#!/bin/usr/env bash

if [ -f /home/garner1/Work/dataset/fastq/RM224/RM224BICRO195.fastq.gz ]; then
if [ -f /home/garner1/Work/pipelines/cutseq/pattern/RM224BICRO195 ]; then
bash main.sh RM224BICRO195 human SE /home/garner1/Work/pipelines/cutseq/pattern/RM224BICRO195 CATG /home/garner1/Work/dataset/fastq/RM224/RM224BICRO195.fastq.gz
fi
fi
