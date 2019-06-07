#!/usr/bin/env bash

file=$1
tpos=0.3219281 #log2(2.5/2)
tneg=-0.4150375 #log2(1.5/2)

tail -n+2 $file | awk -v tpos=$tpos '$5>tpos' | cut -f1 | tr ':-' '\t\t' | bedtools merge -i stdin | sort -k1,1 -k2,2n > ${file}.amp.bed
tail -n+2 $file | awk -v tneg=$tneg '$5<tneg' | cut -f1 | tr ':-' '\t\t' | bedtools merge -i stdin | sort -k1,1 -k2,2n > ${file}.del.bed
tail -n+2 $file | awk -v tpos=$tpos '$5<tpos' | awk -v tneg=$tneg '$5>tneg' | cut -f1 | tr ':-' '\t\t' | bedtools merge -i stdin | sort -k1,1 -k2,2n > ${file}.null.bed

