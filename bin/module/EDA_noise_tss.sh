#!/usr/bin/env bash

path1=$1			# full path to directories to be compared
path2=$2
window=$3			# resolution of the binned genome
metric=$4			# {sym,asym,norm_1,norm_2}

#SELECT ONLY COMMON REGIONS
rm -f "$path1"/loc_count*
rm -f "$path2"/loc_count*
ls "$path1"/?_?.bed | cut -d'/' -f9 > file1
ls "$path2"/?_?.bed | cut -d'/' -f9 > file2
join file1 file2 > common_regions
rm file1 file2

#create bed files with count of unique molecules per location
parallel "cat '$path1'/{} |./EDA_tss.sh - 1_{} 2_{} '$window'|cut -f4 > '$path1'/tss_{}" ::: $(cat common_regions)
parallel "cat '$path2'/{} |./EDA_tss.sh - 1_{} 2_{} '$window'|cut -f4 > '$path2'/tss_{}" ::: $(cat common_regions)
rm -f 1_*.bed 2_*.bed

#compare descriptors
parallel -k "echo {};python KL_divergence.py '$path1'/{} '$path2'/{} '$metric'" ::: $(cat common_regions|cut -d'.' -f1|awk '{print "tss_"$1".bed"}')|paste - -|awk '{print $1,$NF}'

rm -f "$path1"/tss*
rm -f "$path2"/tss*
rm -f common_regions 
