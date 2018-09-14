#!/usr/bin/env bash

# FILTER READS ALLOWING FOR 1 MISMATCH IN BARCODE AND 1 MISMATCH IN CUTSITE, WHILE THE UMI LENGTH MIGHT BE SET

cutsite=$1
in=$2
mode=$3
barcode_file=$4
r1=$5
r2=$6

echo "Process the fastq file ..."

################################################################################
echo "Unzip the raw data file ..."

if [ "$mode" == "SE" ];then
    if [ ! -f "$in"/processed.fastq.gz ]; then
	umi_tools extract --stdin="$r1" --bc-pattern=NNNNNNNNXXXXXXXX --log=processed.log --stdout "$in"/processed.fastq.gz # Ns represent the random part of the barcode and Xs the fixed part
	gunzip -c "$in"/processed.fastq.gz > "$in"/r1.fq
	cat $in/r1.fq | paste - - - - | LC_ALL=C sort --parallel=8 --temporary-directory=$HOME/tmp -k1,1 > $in/r1oneline.fq & pid1=$!
	cat $in/r1.fq | paste - - - - | cut -f 1,2 | sed 's/^@/>/' | tr "\t" "\n" > $in/r1.fa & pid2=$!
	wait $pid1
	wait $pid2
    fi
fi
if [ "$mode" == "PE" ];then
    if [ ! -f "$in"/processed.2.fastq.gz ]; then
	umi_tools extract --stdin="$r1" --read2-in="$r2" --bc-pattern=NNNNNNNNXXXXXXXX --log=processed.log --stdout "$in"/processed.1.fastq.gz --read2-out="$in"/processed.2.fastq.gz
	gunzip -c "$in"/processed.1.fastq.gz > "$in"/r1.fq & pid1=$!
	gunzip -c "$in"/processed.2.fastq.gz > "$in"/r2.fq & pid2=$!
	wait $pid1
	wait $pid2
	cat $in/r1.fq | paste - - - - | LC_ALL=C sort --parallel=8 --temporary-directory=$HOME/tmp -k1,1 > $in/r1oneline.fq & pid1=$!
	cat $in/r1.fq | paste - - - - | cut -f 1,2 | sed 's/^@/>/' | tr "\t" "\n" > $in/r1.fa & pid2=$!
	cat $in/r2.fq | paste - - - - | LC_ALL=C sort --parallel=8 --temporary-directory=$HOME/tmp -k1,1 > $in/r2oneline.fq & pid3=$!
	wait $pid1
	wait $pid2
	wait $pid3
    fi
fi

################################################################################
echo "Generate patfiles for each barcode ..."
len=`echo $cutsite|awk '{print length}'`
olddir=`echo $PWD`
cd $in
cat $barcode_file | awk -v len="$len" '{print "^ ",substr($1,1,8)"[1,0,0]",substr($1,9,len)"[1,0,0]","1...1000","$" > "barcode_"substr($1,1,8)}' # IT IS BETTER TO WRITE FINAL BC IN DATA DIR
cd $olddir
################################################################################
echo "Split FA files to satisfy scan_for_match 100M lines limit ..."
olddir=`echo $PWD`
cd $in
cat r1.fa | paste - - |LC_ALL=C split -l 90000000 
cd $olddir

echo "Scan for barcodes ..."
rm -f $in/barcode_*.fa
for file in $(ls $in/xa?); do
    parallel "cat $file |tr '\t' '\n' | LC_ALL=C scan_for_matches {} - >> {}.fa" ::: `ls "$in"/barcode_????????`
done
rm -f $in/xa?
