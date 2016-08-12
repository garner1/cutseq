#!/usr/bin/env bash

clear
# DEFINING VARIABLES
experiment=$1			# e.i. xz9
genome=$2			# e.i. geneblock
patfile=$3			# is the pattern file
quality=$4			# mapping quality
cutsite=$5			# AAGCT
numbproc=32
################################################################################
# PREPARE DIRECTORY STRUCTURE
datadir=$HOME/Work/dataset && mkdir -p $datadir/$experiment
in=$HOME/Work/dataset/$experiment/indata && mkdir -p $in
out=$HOME/Work/dataset/$experiment/outdata && mkdir -p $out
outcontrol=$HOME/Work/dataset/$experiment/outdata.control && mkdir -p $outcontrol
aux=$HOME/Work/dataset/$experiment/auxdata && mkdir -p $aux
auxcontrol=$HOME/Work/dataset/$experiment/auxdata.control && mkdir -p $auxcontrol
refgen=$HOME/Work/pipelines/xz9/data/refgen/$genome.fasta
################################################################################
# LOAD DATA FILES
find $datadir -maxdepth 1 -type f -iname "*$experiment*" | sort > filelist
numb_of_files=`cat filelist | wc -l`
r1=`cat filelist | head -n1`
echo "R1 is " $r1
if [ $numb_of_files == 2 ]; then
    r2=`cat filelist | tail -n1`
    echo "R2 is " $r2
fi
rm filelist
################################################################################
#~/Work/pipelines/bliss/repo_bliss/bin/module/quality_control.sh $numb_of_files $numbproc $out $r1 $r2

~/Work/pipelines/bliss/repo_bliss/bin/module/prepare_files.sh $r1 $in $numb_of_files $r2

~/Work/pipelines/bliss/repo_bliss/bin/module/pattern_filtering.sh $in $outcontrol $out $patfile $cutsite

~/Work/pipelines/bliss/repo_bliss/bin/module/prepare_for_mapping.sh $numb_of_files $out $aux $outcontrol $auxcontrol $in $cutsite

~/Work/pipelines/bliss/repo_bliss/bin/module/mapping.sh $numb_of_files $numbproc $refgen $aux $out $experiment $auxcontrol $outcontrol $cutsite
######################################################################################################
samtools view -Sb -q $quality $out/$experiment.sam > $out/$experiment-q$quality.bam & pid1=$!
samtools view -Sb -q $quality $outcontrol/$experiment.sam > $outcontrol/$experiment-q$quality.bam & pid2=$!
wait $pid1
wait $pid2
samtools sort $out/$experiment-q$quality.bam $out/$experiment-q$quality.sorted & pid1=$!
samtools sort $outcontrol/$experiment-q$quality.bam $outcontrol/$experiment-q$quality.sorted & pid2=$!
wait $pid1
wait $pid2
samtools index $out/$experiment-q$quality.sorted.bam & pid1=$!
samtools index $outcontrol/$experiment-q$quality.sorted.bam & pid2=$!
wait $pid1
wait $pid2
######################################################################################################
samtools view -f 66 $out/xz9.sam | cut -f1,4 | LC_ALL=C sort --parallel=8 --temporary-directory=$HOME/tmp -k1,1 > $out/mapped-r1.txt & pid1=$!
samtools view -f 130 $out/xz9.sam | cut -f1,4 | LC_ALL=C sort --parallel=8 --temporary-directory=$HOME/tmp -k1,1 > $out/mapped-r2.txt & pid2=$! 
samtools view -f 66 $outcontrol/xz9.sam | cut -f1,4 | LC_ALL=C sort --parallel=8 --temporary-directory=$HOME/tmp -k1,1 > $outcontrol/mapped-r1.txt & pid3=$!
samtools view -f 130 $outcontrol/xz9.sam | cut -f1,4 | LC_ALL=C sort --parallel=8 --temporary-directory=$HOME/tmp -k1,1 > $outcontrol/mapped-r2.txt & pid4=$! 
wait $pid1
wait $pid2
wait $pid3
wait $pid4

LC_ALL=C join $out/mapped-r1.txt $out/mapped-r2.txt > $out/join-r1-r2.txt & pid1=$!
LC_ALL=C join $outcontrol/mapped-r1.txt $outcontrol/mapped-r2.txt > $outcontrol/join-r1-r2.txt & pid2=$!
wait $pid1
wait $pid2

cat $out/join-r1-r2.txt | awk '{print $1,($3-$2)}' > $out/id-gap.txt & pid1=$!
cat $outcontrol/join-r1-r2.txt | awk '{print $1,($3-$2)}' > $outcontrol/id-gap.txt & pid2=$!
wait $pid1
wait $pid2

cat $out/id-gap.txt | cut -d' ' -f2 | sort -n | uniq -c | awk '{print $2,$1}' > $out/count-gap & pid1=$!
cat $out/mapped-r1.txt | cut -f2 | sort -n | uniq -c | awk '{print $2,$1}' > $out/count-r1 & pid2=$!
cat $out/mapped-r2.txt | cut -f2 | sort -n | uniq -c | awk '{print $2,$1}' > $out/count-r2 & pid3=$!
cat $outcontrol/id-gap.txt | cut -d' ' -f2 | sort -n | uniq -c | awk '{print $2,$1}' > $outcontrol/count-gap & pid4=$!
cat $outcontrol/mapped-r1.txt | cut -f2 | sort -n | uniq -c | awk '{print $2,$1}' > $outcontrol/count-r1 & pid5=$!
cat $outcontrol/mapped-r2.txt | cut -f2 | sort -n | uniq -c | awk '{print $2,$1}' > $outcontrol/count-r2 & pid6=$!
wait $pid1
wait $pid2
wait $pid3
wait $pid4
wait $pid5
wait $pid6
######################################################################################################
cat $in/r1oneline.fq | grep -v "GTCGTATCGTCGTTCC" | tr " " "\n" | grep -v "1:N:0" | LC_ALL=C sort > $aux/id
LC_ALL=C join $in/r1oneline.fq $aux/id | tr " " "\n" | grep -v "1:N:0:" > $aux/r1-wo-prefix.fq & pid1=$!
LC_ALL=C join $in/r2oneline.fq $aux/id | tr " " "\n" | grep -v "2:N:0:"> $aux/r2-wo-prefix.fq & pid2=$!
wait $pid1
wait $pid2
bwa mem -t $numbproc $refgen $aux/r1-wo-prefix.fq $aux/r2-wo-prefix.fq > $out/$experiment-wo-prefix.sam
samtools view -Sb -q $quality $out/$experiment-wo-prefix.sam > $out/$experiment-wo-prefix-q$quality.bam
samtools sort $out/$experiment-wo-prefix-q$quality.bam $out/$experiment-wo-prefix-q$quality.sorted
samtools index $out/$experiment-wo-prefix-q$quality.sorted.bam
######################################################################################################
