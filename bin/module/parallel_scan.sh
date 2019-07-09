#!/usr/bin/env bash

# FILTER READS ALLOWING FOR 1 MISMATCH IN BARCODE AND 1 MISMATCH IN CUTSITE, WHILE THE UMI LENGTH MIGHT BE SET

cutsite=$1
in=$2
mode=$3
barcode_file=$4
mm=$5
r1=$6
r2=$7

echo "Process the fastq file ..."
################################################################################
echo "Unzip the raw data file ..."
if [ "$mode" == "SE" ];then
    if [ ! -f "$in"/r1_0.fq.gz ]; then
	zcat "$r1" | cut -d':' -f-7 | gzip - > $in/r1_0.fq.gz
    fi
    if [ ! -f "$in"/processed.fastq.gz ]; then
	/usr/local/share/anaconda3/bin/umi_tools extract --stdin="$in/r1_0.fq.gz" --bc-pattern=NNNNNNNNXXXXXXXX --log=processed.log --stdout "$in"/processed.fastq.gz
    fi
    if [ ! -f "$in"/r1.fq ]; then
	gunzip -c "$in"/processed.fastq.gz > "$in"/r1.fq
	cat $in/r1.fq | paste - - - - | LC_ALL=C sort --parallel=8 --temporary-directory=$HOME/tmp -k1,1 > $in/r1oneline.fq & pid1=$!
	cat $in/r1.fq | paste - - - - | cut -f 1,2 | sed 's/^@/>/' | tr "\t" "\n" > $in/r1.fa & pid2=$!
	wait $pid1
	wait $pid2
    fi
fi
if [ "$mode" == "PE" ];then
    if [ ! -f "$in"/r1_0.fq.gz ]; then
	zcat "$r1" | cut -d':' -f-7 | gzip > $in/r1_0.fq.gz
    fi
    if [ ! -f "$in"/r2_0.fq.gz ]; then
	zcat "$r2" | cut -d':' -f-7 | gzip > $in/r2_0.fq.gz
    fi
    if [ ! -f "$in"/processed.2.fastq.gz ]; then
	/usr/local/share/anaconda3/bin/umi_tools extract --stdin="$in/r1_0.fq.gz" --read2-in="$in/r2_0.fq.gz" --bc-pattern=NNNNNNNNXXXXXXXX --log=processed.log --stdout "$in"/processed.1.fastq.gz --read2-out="$in"/processed.2.fastq.gz
    fi
    if [ ! -f "$in"/r1.fq ]; then
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
cat $barcode_file |
    awk -v len="$len" -v mm="$mm" '{print "^ ",substr($1,1,8)"["mm",0,0]",substr($1,9,len)"["mm",0,0]","1...1000","$" > "barcode_"substr($1,1,8)}'
cd $olddir
################################################################################
echo "Split FA files to satisfy scan_for_match 100M lines limit ..."
olddir=`echo $PWD`
cd $in
# if [ ! -f "$in"/barcode_????????.fa ]; then
cat r1.fa | paste - - |LC_ALL=C split -l 90000000
echo "Scan for barcodes ..."
rm -f $in/barcode_*.fa
for file in $(ls $in/xa?); do
    parallel "cat $file |tr '\t' '\n' | LC_ALL=C scan_for_matches {} - >> {}.fa" ::: `ls "$in"/barcode_????????`
done
rm -f $in/xa?
# fi
cd $olddir


echo "Generate the barcoded FQ files ..."
parallel -k "cat {}|paste - -|awk '{print \$1\$(NF-1)\$NF}'|tr ']>' '\n@'|cut -d':' -f-7|paste - - | LC_ALL=C sort --parallel=8 --temporary-directory=$HOME/tmp -k1,1 > {.}.fa-1line" ::: $(ls $in/barcode_*.fa)
parallel -k "LC_ALL=C join {} $in/r1oneline.fq|awk '{print \$1,\$2,\"+\",substr(\$NF,length(\$NF)-length(\$2),length(\$2))}'|tr ' ' '\n' > {.}.fq" ::: $(ls $in/barcode_*.fa-1line)

if [ "$mode" == "PE" ];then
    parallel -k "cat {} | paste - - - -|LC_ALL=C sort --parallel=8 --temporary-directory=$HOME/tmp -k1,1 -o {}.sort" ::: `ls "$in"/barcode_*[A-Z].fq`
    parallel -k "LC_ALL=C join {}.sort ${in}/r2oneline.fq | cut -d' ' -f1,5- | tr ' ' '\n' > {.}-r2.fq" ::: `ls "$in"/barcode_*[A-Z].fq`
fi
