#!/usr/bin/env bash

exp=$1

for file in $( ls ~/Work/dataset/restseq/"$exp"/outdata/*.bed )
do
    barcode=`echo $file|cut -d'/' -f9|cut -c-8`
    newname=`grep -F "$barcode" ~/Work/pipelines/restseq/pattern/"$exp"_barcode-case.csv | cut -f2-|tr '\t' '_'`
    prefix=`echo $file|cut -d'/' -f-8`
    mv "$file" "$prefix"/"$newname".bed
done

for file in $( ls ~/Work/dataset/restseq/"$exp"/outdata/*.sam )
do
    barcode=`echo $file|cut -d'/' -f9|cut -c-8`
    newname=`grep -F "$barcode" ~/Work/pipelines/restseq/pattern/"$exp"_barcode-case.csv | cut -f2-|tr '\t' '_'`
    prefix=`echo $file|cut -d'/' -f-8`
    mv "$file" "$prefix"/"$newname".sam
done

for file in $( ls ~/Work/dataset/restseq/"$exp"/outdata/*.bam )
do
    barcode=`echo $file|cut -d'/' -f9|cut -c-8`
    newname=`grep -F "$barcode" ~/Work/pipelines/restseq/pattern/"$exp"_barcode-case.csv | cut -f2-|tr '\t' '_'`
    prefix=`echo $file|cut -d'/' -f-8`
    mv "$file" "$prefix"/"$newname".bam
done

