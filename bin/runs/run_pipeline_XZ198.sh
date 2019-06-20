#!/bin/usr/env bash

if [ -f /home/garner1/Work/dataset/fastq/XZ198_R1.fastq.gz ]; then
bash main.sh XZ198 human PE /home/garner1/Dropbox/pipelines/cutseq/pattern/XZ198 CATG /home/garner1/Work/dataset/fastq/XZ198_R{1,2}.fastq.gz
fi
