#!/usr/bin/env bash

path1=$1			# full path to directories to be compared
path2=$2
resolution=$3			# resolution of the binned genome
metric=$4			# {sym,asym,norm_1,norm_2}
threshold=$5			# to cutoff regions with few reads

#SELECT ONLY COMMON REGIONS
rm -f "$path1"/loc_count*
rm -f "$path2"/loc_count*
ls "$path1"/?_?.bed | cut -d'/' -f9 > file1
ls "$path2"/?_?.bed | cut -d'/' -f9 > file2
join file1 file2 > common_regions
rm file1 file2

#create bed files with count of unique molecules per location
parallel "cat '$path1'/{} | cut -f-2 | uniq -c | awk -v OFS='\t' '{print \$2,\$3,\$3+1,\$1}' > '$path1'/loc_count_{}" ::: $(cat common_regions)
parallel "cat '$path2'/{} | cut -f-2 | uniq -c | awk -v OFS='\t' '{print \$2,\$3,\$3+1,\$1}' > '$path2'/loc_count_{}" ::: $(cat common_regions)

#create bed files representing the binned genome
~/Work/pipelines/aux.scripts/make-windows.sh $resolution hg19 > A.bed

#count the number of molecules in each bin
rm -f "$path1"/*descriptor*
rm -f "$path2"/*descriptor*
parallel 'bedtools intersect -a A.bed -b {} -c | awk -v OFS="\t" -v gap="_" "{print \$1gap\$2gap\$3,\$4}" | sort -k1,1 > {.}_descriptor.bed ' ::: $(ls "$path1"/loc_count_*)
parallel "bedtools intersect -a A.bed -b {} -c | awk -v OFS='\t' -v gap='_' '{print \$1gap\$2gap\$3,\$4}' | sort -k1,1 > {.}_descriptor.bed " ::: $(ls "$path2"/loc_count_*)

#compare descriptors
rm -f "$path1"/4th_*
rm -f "$path2"/4th_*
parallel -k "cut -f2 '$path1'/{} > '$path1'/4th_{} " ::: $(cat common_regions|cut -d'.' -f1|awk '{print "loc_count_"$1"_descriptor.bed"}')
parallel -k "cut -f2 '$path2'/{} > '$path2'/4th_{} " ::: $(cat common_regions|cut -d'.' -f1|awk '{print "loc_count_"$1"_descriptor.bed"}')
parallel -k "echo {};cat '$path1'/{}|numsum;cat '$path2'/{}|numsum;python KL_divergence.py '$path1'/{} '$path2'/{} '$metric'" ::: $(cat common_regions|cut -d'.' -f1|awk '{print "4th_loc_count_"$1"_descriptor.bed"}')|paste - - - -|
awk -v thr="$threshold" '{if ($2>=thr && $3>=thr) print}'|cut -d'_' -f4-

rm -f "$path1"/loc_count*
rm -f "$path2"/loc_count*
rm -f "$path1"/*descriptor*
rm -f "$path2"/*descriptor*
rm -f "$path1"/4th_*
rm -f "$path2"/4th_*
rm -f mydata_loc_*
