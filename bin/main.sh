#!/usr/bin/env bash

################################################################################
# clear
# DEFINING VARIABLES
experiment=$1	     # XZ82
genome=$2	     # human
mode=$3		     # PE or SE
barcode_file=$4	     # ~/Work/pipelines/restseq/pattern/barcode-cutsite_18
cutsite=$5	     # the restriction cutsite
r1=$6		     # full path to r1 fastq.gz file
r2=$7	             # full path to r2 fastq.gz file
numbproc=24
quality=30	     # filter out read with mapping quality less than this
################################################################################

# PREPARE DIRECTORY STRUCTURE
datadir=$HOME/Work/dataset/cutseq && mkdir -p $datadir/$experiment 
in=$datadir/$experiment/indata && mkdir -p $in
out=$datadir/$experiment/outdata && mkdir -p $out
aux=$datadir/$experiment/auxdata && mkdir -p $aux
refgen=~/Work/genomes/Homo_sapiens.GRCh37.dna.primary_assembly.fa/GRCh37.fa # full path to reference genome
# refgen=/home/garner1/Work/dataset/agilent/S07604715_Padded.woChr.fa

echo
echo Processing $experiment

################################################################################
# bash ./module/quality_control.sh $r1 $numbproc $out
################################################################################

bash ./module/parallel_scan.sh $cutsite $in $mode $barcode_file $r1 $r2 

i=0
for barcode in $( cat $barcode_file | awk '{print substr($1,1,8)}' ) # !!!!KEEP ALL BARCODES!!!!
do
    echo `expr $i + 1` $barcode
    i=`expr $i + 1`

    if [ "$mode" == "PE" ]
    then
    	bwa mem -v 1 -t $numbproc $refgen "$in"/barcode_"$barcode".fq "$in"/barcode_"$barcode"-r2.fq > "$aux"/"$barcode".sam
    fi
    
    if [ "$mode" == "SE" ]
    then
    	bwa mem -v 1 -t $numbproc $refgen "$in"/barcode_"$barcode".fq > "$aux"/"$barcode".sam
    fi

    count=$(samtools view -S "$aux"/"$barcode".sam | head -1 | wc -l)
    if [ $count -ne 0 ]; then 
    	if [ "$mode" == "SE" ];	then
    	    samtools view -h -Sb -q $quality "$aux"/"$barcode".sam > "$aux"/"$barcode".bam # only keep first mate in pair and filter wrt quality
    	    samtools sort "$aux"/"$barcode".bam -o "$aux"/"$barcode".sorted.bam
    	    samtools index "$aux"/"$barcode".sorted.bam
    	    umi_tools dedup -I "$aux"/"$barcode".sorted.bam -S "$out"/"$barcode".deduplicated.bam --edit-distance-threshold 2 -L "$out"/"$barcode".group.log # first dedup of reads not at cutsite
    	fi
    	if [ "$mode" == "PE" ];	then
    	    samtools view -h -Sb -q $quality "$aux"/"$barcode".sam > "$aux"/"$barcode".bam # only keep first mate in pair and filter wrt quality
    	    samtools sort "$aux"/"$barcode".bam -o "$aux"/"$barcode".sorted.bam
    	    samtools index "$aux"/"$barcode".sorted.bam
	    umi_tools dedup -I "$aux"/"$barcode".sorted.bam --paired -S "$out"/"$barcode".deduplicated.bam --edit-distance-threshold 2 -L "$out"/"$barcode".group.log 
    	fi
	samtools sort "$out"/"$barcode".deduplicated.bam -o "$out"/"$barcode".deduplicated.sorted.bam
    	# echo "Conversion to bed file ..."
    	# bam2bed < "$out"/"$barcode".deduplicated.bam | cut -f-17 > "$out"/"$barcode".deduplicated.bed # convert using bedops bam2bed
    fi
done
