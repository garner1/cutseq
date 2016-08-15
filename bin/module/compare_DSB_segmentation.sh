#!/usr/bin/env bash

dsb1=$1			# this is the full path to the DSB data bed file *UMI_count*
dsb2=$2			# this is the full path to the DSB data bed file *UMI_count*
quality=$3		# filter out low quality reads
resolution=$4		# resolution of the binned genome

#create bed files representing the binned genome
~/SparkleShare/aux.scripts/make-windows.sh "$resolution" hg19 > "$dsb"__A.bed

#############################################################
#count the number of molecules in each bin
bedtools intersect -wa -a "$dsb"__A.bed -b $dsb1 $dsb2 -c | grep -v "chrM" | head

# > "$dsb"__raw_segmented_q"$quality"_res"$resolution".bed 

# norma=$(cat "$dsb"__raw_segmented_q"$quality"_res"$resolution".bed | datamash sum 4)
# cat "$dsb"__raw_segmented_q"$quality"_res"$resolution".bed | 
# awk -v norma="$norma" '{FS=OFS="\t"; print $1,$2,$3,$4/norma}' > "$dsb"__normed_segmented_q"$quality"_res"$resolution".bed

# echo $norma
# rm -f "$dsb"__raw_segmented_q"$quality"_res"$resolution".bed

# #!/usr/bin/env bash

# dsb1=$1			# this is the full path to the DSB data bed file *UMI_count*
# dsb2=$2			# this is the full path to the DSB data bed file *UMI_count*
# quality=$3		# filter out low quality reads
# resolution=$4		# resolution of the binned genome

# /home/garner1/SparkleShare/RESTSEQ/bin/module/DSB_segmentation.sh $dsb1 $quality $resolution & pid1=$!
# /home/garner1/SparkleShare/RESTSEQ/bin/module/DSB_segmentation.sh $dsb2 $quality $resolution & pid2=$!
# wait $pid1
# wait $pid2

# # "$dsb"__normed_segmented_q"$quality"_res"$resolution".bed




