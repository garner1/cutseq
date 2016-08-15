#!/usr/bin/env bash

run=$1				# run name, ex:AVO or BICRO
numb=$2				# number of the run, ex:19 
exp=$3				# experiment name, ex:XZ16

if [ $run = "AVO" ]; then
    count=$(find /media/bicroserver-seq/Hubrecht/"$run""$numb" -type f -name "*$exp*R1*.fastq.gz"|wc -l)
    if [ $count -gt 1 ]; then
	echo $count for $exp
	find /media/bicroserver-seq/Hubrecht/"$run""$numb" -type f -name "*$exp*R1*.fastq.gz" |
	xargs cat > $HOME/Work/dataset/restseq/"$exp"_R1.fastq.gz
    fi
    if [ $count -eq 1 ]; then
	echo $count for $exp
	find /media/bicroserver-seq/Hubrecht/"$run""$numb" -type f -name "*$exp*R1*.fastq.gz" -exec cp {} $HOME/Work/dataset/restseq/"$exp"_R1.fastq.gz \;
    fi
    count=$(find /media/bicroserver-seq/Hubrecht/"$run""$numb" -type f -name "*$exp*R2*.fastq.gz"|wc -l)
    if [ $count -gt 1 ]; then
	echo $count for $exp
	find /media/bicroserver-seq/Hubrecht/"$run""$numb" -type f -name "*$exp*R2*.fastq.gz" |
	xargs cat > $HOME/Work/dataset/restseq/"$exp"_R2.fastq.gz
    fi
    if [ $count -eq 1 ]; then
	echo $count for $exp
	find /media/bicroserver-seq/Hubrecht/"$run""$numb" -type f -name "*$exp*R2*.fastq.gz" -exec cp {} $HOME/Work/dataset/restseq/"$exp"_R2.fastq.gz \;
    fi
fi
if [ $run = "BICRO" ]; then
    count=$(find /media/bicroserver-seq/"$run""$numb" -type f -name "*$exp*R1*.fastq.gz"|wc -l)
    if [ $count -gt 1 ]; then
	echo $count for $exp
	find /media/bicroserver-seq/"$run""$numb" -type f -name "*$exp*R1*.fastq.gz" | 
	xargs cat > $HOME/Work/dataset/restseq/"$exp"_R1.fastq.gz
    fi
    if [ $count -eq 1 ]; then
	echo $count for $exp
	find /media/bicroserver-seq/"$run""$numb" -type f -name "*$exp*R1*.fastq.gz" -exec cp {} $HOME/Work/dataset/restseq/"$exp"_R1.fastq.gz \;
    fi
    count=$(find /media/bicroserver-seq/"$run""$numb" -type f -name "*$exp*R2*.fastq.gz"|wc -l)
    if [ $count -gt 1 ]; then
	echo $count for $exp
	find /media/bicroserver-seq/"$run""$numb" -type f -name "*$exp*R2*.fastq.gz" |
	xargs cat > $HOME/Work/dataset/restseq/"$exp"_R2.fastq.gz
    fi
    if [ $count -eq 1 ]; then
	echo $count for $exp
	find /media/bicroserver-seq/"$run""$numb" -type f -name "*$exp*R2*.fastq.gz" -exec cp {} $HOME/Work/dataset/restseq/"$exp"_R2.fastq.gz \;
    fi
fi

