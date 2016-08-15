#!/usr/bin/env bash

# THE OUTPUT BAM FILE WILL CONTAIN IN THE "CO" TAG THE UMI STRING

in=$1
aux=$2
barcode=$3
input=$4
output=$5

samtools view -H $input > header.sam  # extract header only
samtools view $input | LC_ALL=C sort --parallel=8 --temporary-directory=$HOME/tmp -k1,1 > $aux/id.sam & pid1=$!

cat $in/barcode_"$barcode".fa | tr -d ">" | paste - - | awk '{print $1,"\t",$2}' | tr '\t' '\n'|cut -d':' -f-7|paste - -|
LC_ALL=C sort --parallel=8 --temporary-directory=$HOME/tmp -k1,1 |awk '{print $1,"CO:Z:"$2}'> $aux/id.umi & pid2=$!

wait $pid1
wait $pid2

LC_ALL=C join $aux/id.sam $aux/id.umi | tr " " "\t" | cat header.sam - |
samtools view -bS - > $output

rm -f header.sam
