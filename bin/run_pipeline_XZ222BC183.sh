#!/bin/usr/env bash

if [ -f /home/garner1/Work/dataset/fastq/XZ222BC183.fastq.gz ]; then
if [ -f /home/garner1/Work/pipelines/cutseq/pattern/XZ222BC183 ]; then
bash main.sh XZ222BC183 human SE /home/garner1/Work/pipelines/cutseq/pattern/XZ222BC183 AAGCTT /home/garner1/Work/dataset/fastq/XZ222BC183.fastq.gz
fi
fi
