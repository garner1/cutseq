#!/usr/bin/env bash

out=$1
aux=$2
quality=$3
barcode=$4
in=$5

# samtools view -F 0x10 $out/"$barcode".bam | cut -f1,3,4 | awk '{print $0, "\t+"}' > $aux/forward & pid1=$!
# samtools view -f 0x10 $out/"$barcode".bam | cut -f1,3,4 | awk '{print $0, "\t-"}' > $aux/reverse & pid2=$!

# wait $pid1
# wait $pid2

# cat $aux/forward $aux/reverse | LC_ALL=C sort --parallel=8 --temporary-directory=$HOME/tmp -k1,1 > $aux/id.chr.loc.strand & pid1=$!

samtools view $out/"$barcode".bam |cut -f1,3,4 | LC_ALL=C sort --parallel=8 --temporary-directory=$HOME/tmp -k1,1 > $aux/id.chr.loc & pid1=$!

cat $in/barcode_"$barcode".fa | tr -d ">" | paste - - | awk '{print $1,"\t",$2}' | tr '\t' '\n'|cut -d':' -f-7|paste - -|
LC_ALL=C sort --parallel=8 --temporary-directory=$HOME/tmp -k1,1 > $aux/id.umi & pid2=$!
wait $pid1
wait $pid2

LC_ALL=C join $aux/id.chr.loc $aux/id.umi | LC_ALL=C sort --parallel=8 --temporary-directory=$HOME/tmp -t' ' -k2,2 -k3,3n -k4,4 -k5,5 | awk '{print $2,$3,$3,$4,$5,$1}' | tr " " "\t" > $out/q"$quality".bed 
