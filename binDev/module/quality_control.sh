#!/usr/bin/env bash
r1=$1
numbproc=$2
out=$3

echo 'Quality control ...'

fastqc -t $numbproc -o $out --nogroup $r1

echo 'Done'
