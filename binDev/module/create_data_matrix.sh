#!/usr/bin/env bash

exp=$1
out=~/Work/dataset/restseq/"$exp"/outdata
aux=~/Work/dataset/restseq/"$exp"/auxdata
resolution=$2

mkdir -p "$out"/"$resolution"
chr1len=`cat ~/Work/pipelines/data/hg19-chr-sizes.txt | grep -Fw "chr1" | cut -f2`
offset=0
for chr in $( cat ~/Work/pipelines/data/hg19-chr-sizes.txt|grep -v "chrX\|chrY\|_\|M"|sort -nk1.4|cut -f1|head -24 )
do
    # Create a list of all possible position (in all regions) for the given chromosome
    cat $out/*.bed|sed 's/chrX/chr23/g'|sed 's/chrY/chr24/g'|LC_ALL=C grep -Fw "$chr"|cut -f2|LC_ALL=C sort -u > "$aux"/col

    for region in $( ls "$out"/*.bed ) 
    do
    	name=`echo $region | cut -d'/' -f9|cut -d'.' -f1`

    	cat $region | sed 's/chrX/chr23/g'|sed 's/chrY/chr24/g'| 
    	LC_ALL=C grep -Fw "$chr" | cut -f2 | sort | join - "$aux"/col | sort -n | uniq -c | 
    	awk -v res="$resolution" -v offset="$offset" '{OFS="\t"; print int($2/res)+offset,$1}' |
    	datamash -g 1 sum 2 | 
    	awk -v chr="$chr" '{print chr,"\t",$0}' \
    	    > "$out"/"$resolution"/"$chr"_"$name".dat # group wrt first field and sum the II fields
    done

    chrlen=`cat ~/Work/pipelines/data/hg19-chr-sizes.txt | grep -Fw "$chr" | cut -f2`
    new=$(awk -v res="$resolution" -v chrlen="$chrlen" 'BEGIN { print int(chrlen/res) }')
    offset=$(awk -v new="$new" -v offset="$offset" 'BEGIN { print offset+new }')
done

mkdir -p ~/Work/dataset/restseq/data/xz_10PE/"$resolution"
mkdir -p ~/Work/dataset/restseq/data/xz_10SE/"$resolution"
mkdir -p ~/Work/dataset/restseq/data/xz_15/"$resolution"
mkdir -p ~/Work/dataset/restseq/data/xz_10_15/"$resolution"
mkdir -p ~/Work/dataset/restseq/data/xz_13/"$resolution"
mkdir -p ~/Work/dataset/restseq/data/xz_14/"$resolution"
mkdir -p ~/Work/dataset/restseq/data/xz_13_14/"$resolution"
mkdir -p ~/Work/dataset/restseq/data/xz_18/"$resolution"
mkdir -p ~/Work/dataset/restseq/data/xz_19/"$resolution"
mkdir -p ~/Work/dataset/restseq/data/xz_20/"$resolution"
mkdir -p ~/Work/dataset/restseq/data/xz_21/"$resolution"
mkdir -p ~/Work/dataset/restseq/data/xz_22/"$resolution"
mkdir -p ~/Work/dataset/restseq/data/xz_23/"$resolution"
mkdir -p ~/Work/dataset/restseq/data/xz_24/"$resolution"
mkdir -p ~/Work/dataset/restseq/data/xz_23_24/"$resolution"

if [ "$exp" == xz10PE ]; then
   rm -f ~/Work/dataset/restseq/data/xz_10PE/"$resolution"/*
fi
if [ "$exp" == xz10SE ]; then
   rm -f ~/Work/dataset/restseq/data/xz_10SE/"$resolution"/*
fi
if [ "$exp" == xz13 ]; then
    rm -f ~/Work/dataset/restseq/data/xz_13/"$resolution"/*
fi
if [ "$exp" == xz14 ]; then
   rm -f ~/Work/dataset/restseq/data/xz_14/"$resolution"/*
fi
if [ "$exp" == xz15 ]; then
   rm -f ~/Work/dataset/restseq/data/xz_15/"$resolution"/*
fi
if [ "$exp" == xz18 ]; then
    rm -f ~/Work/dataset/restseq/data/xz_18/"$resolution"/*
fi
if [ "$exp" == xz19 ]; then
   rm -f ~/Work/dataset/restseq/data/xz_19/"$resolution"/*
fi
if [ "$exp" == xz20 ]; then
   rm -f ~/Work/dataset/restseq/data/xz_20/"$resolution"/*
fi
if [ "$exp" == xz21 ]; then
    rm -f ~/Work/dataset/restseq/data/xz_21/"$resolution"/*
fi
if [ "$exp" == xz22 ]; then
   rm -f ~/Work/dataset/restseq/data/xz_22/"$resolution"/*
fi
if [ "$exp" == xz23 ]; then
    rm -f ~/Work/dataset/restseq/data/xz_23/"$resolution"/*
fi
if [ "$exp" == xz24 ]; then
   rm -f ~/Work/dataset/restseq/data/xz_24/"$resolution"/*
fi
if [ "$exp" == xz23_24 ]; then
   rm -f ~/Work/dataset/restseq/data/xz_23_24/"$resolution"/*
fi

if [ "$exp" == xz23_24 ]; then
    for region in $(ls "$out"/"$resolution"/chr* |cut -d'_' -f3-|sort -u)
    do
	cat "$out"/"$resolution"/chr*_$region | LC_ALL=C sort -n -k1.4 -k2,2 > ~/Work/dataset/restseq/data/xz_23_24/"$resolution"/$region
    done
fi

for region in $(ls "$out"/"$resolution"/chr* |cut -d'_' -f2-|sort -u)
do
    if [ "$exp" == xz10PE ] 
    then
	cat "$out"/"$resolution"/chr*_$region | LC_ALL=C sort -n -k1.4 -k2,2 > ~/Work/dataset/restseq/data/xz_10PE/"$resolution"/$region
	cat "$out"/"$resolution"/chr*_$region | LC_ALL=C sort -n -k1.4 -k2,2 > ~/Work/dataset/restseq/data/xz_10_15/"$resolution"/$region
    fi
    if [ "$exp" == xz10SE ] 
    then
	cat "$out"/"$resolution"/chr*_$region | LC_ALL=C sort -n -k1.4 -k2,2 > ~/Work/dataset/restseq/data/xz_10SE/"$resolution"/$region
	cat "$out"/"$resolution"/chr*_$region | LC_ALL=C sort -n -k1.4 -k2,2 > ~/Work/dataset/restseq/data/xz_10_15/"$resolution"/$region
    fi
    if [ "$exp" == xz13 ] 
    then
	cat "$out"/"$resolution"/chr*_$region | LC_ALL=C sort -n -k1.4 -k2,2 > ~/Work/dataset/restseq/data/xz_13/"$resolution"/$region
	cat "$out"/"$resolution"/chr*_$region | LC_ALL=C sort -n -k1.4 -k2,2 > ~/Work/dataset/restseq/data/xz_13_14/"$resolution"/"$exp"_"$region"
    fi
    if [ "$exp" == xz14 ] 
    then
	cat "$out"/"$resolution"/chr*_$region | LC_ALL=C sort -n -k1.4 -k2,2 > ~/Work/dataset/restseq/data/xz_14/"$resolution"/$region
	cat "$out"/"$resolution"/chr*_$region | LC_ALL=C sort -n -k1.4 -k2,2 > ~/Work/dataset/restseq/data/xz_13_14/"$resolution"/"$exp"_"$region"
    fi
    if [ "$exp" == xz15 ] 
    then
	cat "$out"/"$resolution"/chr*_$region | LC_ALL=C sort -n -k1.4 -k2,2 > ~/Work/dataset/restseq/data/xz_15/"$resolution"/$region
	cat "$out"/"$resolution"/chr*_$region | LC_ALL=C sort -n -k1.4 -k2,2 > ~/Work/dataset/restseq/data/xz_10_15/"$resolution"/$region
    fi
    if [ "$exp" == xz18 ] 
    then
	cat "$out"/"$resolution"/chr*_$region | LC_ALL=C sort -n -k1.4 -k2,2 > ~/Work/dataset/restseq/data/xz_18/"$resolution"/$region
    fi
    if [ "$exp" == xz19 ] 
    then
	cat "$out"/"$resolution"/chr*_$region | LC_ALL=C sort -n -k1.4 -k2,2 > ~/Work/dataset/restseq/data/xz_19/"$resolution"/$region
    fi
    if [ "$exp" == xz20 ] 
    then
	cat "$out"/"$resolution"/chr*_$region | LC_ALL=C sort -n -k1.4 -k2,2 > ~/Work/dataset/restseq/data/xz_20/"$resolution"/$region
    fi
    if [ "$exp" == xz21 ] 
    then
	cat "$out"/"$resolution"/chr*_$region | LC_ALL=C sort -n -k1.4 -k2,2 > ~/Work/dataset/restseq/data/xz_21/"$resolution"/$region
    fi
    if [ "$exp" == xz22 ] 
    then
	cat "$out"/"$resolution"/chr*_$region | LC_ALL=C sort -n -k1.4 -k2,2 > ~/Work/dataset/restseq/data/xz_22/"$resolution"/$region
    fi
    if [ "$exp" == xz23 ] 
    then
	cat "$out"/"$resolution"/chr*_$region | LC_ALL=C sort -n -k1.4 -k2,2 > ~/Work/dataset/restseq/data/xz_23/"$resolution"/$region
    fi
    if [ "$exp" == xz24 ] 
    then
	cat "$out"/"$resolution"/chr*_$region | LC_ALL=C sort -n -k1.4 -k2,2 > ~/Work/dataset/restseq/data/xz_24/"$resolution"/$region
    fi
done
