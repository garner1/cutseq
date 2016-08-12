#!/usr/bin/env bash

# THIS SCRIPT CAN BE CALLED AS
# ./main.sh xz10 hg19 5
################################################################################

# clear
# DEFINING VARIABLES
experiment=$1			# xz13-14-15-10PE
genome=$2			# hg19
quality=$3	     # at least 3 to get rid of secondary alignments in repeats
resolution=$4	     # 10000000
mode=$5		     # PE or SE
barcode_file=$6	     # ~/Work/pipelines/restseq/pattern/barcode-cutsite_18
cutsite=$7	     # the restriction cutsite
umi_missmatch=$8     # threshold on the UMI mismatch for filtering
r1=$9				# ~/Work/dataset/XZ14_ACAGTG_L001_R1_001.fastq.gz
r2=$10				# ~/Work/dataset/XZ14_ACAGTG_L001_R2_001.fastq.gz

numbproc=32

################################################################################

# PREPARE DIRECTORY STRUCTURE
datadir=$HOME/Work/dataset/restseq && mkdir -p $datadir/$experiment
in="$datadir"/"$experiment"/indata && mkdir -p $in
out="$datadir"/"$experiment"/outdata && mkdir -p $out
aux="$datadir"/"$experiment"/auxdata && mkdir -p $aux
refgen=$HOME/igv/genomes/$genome.fasta

echo
echo Processing $experiment
################################################################################

# ~/Work/pipelines/restseq/bin/module/quality_control.sh $r1 $numbproc $out

################################################################################

# USE EITHER prepare_files.sh OR parallel_scan.sh

# ~/Work/pipelines/restseq/bin/module/prepare_files.sh $in $mode $r1 $r2 

# ~/Work/pipelines/restseq/bin/module/parallel_scan.sh $in $mode $barcode_file $r1 $r2

################################################################################

# rm -fr "$out"/* "$aux"/*
i=0
for barcode in $( cat $barcode_file | awk '{print substr($1,1,8)}' )
do
    echo `expr $i + 1` $barcode
    i=`expr $i + 1`

    # if [ "$mode" == "PE" ]
    # then
    # 	bwa mem -v 1 -t $numbproc $refgen "$in"/barcode_"$barcode".fq "$in"/barcode_"$barcode"-r2.fq > "$out"/"$barcode".sam
    # fi
    # if [ "$mode" == "SE" ]
    # then
    # 	bwa mem -v 1 -t $numbproc $refgen "$in"/barcode_"$barcode".fq > "$out"/"$barcode".sam
    # fi

    # count=$(samtools view -F 256 -S -q $quality "$out"/"$barcode".sam | head -1 | wc -l)
    count=1
    if [ $count -ne 0 ]; then 
    	# samtools view -F 256 -Sb -q $quality "$out"/"$barcode".sam > "$out"/"$barcode".bam

    	$PWD/module/umi_joining.sh $out $aux $quality $barcode $in
    	$PWD/module/filter.centromere-telomere.sh $out $quality
    	$PWD/module/filter.blacklist.sh $out $quality
    
    	echo "Filter UMIs ..."
    	cat $out/chr-loc-umi_q"$quality" | cut -f-5 |LC_ALL=C uniq -c | awk '{print $2,$3,$4,$5,$6,$1}' | tr " " "," > $aux/aux
    	if [ -s $aux/aux ]; then # check if file is not empty
	    chr_list=$(cut -d',' -f1 $aux/aux|grep -v _|LC_ALL=C sort -u)
	    parallel "cat $aux/aux | LC_ALL=C grep -w {} | cut -d',' -f2 > $aux/{}_query.csv" ::: $(echo $chr_list)
	    parallel "cat ~/Work/pipelines/data/"$cutsite".bed | grep -w {} | cut -f2 > $aux/{}_RE.csv" ::: $(echo $chr_list)
	    parallel "python $PWD/module/find_closest.py $aux/{}_query.csv $aux/{}_RE.csv $aux/{}_newloc" ::: $(echo $chr_list)
	    parallel "cat $aux/aux|LC_ALL=C grep -w {}|paste -d',' - $aux/{}_newloc|tr ',' ' '|awk -v OFS=',' '{print \$1","\$NF","\$NF+1","\$4","\$5","\$6","\$2}' > $aux/{}_aux.csv" ::: $(echo $chr_list)

	    rm $aux/{*newloc,*query.csv,*RE.csv}

    	    parallel "python $PWD/module/umi_filtering.py $aux/{}_aux.csv $umi_missmatch {} {}_out.bed" ::: $(echo $chr_list)
    	    cat chr*_out.bed | tr -d "," | tr -d "'" | tr -d "[" | tr -d "]" | tr " " "\t" | grep -v "_" > $out/"$barcode"_chr-locNew-umi-pcr-locOld_q"$quality".bed
	    rm -f chr*_out.bed $aux/chr*_aux.csv $aux/aux
    	fi
    fi
done
# rm -f $out/chr-loc* $out/q*.bed

#################################################################

# ./module/change_name.sh "$experiment"

#################################################################

# echo "Create the data files for downstream analysis ..."
# ./module/create_data_matrix.sh "$experiment" "$resolution"

#################################################################
# count the reads per windos=10Mb
# to be parallelized over bedfiles
# ~/Work/pipelines/aux.scripts/coverage.sh $window $bedfile 

# ./module/GC-normalization.sh "$experiment"
