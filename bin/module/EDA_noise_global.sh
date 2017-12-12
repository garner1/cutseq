#!/usr/bin/env bash

path1=$1			# full path to directories to be compared
path2=$2
resolution=$3			# resolution of the binned genome

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
parallel ' bedtools intersect -a A.bed -b {} -c | awk -v OFS="\t" -v gap="_" "{print \$1gap\$2gap\$3,\$4}" | sort -k1,1 > {.}_descriptor.bed ' ::: $(ls "$path1"/loc_count_*)
parallel " bedtools intersect -a A.bed -b {} -c | awk -v OFS='\t' -v gap='_' '{print \$1gap\$2gap\$3,\$4}' | sort -k1,1 > {.}_descriptor.bed " ::: $(ls "$path2"/loc_count_*)

#compare descriptors
rm -f mydata
parallel "join '$path1'/{} '$path2'/{} | awk '{print \$3-\$2}' >> mydata  " ::: $(cat common_regions|cut -d'.' -f1|awk '{print "loc_count_"$1"_descriptor.bed"}')

#evaluation of the noise
echo "The statistical error on the read count per 10M bin is" $(cat mydata | datamash sstdev 1)
