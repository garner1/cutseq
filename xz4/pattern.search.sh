#! /usr/bin/env bash
patfile=$1

cat ~/Work/dataset/xz4/XZ4_L005_R1_001.fastq | paste - - - - | cut -f 1,2 | sed 's/^@/>/' | tr "\t" "\n" > ~/Work/dataset/xz4/r1.fa

cat  ~/Work/dataset/xz4/r1.fa | parallel --tmpdir $HOME/tmp --block 100M -k --pipe -L 2 "scan_for_matches $patfile - " > ~/Work/dataset/xz4/filtered.r1.fa
