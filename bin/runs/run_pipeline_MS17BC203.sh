#!/bin/usr/env bash

if [ -f /home/garner1/Work/dataset/fastq/BC203/MS17BC203.fastq.gz ]; then
if [ -f /home/garner1/Work/pipelines/cutseq/pattern/MS17BC203 ]; then
bash main.sh MS17BC203 human SE /home/garner1/Work/pipelines/cutseq/pattern/MS17BC203 CATG /home/garner1/Work/dataset/fastq/BC203/MS17BC203.fastq.gz
fi
fi
