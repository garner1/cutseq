#!/usr/bin/env bash

datadir=$1
experiment=$2
barcode=$3
samfile=$4          
uniqueReads=$5      
uniqueLocations=$6


echo "Alignment statistics:" >> "$datadir"/"$experiment"/outdata/"$experiment"_"$barcode"_summary.txt
samtools flagstat $samfile >> "$datadir"/"$experiment"/outdata/"$experiment"_"$barcode"_summary.txt

echo "Number of left and right cuts:" >> "$datadir"/"$experiment"/outdata/"$experiment"_"$barcode"_summary.txt
cat $uniqueReads | grep -v "_" | cut -f4 | sort | uniq -c >> "$datadir"/"$experiment"/outdata/"$experiment"_"$barcode"_summary.txt

echo "Number of DSB locations:" >> "$datadir"/"$experiment"/outdata/"$experiment"_"$barcode"_summary.txt
cat $uniqueLocations | grep -v "_" | wc -l >> "$datadir"/"$experiment"/outdata/"$experiment"_"$barcode"_summary.txt

echo "Number of UMIs:" >> "$datadir"/"$experiment"/outdata/"$experiment"_"$barcode"_summary.txt
cat $uniqueReads | grep -v "_" | wc -l >> "$datadir"/"$experiment"/outdata/"$experiment"_"$barcode"_summary.txt
