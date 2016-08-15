#!/usr/bin/env bash

input=$1
ref=~/Work/pipelines/data/consensusBlacklist.bed

echo "Filter out blacklist"
bedtools intersect -v -abam $input -b $ref > $input.aux
mv $input.aux $input
echo Done
