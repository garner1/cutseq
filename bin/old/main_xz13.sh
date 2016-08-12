#!/usr/bin/env bash

# THIS SCRIPT CAN BE CALLED AS
# ./main.sh xz10 hg19 5
################################################################################

# clear
# DEFINING VARIABLES
experiment=$1			# e.i. rm11
genome=$2
quality=$3
resolution=$4
mode=$5
numbproc=32

################################################################################

# PREPARE DIRECTORY STRUCTURE
datadir=$HOME/Work/dataset/restseq && mkdir -p $datadir/$experiment
in="$datadir"/"$experiment"/indata && mkdir -p $in
out="$datadir"/"$experiment"/outdata && mkdir -p $out
aux="$datadir"/"$experiment"/auxdata && mkdir -p $aux
refgen=$HOME/igv/genomes/$genome.fasta

################################################################################

r1=~/Work/dataset/XZ13_TTAGGC_L001_R1_001.fastq.gz
r2=~/Work/dataset/XZ13_TTAGGC_L001_R1_001.fastq.gz

################################################################################

# ~/Work/pipelines/restseq/bin/module/quality_control.sh $r1 $numbproc $out
# ~/Work/pipelines/restseq/bin/module/prepare_files.sh $in $r1 $r2

################################################################################

i=0
for barcode in $( cat ~/Work/pipelines/restseq/pattern/barcode-cutsite )
do
    echo `expr $i + 1`
    i=`expr $i + 1`

    # Use this if PE reads
    if [ "$mode" == "PE" ]
    then
	# echo $mode
	$PWD/module/iterate_mapping.sh $numbproc $refgen $in $out $barcode $aux
	# bwa mem -t $numbproc $refgen "$in"/"$barcode".fq "$in"/"$barcode"-r2.fq > "$out"/"$barcode".sam
    fi

    # Use this if SE reads
    if [ "$mode"=="SE" ]
    then
    	# echo $mode
    	bwa mem -t $numbproc $refgen "$in"/"$barcode".fq > "$out"/"$barcode".sam
    fi

    samtools view -Sb -q $quality "$out"/"$barcode".sam > $out/q$quality.bam

    $PWD/module/umi_joining.sh $out $aux $quality $barcode $in
    $PWD/module/filter.centromere-telomere.sh $out $quality
    $PWD/module/filter.blacklist.sh $out $quality
    
    # Filter UMIs
    cat "$datadir"/"$experiment"/outdata/chr-loc-strand-umi_q"$quality" | cut -f-5 | uniq -c | awk '{print $2,$3,$4,$5,$6,$1}' | tr " " "," > "$datadir"/"$experiment"/auxdata/aux
    python $PWD/module/umi_filtering.py "$datadir"/"$experiment"/auxdata/aux "$datadir"/"$experiment"/outdata/q"$quality"_aux
    cat "$datadir"/"$experiment"/outdata/q"$quality"_aux | tr -d "," | tr -d "'" | tr -d "[" | tr -d "]" | tr " " "\t" | grep -v "_" > "$datadir"/"$experiment"/outdata/"$barcode"_chr-loc-strand-umi-pcr_q"$quality".bed
done

rm $out/chr-loc* $out/*_aux $out/q*.bed $out/*.bam

#################################################################

./module/change_name.sh "$experiment"
./module/create_data_matrix.sh "$experiment" "$resolution"
