#!/usr/bin/env bash

datadir=$1
experiment=$2
barcode=$3
fastq=$4         
samfile=$5          
uniqueReads=$6      
uniqueLocations=$7  



# echo "Number of fragments:" > "$datadir"/"$experiment"/outdata/"$experiment"_"$barcode"_summary.txt
# wc -l $fasta  >> "$datadir"/"$experiment"/outdata/"$experiment"_"$barcode"_summary.txt
echo "Number of fragment with prefix:" > "$datadir"/"$experiment"/outdata/"$experiment"_"$barcode"_summary.txt
cat $fastq | paste - - - - | wc -l >> "$datadir"/"$experiment"/outdata/"$experiment"_"$barcode"_summary.txt
echo "Alignment statistics:" >> "$datadir"/"$experiment"/outdata/"$experiment"_"$barcode"_summary.txt
samtools flagstat $samfile >> "$datadir"/"$experiment"/outdata/"$experiment"_"$barcode"_summary.txt
echo "Number of left and right cuts:" >> "$datadir"/"$experiment"/outdata/"$experiment"_"$barcode"_summary.txt
cat $uniqueReads | grep -v "_" | cut -f4 | sort | uniq -c >> "$datadir"/"$experiment"/outdata/"$experiment"_"$barcode"_summary.txt
echo "Number of DSB locations:" >> "$datadir"/"$experiment"/outdata/"$experiment"_"$barcode"_summary.txt
cat $uniqueLocations | grep -v "_" | wc -l >> "$datadir"/"$experiment"/outdata/"$experiment"_"$barcode"_summary.txt
echo "Number of UMIs:" >> "$datadir"/"$experiment"/outdata/"$experiment"_"$barcode"_summary.txt
cat $uniqueReads | grep -v "_" | wc -l >> "$datadir"/"$experiment"/outdata/"$experiment"_"$barcode"_summary.txt
