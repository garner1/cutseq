#!/usr/bin/env bash

samtools view -f 66 ~/Work/dataset/xz9/outdata/xz9.sam | 
cut -f1,4 | 
LC_ALL=C sort --parallel=8 --temporary-directory=$HOME/tmp -k1,1 > ~/Work/dataset/xz9/outdata/mapped-r1.txt & pid1=$!

samtools view -f 130 ~/Work/dataset/xz9/outdata/xz9.sam |
cut -f1,4 | 
LC_ALL=C sort --parallel=8 --temporary-directory=$HOME/tmp -k1,1 > ~/Work/dataset/xz9/outdata/mapped-r2.txt & pid2=$! 
wait $pid1
wait $pid2

LC_ALL=C join ~/Work/dataset/xz9/outdata/mapped-r1.txt ~/Work/dataset/xz9/outdata/mapped-r2.txt > ~/Work/dataset/xz9/outdata/join-r1-r2.txt

cat ~/Work/dataset/xz9/outdata/join-r1-r2.txt | awk '{print $1,($3-$2)}' > ~/Work/dataset/xz9/outdata/id-gap.txt

cat ~/Work/dataset/xz9/outdata/id-gap.txt | cut -d' ' -f2 | sort -n | uniq -c | awk '{print $2,$1}' > ~/Work/dataset/xz9/outdata/count-gap
cat ~/Work/dataset/xz9/outdata/mapped-r1.txt | cut -f2 | sort -n | uniq -c | awk '{print $2,$1}' > ~/Work/dataset/xz9/outdata/count-r1
cat ~/Work/dataset/xz9/outdata/mapped-r2.txt | cut -f2 | sort -n | uniq -c | awk '{print $2,$1}' > ~/Work/dataset/xz9/outdata/count-r2
