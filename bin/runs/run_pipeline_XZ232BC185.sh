#!/bin/usr/env bash

if [ -f /home/garner1/Work/dataset/fastq/XZ232BC185.fastq.gz ]; then
if [ -f /home/garner1/Work/pipelines/cutseq/pattern/XZ232BC185 ]; then
bash main.sh XZ232BC185 human SE /home/garner1/Work/pipelines/cutseq/pattern/XZ232BC185 AAGCTT /home/garner1/Work/dataset/fastq/XZ232BC185.fastq.gz
fi
fi
