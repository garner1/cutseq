#!/bin/usr/env bash

if [ -f test/fastq/XZ133BC182.fastq.gz ]; then
if [ -f /home/garner1/Work/pipelines/cutseq/pattern/XZ133BC182 ]; then
bash main.sh XZ133BC182 human SE /home/garner1/Work/pipelines/cutseq/pattern/XZ133BC182 CATG test/fastq/XZ133BC182.fastq.gz
fi
fi
