#!/usr/bin/env bash

#IT OUTPUTS THE LIST OF PAM GENES WITH 
# GENE,RC,CS,RC/(CS+1)

bedfile=$1				# full path to bed file 1

pam50=~/Work/pipelines/data/PAM50

cat $pam50 | LC_ALL=C sort -k1,1 > auxfile

LC_ALL=C join auxfile $bedfile|tr " " "\t"
rm auxfile
