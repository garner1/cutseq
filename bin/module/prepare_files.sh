#!/usr/bin/env bash

in=$1
mode=$2
r1=$3
r2=$4

echo "Process the fastq file ..."

################################################################################

if [ "$mode" == "SE" ]; then
    gunzip -c $r1 > $in/r1.fq
fi
if [ "$mode" == "PE" ]; then
    gunzip -c $r1 > $in/r1.fq & pid1=$!
    gunzip -c $r2 | paste - - - - | LC_ALL=C sort --parallel=8 --temporary-directory=$HOME/tmp -k1,1 > $in/r2oneline.fq & pid2=$!
    wait $pid1
    wait $pid2
fi

cat $in/r1.fq | paste - - - - | LC_ALL=C sort --parallel=8 --temporary-directory=$HOME/tmp -k1,1 > $in/r1oneline.fq

################################################################################

parallel -k "LC_ALL=C grep -F {} $in/r1oneline.fq > $in/{}.fq-1line" ::: `cat ~/Work/pipelines/restseq/pattern/barcode-cutsite` 

parallel -k "LC_ALL=C awk '{print \$1,substr(\$3,17),\$4,substr(\$5,17)}' {} | tr ' ' '\n' > {.}.fq" ::: `ls "$in"/*.fq-1line` & pid1=$!

parallel -k "cat {} | cut -f 1,2 | sed 's/^@/>/' |  tr '\t' '\n' > {.}.fa" ::: `ls "$in"/*.fq-1line` & pid2=$!

parallel -k "cat {} | cut -f 1,2 | sed 's/^@/>/' > {.}.fa-1line" ::: `ls "$in"/*.fq-1line` & pid3=$!

if [ "$mode" == "PE" ];then
    parallel -k "LC_ALL=C join {} "$in"/r2oneline.fq | cut -d' ' -f1,7- | tr ' ' '\n' > {.}-r2.fq" ::: `ls "$in"/*.fq-1line` & pid4=$!
    wait $pid4
fi

wait $pid1
wait $pid2
wait $pid3

echo 'Done'
