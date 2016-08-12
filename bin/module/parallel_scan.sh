#!/usr/bin/env bash

# FILTER READS ALLOWING FOR 1 MISMATCH IN BARCODE AND 1 MISMATCH IN CUTSITE, WHILE THE UMI LENGTH MIGHT BE SET

in=$1
mode=$2
barcode_file=$3
r1=$4
r2=$5

echo "Process the fastq file ..."

################################################################################

echo "Unzip the raw data file ..."

if [ "$mode" == "SE" ]; then
    gunzip -c $r1 > $in/r1.fq
fi
if [ "$mode" == "PE" ]; then
    gunzip -c $r1 > $in/r1.fq & pid1=$!
    gunzip -c $r2 | paste - - - - | LC_ALL=C sort --parallel=8 --temporary-directory=$HOME/tmp -k1,1 > $in/r2oneline.fq & pid2=$!
    wait $pid1
    wait $pid2
fi

cat $in/r1.fq | paste - - - - | LC_ALL=C sort --parallel=8 --temporary-directory=$HOME/tmp -k1,1 > $in/r1oneline.fq & pid1=$!
cat $in/r1.fq | paste - - - - | LC_ALL=C sort --parallel=8 --temporary-directory=$HOME/tmp -k1,1 |
cut -f1,2 | tr '\t@' '\n>'  > $in/r1.fa & pid2=$!
wait $pid1
wait $pid2

################################################################################

echo "Generate patfiles for each barcode ..."

cat $barcode_file | awk '{print "^ 8...8",substr($1,1,8)"[1,0,0]",substr($1,9,6)"[1,0,0]","1...1000","$" > "barcode_"substr($1,1,8)}'
# cat $barcode_file | awk '{print "^",substr($1,1,8)"[1,0,0]",substr($1,9,6)"[1,0,0]","1...1000","$" > "barcode_"substr($1,1,8)}' #for NC85 with no UMI

echo "Split FA files to satisfy scan_for_match 100M lines limit ..."
olddir=`echo $PWD`
cd $in
cat r1.fa | paste - - |LC_ALL=C split -l 90000000 
cd $olddir

echo "Scan for barcodes ..."
rm -f $in/barcode_*.fa
for file in $(ls $in/xa?); do
    parallel "cat $file |tr '\t' '\n' | LC_ALL=C scan_for_matches {} - >> $in/{}.fa" ::: $(ls barcode_*)
done
rm -f barcode_* $in/xa?

echo "Generate the barcoded FQ files ..."
parallel -k "cat {}|paste - -|awk '{print \$1\$(NF-1)\$NF}'|tr ']>' '\n@'|cut -d':' -f-7|paste - - > {.}.fa-1line" ::: \
$(ls $in/barcode_*.fa)
parallel -k "LC_ALL=C join {} $in/r1oneline.fq|awk '{print \$1,\$2,\$5,substr(\$NF,length(\$NF)-length(\$2),length(\$2))}'|tr ' ' '\n' > {.}.fq" ::: \
$(ls $in/barcode_*.fa-1line)
if [ "$mode" == "PE" ];then
    parallel -k "cat {} | paste - - - -|LC_ALL=C sort --parallel=8 --temporary-directory=$HOME/tmp -k1,1 |LC_ALL=C join - "$in"/r2oneline.fq | cut -d' ' -f1,6- | tr ' ' '\n' > {.}-r2.fq" ::: `ls "$in"/barcode_*[A-Z].fq` 
fi
