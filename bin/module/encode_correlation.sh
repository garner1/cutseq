#!/usr/bin/env bash

data=$1
encode=$2
outfile=$3

sed 's/^/chr/' $1 | tail -n+2 | bedtools intersect -a - -b $encode -wa -wb | tr '.' ',' | datamash -s -g10 median 5 > $outfile
