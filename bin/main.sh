#!/usr/bin/env bash

################################################################################
# clear
# DEFINING VARIABLES
experiment=$1	     # XZ82
genome=$2	     # hg19
mode=$3		     # PE or SE
barcode_file=$4	     # ~/Work/pipelines/restseq/pattern/barcode-cutsite_18
cutsite=$5	     # the restriction cutsite
umi_missmatch=$6     # threshold on the UMI mismatch for filtering
r1=$7		     # full path to r1 fastq.gz file
r2=$8	             # full path to r2 fastq.gz file
numbproc=32
quality=30	     # filter out read with mapping quality less than this
################################################################################

# PREPARE DIRECTORY STRUCTURE
datadir=$HOME/Work/dataset/reduced_sequencing && mkdir -p $datadir/$experiment 
in="$datadir"/"$experiment"/indata && mkdir -p $in
out="$datadir"/"$experiment"/outdata && mkdir -p $out
aux="$datadir"/"$experiment"/auxdata && mkdir -p $aux
refgen=$HOME/igv/genomes/$genome.fasta # full path to reference genome

echo
echo Processing $experiment
################################################################################

bash ./module/quality_control.sh $r1 $numbproc $out

################################################################################

bash ./module/parallel_scan.sh $cutsite $in $mode $barcode_file $r1 $r2 

rm -fr "$out"/* "$aux"/* 	# !!!clean outdata and auxdata directories!!!!

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
	if [ "$mode" == "SE" ]
	then
	    samtools view -h -Sb -q $quality "$aux"/"$barcode".sam > "$aux"/"$barcode".bam # only keep first mate in pair and filter wrt quality
	    samtools sort "$aux"/"$barcode".bam -o "$aux"/"$barcode".sorted.bam
	    samtools index "$aux"/"$barcode".sorted.bam
	fi

	umi_tools dedup -I "$aux"/"$barcode".sorted.bam -S "$aux"/deduplicated.bam --edit-distance-threshold 2 -L "$aux"/group.log # first dedup of reads not at cutsite

    	echo "Filter UMIs ..."
	bedtools bamtobed -i "$aux"/deduplicated.bam | sort --parallel=8 --temporary-directory=$HOME/tmp -k1,1 -k2,2n > "$aux"/myfile_"$barcode" # convert bam2bed sorted wrt to chr and start
	if [ -s "$aux"/myfile_"$barcode" ]; then # check if file is not empty
	    bedtools closest -a "$aux"/myfile_"$barcode" -b ~/Work/pipelines/data/"$cutsite".bed -d | # find the closest cutsite
	    awk '$10==0' |  awk '{if (($6=="-" && $9-$3==0) || ($6=="+" && $8-$2==1)) print}' > $aux/loc-tag-qscore-strand-cutsite-dist.bed # group reads at cutsites and filter only those s.t. the cutsite is included inside the mapped region
	    mv $aux/loc-tag-qscore-strand-cutsite-dist.bed $aux/oldloc-tag-qscore-strand-cutsite-dist.bed
	    cat $aux/oldloc-tag-qscore-strand-cutsite-dist.bed | awk '{OFS="\t";$2=$8;$3=$9;print $0 }' > $aux/loc-tag-qscore-strand-cutsite-dist.bed

	    bedtools bedtobam -i $aux/loc-tag-qscore-strand-cutsite-dist.bed -g $HOME/igv/genomes/$genome.bedtools.genome > $aux/temporary.bam # create bam file from bed at cutsites
	    samtools sort "$aux"/temporary.bam -o "$aux"/temporary.bam
	    samtools index "$aux"/temporary.bam # index bam file

	    umi_tools dedup -I "$aux"/temporary.bam -S "$out"/"$barcode".deduplicated.bam --edit-distance-threshold 2 -L "$out"/group.log # deduplicate the bam file with reads grouped at cutsites
	    samtools view "$out"/"$barcode".deduplicated.bam | cut -f1 | LC_ALL=C sort -u > $aux/tag2keep # list of tags of reads to keep
	    LC_ALL=C sort -k4,4 -o $aux/loc-tag-qscore-strand-cutsite-dist.bed $aux/loc-tag-qscore-strand-cutsite-dist.bed # sort WRT tags
	    LC_ALL=C join -1 1 -2 4 $aux/tag2keep $aux/loc-tag-qscore-strand-cutsite-dist.bed | tr ' ' '\t' | cut -f-6 | LC_ALL=C sort -u > $out/tag-loc-qscore-strand__"$barcode".bed 
	    # IN THE LAST FILE THE SAME TAG COULD HAVE DIFFERENT LOCATIONS BECAUSE THE ALIGNMENT IS NOT UNIQUE
    	fi
    fi
done

rm barcode_*

# rm -fr "$in"/barcode_* "$out"/*.{sam,bam} "$aux"/* 	# !!!clean outdata and auxdata directories!!!!

# samfile="$out"/"$barcode".sam
# uniqueReads="$out"/read_strand_UMI_PCRcount__"$barcode".bed
# uniqueLocations="$out"/read_strand_CELLcount__"$barcode".bed
# bash ./module/make_summary.sh $datadir $experiment $barcode $samfile $uniqueReads $uniqueLocations 
 
