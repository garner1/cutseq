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
numbproc=8
quality=30	     # filter out read with mapping quality less than this
################################################################################
# git add -A && git commit -m "$(echo Start processing $experiment)" && git push origin development
################################################################################
# PREPARE DIRECTORY STRUCTURE
datadir=$HOME/Work/dataset/cutseq && mkdir -p $datadir/$experiment 
indir=$datadir/$experiment/indata && mkdir -p $indir
out=$datadir/$experiment/outdata && mkdir -p $out
aux=$datadir/$experiment/auxdata && mkdir -p $aux
refgen=~/Work/genomes/Homo_sapiens.GRCh37.dna.primary_assembly.fa/GRCh37.fa # full path to reference genome
echo
echo Processing $experiment

# In parallel_scan.h you need to hard-code the edit distance from barcode
bash ./module/parallel_scan.sh $cutsite $indir $mode $barcode_file $r1 $r2 

i=0
for barcode in $( cat $barcode_file | awk '{print substr($1,1,8)}' ) # !!!!KEEP ALL BARCODES!!!!
do
    echo `expr $i + 1` $barcode
    i=`expr $i + 1`

    if [ ${mode} == "PE" ]
    then
    	bwa mem -v 1 -t $numbproc $refgen ${indir}/barcode_${barcode}.fq ${indir}/barcode_${barcode}-r2.fq | samtools sort -@ 8 -T ${aux}/${experiment} > ${aux}/${barcode}.all.bam
    fi
    
    if [ ${mode} == "SE" ]
    then
    	bwa mem -v 1 -t $numbproc $refgen ${indir}/barcode_${barcode}.fq | samtools sort -@ 8 -T ${aux}/${experiment} > ${aux}/${barcode}.all.bam
    fi

    count=$(samtools view -c ${aux}/${barcode}.all.bam)
    if [ $count -ne 0 ]; then 
    	samtools view -h -q $quality ${aux}/${barcode}.all.bam | samtools sort -@ 8 -T ${aux}/${barcode} > ${aux}/${barcode}.q${quality}.bam 
    	parallel "samtools index -@ 8 {}" ::: ${aux}/${barcode}.all.bam ${aux}/${barcode}.q${quality}.bam
    	# /usr/local/share/anaconda3/bin/alfred qc -r /home/garner1/Work/genomes/Homo_sapiens.GRCh37.dna.primary_assembly.fa/GRCh37.fa \
	# 				      -b /home/garner1/Work/dataset/agilent/S07604715_Covered.woChr.bed \
    	# 				      -j ${aux}/${barcode}.all.json.gz -o ${aux}/${barcode}.all.tsv.gz ${aux}/${barcode}.all.bam
    	# /usr/local/share/anaconda3/bin/alfred qc -r /home/garner1/Work/genomes/Homo_sapiens.GRCh37.dna.primary_assembly.fa/GRCh37.fa \
    	# 				      -b /home/garner1/Work/dataset/agilent/S07604715_Covered.woChr.bed \
	# 				      -j ${aux}/${barcode}.q${quality}.json.gz -o ${aux}/${barcode}.q${quality}.tsv.gz ${aux}/${barcode}.q${quality}.bam 
    	if [ ${mode} == "SE" ];	then
    	    /usr/local/share/anaconda3/bin/umi_tools dedup -I ${aux}/${barcode}.q${quality}.bam -S ${out}/${barcode}.deduplicated.bam --edit-distance-threshold 2 -L ${out}/${barcode}.group.log # first dedup of reads not at cutsite
    	fi
    	if [ ${mode} == "PE" ];	then
    	    /usr/local/share/anaconda3/bin/umi_tools dedup -I ${aux}/${barcode}.q${quality}.bam --paired -S ${out}/${barcode}.deduplicated.bam --edit-distance-threshold 2 -L ${out}/${barcode}.group.log 
    	fi
    	samtools sort -@ 8 ${out}/${barcode}.deduplicated.bam -o ${out}/${barcode}.deduplicated.q${quality}.bam && rm -f ${out}/${barcode}.deduplicated.bam
    	parallel "/usr/local/share/anaconda3/bin/alfred qc -r /home/garner1/Work/genomes/Homo_sapiens.GRCh37.dna.primary_assembly.fa/GRCh37.fa \
					      -b /home/garner1/Work/dataset/agilent/S07604715_Covered.woChr.bed \
					      -j {.}.json.gz -o {.}.tsv.gz {}" \
					      ::: ${out}/${barcode}.deduplicated.q${quality}.bam ${aux}/${barcode}.all.bam ${aux}/${barcode}.q${quality}.bam 
	rm -f processed.log
    	# echo "Conversion to bed file ..."
    	# bam2bed < ${out}/${barcode}.deduplicated.bam | cut -f-17 > ${out}/${barcode}.deduplicated.bed # convert using bedops bam2bed
    fi
done
git add -A && git commit -m "$(echo Done with processing ${experiment})" && git push origin development
