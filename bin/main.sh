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
mm=1		 # number of mismatches allowd in scan_for_matches
quality=60	     # filter out read with mapping quality less than this
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
###########################################################################
bash ./module/parallel_scan.sh $cutsite $indir $mode $barcode_file $mm $r1 $r2 
i=0
for barcode in $( cat $barcode_file | awk '{print substr($1,1,8)}' ) # !!!!KEEP ALL BARCODES!!!!
do
    echo `expr $i + 1` $barcode
    i=`expr $i + 1`
    if [ ${mode} == "PE" ]
    then
    	bwa mem -v 1 -t $numbproc $refgen ${indir}/barcode_${barcode}.fq ${indir}/barcode_${barcode}-r2.fq | samtools sort -@ 8 -T ${aux}/${experiment} > ${out}/${barcode}.all.bam
    fi
    if [ ${mode} == "SE" ]
    then
    	bwa mem -v 1 -t $numbproc $refgen ${indir}/barcode_${barcode}.fq | samtools sort -@ 8 -T ${aux}/${experiment} > ${out}/${barcode}.all.bam
    fi
    samtools index -@ 8 ${out}/${barcode}.all.bam
    count=$(samtools view ${out}/${barcode}.all.bam | head | wc -l)
    if [ $count -eq 10 ]; then 
    	if [ ${mode} == "SE" ];	then
    	    /usr/local/share/anaconda3/bin/alfred qc -r /home/garner1/Work/genomes/Homo_sapiens.GRCh37.dna.primary_assembly.fa/GRCh37.fa \
					      -b /home/garner1/Work/dataset/agilent/S07604715_Covered.woChr.bed \
					      -j ${out}/${barcode}.all.json.gz ${out}/${barcode}.all.bam & pid0=$!
	    /usr/local/share/anaconda3/bin/umi_tools group \
						     -I ${out}/${barcode}.all.bam --group-out=${out}/${barcode}.q${quality}.grouped.tsv \
						     --log=${out}/${barcode}.grouped.log --mapping-quality=${quality} & pid1=$!
    	    /usr/local/share/anaconda3/bin/umi_tools dedup \
						     -I ${out}/${barcode}.all.bam -S ${out}/${barcode}.deduplicated.bam -L ${out}/${barcode}.group.log --mapping-quality=${quality} & pid2=$!
    	fi
    	if [ ${mode} == "PE" ];	then
    	    /usr/local/share/anaconda3/bin/alfred qc -r /home/garner1/Work/genomes/Homo_sapiens.GRCh37.dna.primary_assembly.fa/GRCh37.fa \
					      -b /home/garner1/Work/dataset/agilent/S07604715_Covered.woChr.bed \
					      -j ${out}/${barcode}.all.json.gz ${out}/${barcode}.all.bam & pid0=$!
	    /usr/local/share/anaconda3/bin/umi_tools group \
						     -I ${out}/${barcode}.all.bam --paired --group-out=${out}/${barcode}.q${quality}.grouped.tsv \
						     --log=${out}/${barcode}.grouped.log --mapping-quality=${quality} & pid1=$!
    	    /usr/local/share/anaconda3/bin/umi_tools dedup \
						     -I ${out}/${barcode}.all.bam --paired -S ${out}/${barcode}.deduplicated.bam -L ${out}/${barcode}.group.log --mapping-quality=${quality} & pid2=$!
    	fi
	wait $pid2; samtools sort -@ 8 ${out}/${barcode}.deduplicated.bam -o ${out}/${barcode}.deduplicated.q${quality}.bam && rm -f ${out}/${barcode}.deduplicated.bam
    	/usr/local/share/anaconda3/bin/alfred qc -r /home/garner1/Work/genomes/Homo_sapiens.GRCh37.dna.primary_assembly.fa/GRCh37.fa \
					      -b /home/garner1/Work/dataset/agilent/S07604715_Covered.woChr.bed \
					      -j ${out}/${barcode}.deduplicated.q${quality}.json.gz ${out}/${barcode}.deduplicated.q${quality}.bam 
	wait $pid1; gzip ${out}/${barcode}.q${quality}.grouped.tsv 
	rm -f processed.log
    fi
done
git add -A && git commit -m "$(echo Done with processing ${experiment})" && git push origin development
