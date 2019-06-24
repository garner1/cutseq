#!/bin/usr/env bash

if [ -f /home/garner1/Work/dataset/fastq/XZ128BC143_R1.fastq.gz ]; then
bash main.sh XZ128BC143 human PE /home/garner1/Dropbox/pipelines/cutseq/pattern/XZ128BC143 CATG /home/garner1/Work/dataset/fastq/XZ128BC143_R1.fastq.gz /home/garner1/Work/dataset/fastq/XZ128BC143_R2.fastq.gz
fi
