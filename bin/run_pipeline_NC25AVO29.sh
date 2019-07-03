#!/bin/usr/env bash

if [ -f /home/garner1/Work/dataset/fastq/NC25AVO29_R1.fastq.gz ]; then
if [ -f /home/garner1/Work/dataset/fastq/NC25AVO29_R2.fastq.gz ]; then
if [ -f /home/garner1/Work/pipelines/cutseq/pattern/NC25AVO29 ]; then
bash main.sh NC25AVO29 human PE /home/garner1/Work/pipelines/cutseq/pattern/NC25AVO29 AAGCTT /home/garner1/Work/dataset/fastq/NC25AVO29_R1.fastq.gz /home/garner1/Work/dataset/fastq/NC25AVO29_R2.fastq.gz
fi
fi
fi
