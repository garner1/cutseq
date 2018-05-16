#!/usr/bin/env bash

datadir=$1
oldir=$PDW
cd $datadir
echo 'Data directory:'$datadir 
for barcode in `ls outdata/*.bam | rev | cut -d'.' -f3 | cut -d'/' -f1 | rev`; do
    echo '#################################'
    echo 'with barcode:' $barcode
    echo '#reads mapped:' `samtools view -c -F 260 auxdata/$barcode.sorted.bam` # no secondary alignment or unmapped
    echo '#UMI' `samtools view -c -F 260 outdata/$barcode.deduplicated.bam`
    echo '#unique sites:' `samtools view outdata/$barcode.deduplicated.bam | cut -f3,4 | LC_ALL=C sort -u | wc -l`
    echo '#################################'
done
cd $oldir
