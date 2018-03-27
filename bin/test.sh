#!/usr/bin/env bash


EXP=XZ68
genome=human
mode=SE
cutsite=AAGCTT
fastq=/home/garner1/Work/dataset/reduced_sequencing/test.fq.gz
time bash main.sh $EXP $genome $mode ../pattern/barcode-cutsite_"$EXP" $cutsite $fastq
