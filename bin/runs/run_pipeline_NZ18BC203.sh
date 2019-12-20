#!/bin/usr/env bash

if [ -f /home/garner1/Work/dataset/fastq/BC203/NZ18BC203.fastq.gz ]; then
if [ -f /home/garner1/Work/pipelines/cutseq/pattern/NZ18BC203 ]; then
bash main.sh NZ18BC203 human SE /home/garner1/Work/pipelines/cutseq/pattern/NZ18BC203 CATG /home/garner1/Work/dataset/fastq/BC203/NZ18BC203.fastq.gz
fi
fi
