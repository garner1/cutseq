#!/bin/usr/env bash

inputfile=$1

while read -r line; do 
    f1=`echo $line|cut -d',' -f1`
    f2=`echo $line|cut -d',' -f2`
    touch "$f1"_"$f2"
    echo ^ 8...8 $f2[1,0,0] 1...1000 $ > barcode-cutsite_"$f1"
done < $inputfile
