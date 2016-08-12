#! /usr/bin/env bash

patfile=$1
in=$HOME/Work/dataset/xz1
r1=$HOME/Work/dataset/XZ1_S1_L001_R1_AELKA.fastq.gz

gunzip -c $r1 | paste - - - - | cut -f 1,2 | sed 's/^@/>/' | tr "\t" "\n" > $in/r1.fa

cat $in/r1.fa | parallel --tmpdir $HOME/tmp --block 100M -k --pipe -L 2 "scan_for_matches $patfile - " > $in/filtered.r1.fa
