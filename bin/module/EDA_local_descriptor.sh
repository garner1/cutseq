#!/usr/bin/env bash

mean=$1				# can be {all,xz13,xz14,xz19,xz20,xz21,xz22,xz23,xz24,xz1920,xz2122,xz2324}
local=$2			# this is the local dataset to be compared with the mean dataset
resolution=$3			# resolution of the binned genome
metric=$4			# can be {asym,norm_1,norm_2}
threshold=$5			# filter out regions with few reads

#create bed files representing the binned genome
~/Work/pipelines/aux.scripts/make-windows.sh $resolution hg19 > A.bed
#############################################################
# prepare the mean descriptor
if [ "$mean" == "xz30" ]; then
    cat ~/Work/dataset/restseq/xz30/outdata/*_*_*.bed | 
    LC_ALL=C sort -k1,1 -k2,2n | 
    LC_ALL=C uniq -c |
    awk -v OFS='\t' '{print $2,$3,$3+1,$1}' > ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed
    #count the number of molecules in each bin
    bedtools intersect -a A.bed -b ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed -c > ~/Work/dataset/restseq/binned_raw_MeanDescriptor.bed
    cat ~/Work/dataset/restseq/binned_raw_MeanDescriptor.bed | cut -f4 > ~/Work/dataset/restseq/p
fi
if [ "$mean" == "xz1314192021222324" ]; then
    cat ~/Work/dataset/restseq/xz{13,14,19,20,21,22,23,24}/outdata/?_?.bed | 
    LC_ALL=C sort -k1,1 -k2,2n | 
    LC_ALL=C uniq -c |
    awk -v OFS='\t' '{print $2,$3,$3+1,$1}' > ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed
    #count the number of molecules in each bin
    bedtools intersect -a A.bed -b ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed -c > ~/Work/dataset/restseq/binned_raw_MeanDescriptor.bed
    cat ~/Work/dataset/restseq/binned_raw_MeanDescriptor.bed | cut -f4 > ~/Work/dataset/restseq/p
fi
if [ "$mean" == "xz131419202122" ]; then
    cat ~/Work/dataset/restseq/xz{13,14,19,20,21,22}/outdata/?_?.bed | 
    LC_ALL=C sort -k1,1 -k2,2n | 
    LC_ALL=C uniq -c |
    awk -v OFS='\t' '{print $2,$3,$3+1,$1}' > ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed
    bedtools intersect -a A.bed -b ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed -c > ~/Work/dataset/restseq/binned_raw_MeanDescriptor.bed
    cat ~/Work/dataset/restseq/binned_raw_MeanDescriptor.bed | cut -f4 > ~/Work/dataset/restseq/p
fi
if [ "$mean" == "xz19202122" ]; then
    cat ~/Work/dataset/restseq/xz{19,20,21,22}/outdata/?_?.bed | 
    LC_ALL=C sort -k1,1 -k2,2n | 
    LC_ALL=C uniq -c |
    awk -v OFS='\t' '{print $2,$3,$3+1,$1}' > ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed
    bedtools intersect -a A.bed -b ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed -c > ~/Work/dataset/restseq/binned_raw_MeanDescriptor.bed
    norm_1=$(cat ~/Work/dataset/restseq/binned_raw_MeanDescriptor.bed | datamash sum 4)
    cat ~/Work/dataset/restseq/binned_raw_MeanDescriptor.bed | cut -f4 > ~/Work/dataset/restseq/p
fi
if [ "$mean" == "xz1314" ]; then
    cat ~/Work/dataset/restseq/xz{13,14}/outdata/?_?.bed | 
    LC_ALL=C sort -k1,1 -k2,2n | 
    LC_ALL=C uniq -c |
    awk -v OFS='\t' '{print $2,$3,$3+1,$1}' > ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed
    bedtools intersect -a A.bed -b ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed -c > ~/Work/dataset/restseq/binned_raw_MeanDescriptor.bed
    cat ~/Work/dataset/restseq/binned_raw_MeanDescriptor.bed | cut -f4 > ~/Work/dataset/restseq/p
fi
if [ "$mean" == "xz19" ]; then
    cat ~/Work/dataset/restseq/xz19/outdata/?_?.bed | LC_ALL=C sort -k1,1 -k2,2n | LC_ALL=C uniq -c |
    awk -v OFS='\t' '{print $2,$3,$3+1,$1}' > ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed
    bedtools intersect -a A.bed -b ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed -c > ~/Work/dataset/restseq/binned_raw_MeanDescriptor.bed
    cat ~/Work/dataset/restseq/binned_raw_MeanDescriptor.bed | cut -f4 > ~/Work/dataset/restseq/p
fi
if [ "$mean" == "xz20" ]; then
    cat ~/Work/dataset/restseq/xz20/outdata/?_?.bed | LC_ALL=C sort -k1,1 -k2,2n | LC_ALL=C uniq -c |
    awk -v OFS='\t' '{print $2,$3,$3+1,$1}' > ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed
    bedtools intersect -a A.bed -b ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed -c > ~/Work/dataset/restseq/binned_raw_MeanDescriptor.bed
    cat ~/Work/dataset/restseq/binned_raw_MeanDescriptor.bed | cut -f4 > ~/Work/dataset/restseq/p
fi
if [ "$mean" == "xz21" ]; then
    cat ~/Work/dataset/restseq/xz21/outdata/?_?.bed | LC_ALL=C sort -k1,1 -k2,2n | LC_ALL=C uniq -c |
    awk -v OFS='\t' '{print $2,$3,$3+1,$1}' > ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed
    bedtools intersect -a A.bed -b ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed -c > ~/Work/dataset/restseq/binned_raw_MeanDescriptor.bed
    cat ~/Work/dataset/restseq/binned_raw_MeanDescriptor.bed | cut -f4 > ~/Work/dataset/restseq/p
fi
if [ "$mean" == "xz22" ]; then
    cat ~/Work/dataset/restseq/xz22/outdata/?_?.bed | LC_ALL=C sort -k1,1 -k2,2n | LC_ALL=C uniq -c |
    awk -v OFS='\t' '{print $2,$3,$3+1,$1}' > ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed
    bedtools intersect -a A.bed -b ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed -c > ~/Work/dataset/restseq/binned_raw_MeanDescriptor.bed
    cat ~/Work/dataset/restseq/binned_raw_MeanDescriptor.bed | cut -f4 > ~/Work/dataset/restseq/p
fi
if [ "$mean" == "xz23" ]; then
    cat ~/Work/dataset/restseq/xz23/outdata/?_?.bed | LC_ALL=C sort -k1,1 -k2,2n | LC_ALL=C uniq -c |
    awk -v OFS='\t' '{print $2,$3,$3+1,$1}' > ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed
    bedtools intersect -a A.bed -b ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed -c > ~/Work/dataset/restseq/binned_raw_MeanDescriptor.bed
    cat ~/Work/dataset/restseq/binned_raw_MeanDescriptor.bed | cut -f4 > ~/Work/dataset/restseq/p
fi
if [ "$mean" == "xz24" ]; then
    cat ~/Work/dataset/restseq/xz24/outdata/?_?.bed | LC_ALL=C sort -k1,1 -k2,2n | LC_ALL=C uniq -c |
    awk -v OFS='\t' '{print $2,$3,$3+1,$1}' > ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed
    bedtools intersect -a A.bed -b ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed -c > ~/Work/dataset/restseq/binned_raw_MeanDescriptor.bed
    cat ~/Work/dataset/restseq/binned_raw_MeanDescriptor.bed | cut -f4 > ~/Work/dataset/restseq/p
fi
if [ "$mean" == "xz1920" ]; then
    cat ~/Work/dataset/restseq/xz{19,20}/outdata/?_?.bed | LC_ALL=C sort -k1,1 -k2,2n | LC_ALL=C uniq -c |
    awk -v OFS='\t' '{print $2,$3,$3+1,$1}' > ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed
    bedtools intersect -a A.bed -b ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed -c > ~/Work/dataset/restseq/binned_raw_MeanDescriptor.bed
    cat ~/Work/dataset/restseq/binned_raw_MeanDescriptor.bed | cut -f4 > ~/Work/dataset/restseq/p
fi
if [ "$mean" == "xz2122" ]; then
    cat ~/Work/dataset/restseq/xz{21,22}/outdata/?_?.bed | LC_ALL=C sort -k1,1 -k2,2n | LC_ALL=C uniq -c |
    awk -v OFS='\t' '{print $2,$3,$3+1,$1}' > ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed
    bedtools intersect -a A.bed -b ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed -c > ~/Work/dataset/restseq/binned_raw_MeanDescriptor.bed
    cat ~/Work/dataset/restseq/binned_raw_MeanDescriptor.bed | cut -f4 > ~/Work/dataset/restseq/p
fi
if [ "$mean" == "xz2324" ]; then
    cat ~/Work/dataset/restseq/xz23_24/outdata/?_?.bed | LC_ALL=C sort -k1,1 -k2,2n | LC_ALL=C uniq -c |
    awk -v OFS='\t' '{print $2,$3,$3+1,$1}' > ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed
    bedtools intersect -a A.bed -b ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed -c > ~/Work/dataset/restseq/binned_raw_MeanDescriptor.bed
    cat ~/Work/dataset/restseq/binned_raw_MeanDescriptor.bed | cut -f4 > ~/Work/dataset/restseq/p
fi
if [ "$mean" == "xz13" ]; then
    cat ~/Work/dataset/restseq/xz13/outdata/?_?.bed | LC_ALL=C sort -k1,1 -k2,2n | LC_ALL=C uniq -c |
    awk -v OFS='\t' '{print $2,$3,$3+1,$1}' > ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed
    bedtools intersect -a A.bed -b ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed -c > ~/Work/dataset/restseq/binned_raw_MeanDescriptor.bed
    cat ~/Work/dataset/restseq/binned_raw_MeanDescriptor.bed | cut -f4 > ~/Work/dataset/restseq/p
fi
if [ "$mean" == "xz14" ]; then
    cat ~/Work/dataset/restseq/xz14/outdata/?_?.bed | LC_ALL=C sort -k1,1 -k2,2n | LC_ALL=C uniq -c |
    awk -v OFS='\t' '{print $2,$3,$3+1,$1}' > ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed
    bedtools intersect -a A.bed -b ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed -c > ~/Work/dataset/restseq/binned_raw_MeanDescriptor.bed
    cat ~/Work/dataset/restseq/binned_raw_MeanDescriptor.bed | cut -f4 > ~/Work/dataset/restseq/p
fi
rm -f ~/Work/dataset/restseq/binned_raw_MeanDescriptor.bed ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed
#############################################################
# here we evaluate the distance between the $mean descriptor and the $local descriptor, region-wise: 
# KL($mean,$local[region])
if [ "$local" == "xz30" ]; then
    for file in $( ls ~/Work/dataset/restseq/xz30/outdata/*_*_*.bed ); do
	name=`echo $file|cut -d'/' -f9|cut -d'_' -f1`
	cat $file | LC_ALL=C sort -k1,1 -k2,2n | LC_ALL=C uniq -c |
	awk -v OFS='\t' '{print $2,$3,$3+1,$1}' > ~/Work/dataset/restseq/loc_count_descriptor.bed
	bedtools intersect -a A.bed -b ~/Work/dataset/restseq/loc_count_descriptor.bed -c > ~/Work/dataset/restseq/binned_raw_descriptor.bed
	cat ~/Work/dataset/restseq/binned_raw_descriptor.bed | cut -f4 > ~/Work/dataset/restseq/"$name" 
	val=$(cat ~/Work/dataset/restseq/"$name"|numsum)
	if [ "$val" -ge "$threshold" ]; then
	    python ~/Work/pipelines/restseq/bin/module/KL_divergence.py ~/Work/dataset/restseq/p ~/Work/dataset/restseq/"$name" $metric
	fi
	rm -f ~/Work/dataset/restseq/"$name" ~/Work/dataset/restseq/loc_count_descriptor.bed ~/Work/dataset/restseq/binned_raw_descriptor.bed
    done
fi
if [ "$local" == "xz13" ]; then
    for file in $( ls ~/Work/dataset/restseq/xz13/outdata/?_?.bed ); do
	name=`echo $file|cut -d'/' -f9`
	cat $file | LC_ALL=C sort -k1,1 -k2,2n | LC_ALL=C uniq -c |
	awk -v OFS='\t' '{print $2,$3,$3+1,$1}' > ~/Work/dataset/restseq/loc_count_descriptor.bed
	bedtools intersect -a A.bed -b ~/Work/dataset/restseq/loc_count_descriptor.bed -c > ~/Work/dataset/restseq/binned_raw_descriptor.bed
	cat ~/Work/dataset/restseq/binned_raw_descriptor.bed | cut -f4 > ~/Work/dataset/restseq/"$name" 
	val=$(cat ~/Work/dataset/restseq/"$name"|numsum)
	if [ "$val" -ge "$threshold" ]; then
	    python ~/Work/pipelines/restseq/bin/module/KL_divergence.py ~/Work/dataset/restseq/p ~/Work/dataset/restseq/"$name" $metric
	fi
	rm -f ~/Work/dataset/restseq/"$name" ~/Work/dataset/restseq/loc_count_descriptor.bed ~/Work/dataset/restseq/binned_raw_descriptor.bed
    done
fi
if [ "$local" == "xz14" ]; then
    for file in $( ls ~/Work/dataset/restseq/xz14/outdata/?_?.bed ); do
	name=`echo $file|cut -d'/' -f9`
	cat $file | LC_ALL=C sort -k1,1 -k2,2n | LC_ALL=C uniq -c |
	awk -v OFS='\t' '{print $2,$3,$3+1,$1}' > ~/Work/dataset/restseq/loc_count_descriptor.bed
	bedtools intersect -a A.bed -b ~/Work/dataset/restseq/loc_count_descriptor.bed -c > ~/Work/dataset/restseq/binned_raw_descriptor.bed
	cat ~/Work/dataset/restseq/binned_raw_descriptor.bed |cut -f4 > ~/Work/dataset/restseq/"$name" 
	val=$(cat ~/Work/dataset/restseq/"$name"|numsum)
	if [ "$val" -ge "$threshold" ]; then
	    python ~/Work/pipelines/restseq/bin/module/KL_divergence.py ~/Work/dataset/restseq/p ~/Work/dataset/restseq/"$name" $metric
	fi
	rm -f ~/Work/dataset/restseq/"$name" ~/Work/dataset/restseq/loc_count_descriptor.bed ~/Work/dataset/restseq/binned_raw_descriptor.bed
    done
fi
if [ "$local" == "xz19" ]; then
    for file in $( ls ~/Work/dataset/restseq/xz19/outdata/?_?.bed ); do
	name=`echo $file|cut -d'/' -f9`
	cat $file | LC_ALL=C sort -k1,1 -k2,2n | LC_ALL=C uniq -c |
	awk -v OFS='\t' '{print $2,$3,$3+1,$1}' > ~/Work/dataset/restseq/loc_count_descriptor.bed
	bedtools intersect -a A.bed -b ~/Work/dataset/restseq/loc_count_descriptor.bed -c > ~/Work/dataset/restseq/binned_raw_descriptor.bed
	cat ~/Work/dataset/restseq/binned_raw_descriptor.bed |cut -f4 > ~/Work/dataset/restseq/"$name" 
	val=$(cat ~/Work/dataset/restseq/"$name"|numsum)
	if [ "$val" -ge "$threshold" ]; then
	    python ~/Work/pipelines/restseq/bin/module/KL_divergence.py ~/Work/dataset/restseq/p ~/Work/dataset/restseq/"$name" $metric
	fi
	rm -f ~/Work/dataset/restseq/"$name" ~/Work/dataset/restseq/loc_count_descriptor.bed ~/Work/dataset/restseq/binned_raw_descriptor.bed
    done
fi
if [ "$local" == "xz20" ]; then
    for file in $( ls ~/Work/dataset/restseq/xz20/outdata/?_?.bed ); do
	name=`echo $file|cut -d'/' -f9`
	cat $file | LC_ALL=C sort -k1,1 -k2,2n | LC_ALL=C uniq -c |
	awk -v OFS='\t' '{print $2,$3,$3+1,$1}' > ~/Work/dataset/restseq/loc_count_descriptor.bed
	bedtools intersect -a A.bed -b ~/Work/dataset/restseq/loc_count_descriptor.bed -c > ~/Work/dataset/restseq/binned_raw_descriptor.bed
	cat ~/Work/dataset/restseq/binned_raw_descriptor.bed |cut -f4 > ~/Work/dataset/restseq/"$name" 
	val=$(cat ~/Work/dataset/restseq/"$name"|numsum)
	if [ "$val" -ge "$threshold" ]; then
	    python ~/Work/pipelines/restseq/bin/module/KL_divergence.py ~/Work/dataset/restseq/p ~/Work/dataset/restseq/"$name" $metric
	fi
	rm -f ~/Work/dataset/restseq/"$name" ~/Work/dataset/restseq/loc_count_descriptor.bed ~/Work/dataset/restseq/binned_raw_descriptor.bed
    done
fi
if [ "$local" == "xz21" ]; then
    for file in $( ls ~/Work/dataset/restseq/xz21/outdata/?_?.bed ); do
	name=`echo $file|cut -d'/' -f9`
	cat $file | LC_ALL=C sort -k1,1 -k2,2n | LC_ALL=C uniq -c |
	awk -v OFS='\t' '{print $2,$3,$3+1,$1}' > ~/Work/dataset/restseq/loc_count_descriptor.bed
	bedtools intersect -a A.bed -b ~/Work/dataset/restseq/loc_count_descriptor.bed -c > ~/Work/dataset/restseq/binned_raw_descriptor.bed
	cat ~/Work/dataset/restseq/binned_raw_descriptor.bed |cut -f4 > ~/Work/dataset/restseq/"$name" 
	val=$(cat ~/Work/dataset/restseq/"$name"|numsum)
	if [ "$val" -ge "$threshold" ]; then
	    python ~/Work/pipelines/restseq/bin/module/KL_divergence.py ~/Work/dataset/restseq/p ~/Work/dataset/restseq/"$name" $metric
	fi
	rm -f ~/Work/dataset/restseq/"$name" ~/Work/dataset/restseq/loc_count_descriptor.bed ~/Work/dataset/restseq/binned_raw_descriptor.bed
    done
fi
if [ "$local" == "xz22" ]; then
    for file in $( ls ~/Work/dataset/restseq/xz22/outdata/?_?.bed ); do
	name=`echo $file|cut -d'/' -f9`
	cat $file | LC_ALL=C sort -k1,1 -k2,2n | LC_ALL=C uniq -c |
	awk -v OFS='\t' '{print $2,$3,$3+1,$1}' > ~/Work/dataset/restseq/loc_count_descriptor.bed
	bedtools intersect -a A.bed -b ~/Work/dataset/restseq/loc_count_descriptor.bed -c > ~/Work/dataset/restseq/binned_raw_descriptor.bed
	cat ~/Work/dataset/restseq/binned_raw_descriptor.bed |cut -f4 > ~/Work/dataset/restseq/"$name" 
	val=$(cat ~/Work/dataset/restseq/"$name"|numsum)
	if [ "$val" -ge "$threshold" ]; then
	    python ~/Work/pipelines/restseq/bin/module/KL_divergence.py ~/Work/dataset/restseq/p ~/Work/dataset/restseq/"$name" $metric
	fi
	rm -f ~/Work/dataset/restseq/"$name" ~/Work/dataset/restseq/loc_count_descriptor.bed ~/Work/dataset/restseq/binned_raw_descriptor.bed
    done
fi
if [ "$local" == "xz1920" ]; then
    for file in $( ls ~/Work/dataset/restseq/xz19_20/outdata/?_?.bed ); do
	name=`echo $file|cut -d'/' -f9`
	cat $file | LC_ALL=C sort -k1,1 -k2,2n | LC_ALL=C uniq -c |
	awk -v OFS='\t' '{print $2,$3,$3+1,$1}' > ~/Work/dataset/restseq/loc_count_descriptor.bed
	bedtools intersect -a A.bed -b ~/Work/dataset/restseq/loc_count_descriptor.bed -c > ~/Work/dataset/restseq/binned_raw_descriptor.bed
	cat ~/Work/dataset/restseq/binned_raw_descriptor.bed |cut -f4 > ~/Work/dataset/restseq/"$name" 
	val=$(cat ~/Work/dataset/restseq/"$name"|numsum)
	if [ "$val" -ge "$threshold" ]; then
	    python ~/Work/pipelines/restseq/bin/module/KL_divergence.py ~/Work/dataset/restseq/p ~/Work/dataset/restseq/"$name" $metric
	fi
	rm -f ~/Work/dataset/restseq/"$name" ~/Work/dataset/restseq/loc_count_descriptor.bed ~/Work/dataset/restseq/binned_raw_descriptor.bed
    done
fi
if [ "$local" == "xz2122" ]; then
    for file in $( ls ~/Work/dataset/restseq/xz21_22/outdata/?_?.bed ); do
	name=`echo $file|cut -d'/' -f9`
	cat $file | LC_ALL=C sort -k1,1 -k2,2n | LC_ALL=C uniq -c |
	awk -v OFS='\t' '{print $2,$3,$3+1,$1}' > ~/Work/dataset/restseq/loc_count_descriptor.bed
	bedtools intersect -a A.bed -b ~/Work/dataset/restseq/loc_count_descriptor.bed -c > ~/Work/dataset/restseq/binned_raw_descriptor.bed
	cat ~/Work/dataset/restseq/binned_raw_descriptor.bed |cut -f4 > ~/Work/dataset/restseq/"$name" 
	val=$(cat ~/Work/dataset/restseq/"$name"|numsum)
	if [ "$val" -ge "$threshold" ]; then
	    python ~/Work/pipelines/restseq/bin/module/KL_divergence.py ~/Work/dataset/restseq/p ~/Work/dataset/restseq/"$name" $metric
	fi
	rm -f ~/Work/dataset/restseq/"$name" ~/Work/dataset/restseq/loc_count_descriptor.bed ~/Work/dataset/restseq/binned_raw_descriptor.bed
    done
fi
if [ "$local" == "xz2324" ]; then
    for file in $( ls ~/Work/dataset/restseq/xz23_24/outdata/?_?.bed ); do
	name=`echo $file|cut -d'/' -f9`
	cat $file | LC_ALL=C sort -k1,1 -k2,2n | LC_ALL=C uniq -c |
	awk -v OFS='\t' '{print $2,$3,$3+1,$1}' > ~/Work/dataset/restseq/loc_count_descriptor.bed
	bedtools intersect -a A.bed -b ~/Work/dataset/restseq/loc_count_descriptor.bed -c > ~/Work/dataset/restseq/binned_raw_descriptor.bed
	cat ~/Work/dataset/restseq/binned_raw_descriptor.bed |cut -f4 > ~/Work/dataset/restseq/"$name" 
	val=$(cat ~/Work/dataset/restseq/"$name"|numsum)
	if [ "$val" -ge "$threshold" ]; then
	    python ~/Work/pipelines/restseq/bin/module/KL_divergence.py ~/Work/dataset/restseq/p ~/Work/dataset/restseq/"$name" $metric
	fi
	rm -f ~/Work/dataset/restseq/"$name" ~/Work/dataset/restseq/loc_count_descriptor.bed ~/Work/dataset/restseq/binned_raw_descriptor.bed
    done
fi

rm -f ~/Work/dataset/restseq/p A.bed

#############################################################################

