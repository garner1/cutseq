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
datadir=$HOME/Work/dataset/reduced_sequencing && mkdir -p $datadir/$experiment 
in=$datadir/$experiment/indata && mkdir -p $in
out=$datadir/$experiment/outdata && mkdir -p $out
aux=$datadir/$experiment/auxdata && mkdir -p $aux
refgen=~/Work/genomes/Homo_sapiens.GRCh37.dna.primary_assembly.fa/GRCh37.fa # full path to reference genome

echo
echo Processing $experiment

################################################################################
# bash ./module/quality_control.sh $r1 $numbproc $out
################################################################################

bash ./module/parallel_scan.sh $cutsite $in $mode $barcode_file $r1 $r2 
