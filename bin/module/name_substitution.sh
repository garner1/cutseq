#!/usr/bin/env bash

file=$1
dic=$2

bc=`echo $file | tr '_.' '\t\t' | cut -f2`

sample=`grep $bc $dic | cut -f2`

cp $1 "$sample"_"$file"
