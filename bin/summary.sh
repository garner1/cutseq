#!/usr/bin/env bash

# datadir=$1
# oldir=$PDW
# cd $datadir
# echo 'Data directory:'$datadir 
# for barcode in `ls outdata/*.bed|rev|cut -d'.' -f2|cut -d'_' -f1|rev`; do
#     echo '#################################'
#     echo 'with barcode:' $barcode
#     echo '#reads mapped:' `samtools view -c -F 260 outdata/$barcode.sorted.bam`
#     echo '#UMI on genome:' `wc -l outdata/myfile_$barcode|cut -d' ' -f1`
#     echo '#UMI with a ref-cutsite:' `wc -l outdata/tag-loc-qscore-strand__$barcode.bed|cut -d' ' -f1`
#     echo '#unique sites:' `cut -f2,3 outdata/tag-loc-qscore-strand__$barcode.bed | LC_ALL=C sort -u | wc -l`
#     echo '#################################'
# done
# cd $oldir

file=$1
echo 'File name:'$file
echo '#################################'
echo '#UMI with a ref-cutsite:' `wc -l "$file" | cut -d' ' -f1`
echo '#unique sites:' `cut -f1,2 "$file" | LC_ALL=C sort -u | wc -l`
echo '#################################'


