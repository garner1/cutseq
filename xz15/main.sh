#!/usr/bin/env bash

# THIS SCRIPT CAN BE CALLED AS
# ./main.sh xz10 
################################################################################
clear
# DEFINING VARIABLES
experiment=$1			# e.i. rm11
patfile=$2			# is the pattern file
numbproc=32
################################################################################
# PREPARE DIRECTORY STRUCTURE
datadir=$HOME/Work/dataset && mkdir -p $datadir/$experiment
in=$HOME/Work/dataset/$experiment/indata && mkdir -p $in
out=$HOME/Work/dataset/$experiment/outdata && mkdir -p $out
outcontrol=$HOME/Work/dataset/$experiment/outdata.control && mkdir -p $outcontrol
aux=$HOME/Work/dataset/$experiment/auxdata && mkdir -p $aux
auxcontrol=$HOME/Work/dataset/$experiment/auxdata.control && mkdir -p $auxcontrol
refgen=$HOME/igv/genomes/$genome.fasta
################################################################################
# # LOAD DATA FILES
# find $datadir -maxdepth 1 -type f -iname "*$experiment*" | sort > filelist
# numb_of_files=`cat filelist | wc -l`
# r1=`cat filelist | head -n1`
# echo "R1 is " $r1
# if [ $numb_of_files == 2 ]; then
#     r2=`cat filelist | tail -n1`
#     echo "R2 is " $r2
# fi
# rm filelist
################################################################################
# ~/Work/pipelines/bliss/repo_bliss/bin/module/quality_control.sh $numb_of_files $numbproc $out $r1 $r2

# ~/Work/pipelines/bliss/repo_bliss/bin/module/prepare_files.sh  $r1 $in $numb_of_files $r2

cat $patfile | awk '{print "^ 8...8",$1,"A","1...1000 $"}' > "$patfile"2
name=`cat $patfile`
mkdir -p $out/"$name"
~/Work/pipelines/bliss/repo_bliss/bin/module/pattern_filtering.sh $in $outcontrol "$out"/$name "$patfile"2 $cutsite
cat $out/"$name"/filtered.r1.fa | paste - - | wc -l > ~/Work/pipelines/restseq/"$experiment"/output/"$name"
