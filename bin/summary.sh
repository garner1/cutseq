#!/usr/bin/env bash
datadir=$1
oldir=$PDW
cd $datadir
echo 'Data directory:'$datadir 
for barcode in `ls outdata/*bam|rev|cut -d'.' -f3|cut -d'/' -f1|rev`; do
    echo '#################################'
    echo 'with barcode:' $barcode
    echo '#reads mapped:' `samtools view -c -F 260 auxdata/$barcode.bam`
    echo '#UMI on genome:' `wc -l auxdata/myfile_$barcode|cut -d' ' -f1`
    echo '#UMI with a ref-cutsite:' `wc -l outdata/tag-loc-qscore-strand__$barcode.bed|cut -d' ' -f1`
    echo '#unique sites:' `cut -f2,3 outdata/tag-loc-qscore-strand__$barcode.bed | LC_ALL=C sort -u | wc -l`
    echo '#################################'
done
cd $oldir


