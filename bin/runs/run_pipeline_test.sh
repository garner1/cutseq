#!/bin/usr/env bash

if [ -f test/fastq/test.fastq.gz ]; then
if [ -f /home/garner1/Work/pipelines/cutseq/pattern/test ]; then
bash main.sh test human SE /home/garner1/Work/pipelines/cutseq/pattern/test CATG test/fastq/test.fastq.gz
fi
fi
