#!/usr/bin/env bash

dsb=$1			# this is the full path to the DSB data bed file *UMI_count*
resolution=$2			# resolution of the binned genome

#create bed files representing the binned genome
~/SparkleShare/aux.scripts/make-windows.sh $resolution hg19 > "$dsb"__A.bed

#############################################################
#count the number of molecules in each bin
bedtools intersect -a "$dsb"__A.bed -b "$dsb" -c | head

