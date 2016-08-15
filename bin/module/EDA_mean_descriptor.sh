#!/usr/bin/env bash

exp=$1				# can be {all,xz13,xz14,xz19,xz20,xz21,xz22,xz23,xz24,xz1920,xz2122,xz2324}
resolution=$2			# resolution of the binned genome
metric=$3			# metric to compare descriptors

#create bed files representing the binned genome
~/Work/pipelines/aux.scripts/make-windows.sh $resolution hg19 > A.bed

if [ "$exp" == "xz30" ]; then
    # build decriptor for xz30
    cat ~/Work/dataset/restseq/xz30/outdata/*_*_*.bed | LC_ALL=C sort -k1,1 -k2,2n | LC_ALL=C uniq -c |
    awk -v OFS='\t' '{print $2,$3,$3+1,$1}' > ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed
    bedtools intersect -a A.bed -b ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed -c > ~/Work/dataset/restseq/binned_raw_MeanDescriptor.bed
fi
if [ "$exp" == "xz1314192021222324" ]; then
    # merge all dataset
    cat ~/Work/dataset/restseq/xz{13,14,19,20,21,22,23,24}/outdata/?_?.bed | 
    LC_ALL=C sort -k1,1 -k2,2n | 
    LC_ALL=C uniq -c |
    awk -v OFS='\t' '{print $2,$3,$3+1,$1}' > ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed
    #count the number of molecules in each bin
    bedtools intersect -a A.bed -b ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed -c > ~/Work/dataset/restseq/binned_raw_MeanDescriptor.bed
fi
if [ "$exp" == "xz19" ]; then
    # build decriptor for xz19
    cat ~/Work/dataset/restseq/xz19/outdata/?_?.bed | LC_ALL=C sort -k1,1 -k2,2n | LC_ALL=C uniq -c |
    awk -v OFS='\t' '{print $2,$3,$3+1,$1}' > ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed
    bedtools intersect -a A.bed -b ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed -c > ~/Work/dataset/restseq/binned_raw_MeanDescriptor.bed
fi
if [ "$exp" == "xz20" ]; then
    # build decriptor for xz20
    cat ~/Work/dataset/restseq/xz20/outdata/?_?.bed | LC_ALL=C sort -k1,1 -k2,2n | LC_ALL=C uniq -c |
    awk -v OFS='\t' '{print $2,$3,$3+1,$1}' > ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed
    bedtools intersect -a A.bed -b ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed -c > ~/Work/dataset/restseq/binned_raw_MeanDescriptor.bed
fi
if [ "$exp" == "xz21" ]; then
    # build decriptor for xz21
    cat ~/Work/dataset/restseq/xz21/outdata/?_?.bed | LC_ALL=C sort -k1,1 -k2,2n | LC_ALL=C uniq -c |
    awk -v OFS='\t' '{print $2,$3,$3+1,$1}' > ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed
    bedtools intersect -a A.bed -b ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed -c > ~/Work/dataset/restseq/binned_raw_MeanDescriptor.bed
fi
if [ "$exp" == "xz22" ]; then
    # build decriptor for xz22
    cat ~/Work/dataset/restseq/xz22/outdata/?_?.bed | LC_ALL=C sort -k1,1 -k2,2n | LC_ALL=C uniq -c |
    awk -v OFS='\t' '{print $2,$3,$3+1,$1}' > ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed
    bedtools intersect -a A.bed -b ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed -c > ~/Work/dataset/restseq/binned_raw_MeanDescriptor.bed
fi
if [ "$exp" == "xz23" ]; then
    # build decriptor for xz23
    cat ~/Work/dataset/restseq/xz23/outdata/?_?.bed | LC_ALL=C sort -k1,1 -k2,2n | LC_ALL=C uniq -c |
    awk -v OFS='\t' '{print $2,$3,$3+1,$1}' > ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed
    bedtools intersect -a A.bed -b ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed -c > ~/Work/dataset/restseq/binned_raw_MeanDescriptor.bed
fi
if [ "$exp" == "xz24" ]; then
    # build decriptor for xz24
    cat ~/Work/dataset/restseq/xz24/outdata/?_?.bed | LC_ALL=C sort -k1,1 -k2,2n | LC_ALL=C uniq -c |
    awk -v OFS='\t' '{print $2,$3,$3+1,$1}' > ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed
    bedtools intersect -a A.bed -b ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed -c > ~/Work/dataset/restseq/binned_raw_MeanDescriptor.bed
fi
if [ "$exp" == "xz1920" ]; then
    # build decriptor for xz19+20
    cat ~/Work/dataset/restseq/xz{19,20}/outdata/?_?.bed | LC_ALL=C sort -k1,1 -k2,2n | LC_ALL=C uniq -c |
    awk -v OFS='\t' '{print $2,$3,$3+1,$1}' > ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed
    bedtools intersect -a A.bed -b ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed -c > ~/Work/dataset/restseq/binned_raw_MeanDescriptor.bed
fi
if [ "$exp" == "xz2122" ]; then
    # build decriptor for xz21+22
    cat ~/Work/dataset/restseq/xz{21,22}/outdata/?_?.bed | LC_ALL=C sort -k1,1 -k2,2n | LC_ALL=C uniq -c |
    awk -v OFS='\t' '{print $2,$3,$3+1,$1}' > ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed
    bedtools intersect -a A.bed -b ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed -c > ~/Work/dataset/restseq/binned_raw_MeanDescriptor.bed
fi
if [ "$exp" == "xz2324" ]; then
    # build decriptor for xz23+24
    cat ~/Work/dataset/restseq/xz234/outdata/?_?.bed | LC_ALL=C sort -k1,1 -k2,2n | LC_ALL=C uniq -c |
    awk -v OFS='\t' '{print $2,$3,$3+1,$1}' > ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed
    bedtools intersect -a A.bed -b ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed -c > ~/Work/dataset/restseq/binned_raw_MeanDescriptor.bed
fi
if [ "$exp" == "xz13" ]; then
    # build decriptor for xz13
    cat ~/Work/dataset/restseq/xz13/outdata/?_?.bed | LC_ALL=C sort -k1,1 -k2,2n | LC_ALL=C uniq -c |
    awk -v OFS='\t' '{print $2,$3,$3+1,$1}' > ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed
    bedtools intersect -a A.bed -b ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed -c > ~/Work/dataset/restseq/binned_raw_MeanDescriptor.bed
fi
if [ "$exp" == "xz14" ]; then
    # build decriptor for xz14
    cat ~/Work/dataset/restseq/xz14/outdata/?_?.bed | LC_ALL=C sort -k1,1 -k2,2n | LC_ALL=C uniq -c |
    awk -v OFS='\t' '{print $2,$3,$3+1,$1}' > ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed
    bedtools intersect -a A.bed -b ~/Work/dataset/restseq/loc_count_MeanDescriptor.bed -c > ~/Work/dataset/restseq/binned_raw_MeanDescriptor.bed
fi

cd ~/Work/dataset/restseq
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_2324 p_mean $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_1920 p_mean $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_2122 p_mean $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_13 p_mean $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_14 p_mean $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_19 p_mean $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_20 p_mean $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_21 p_mean $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_22 p_mean $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_23 p_mean $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_24 p_mean $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_1920 p_2324 $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_2122 p_2324 $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_13 p_2324 $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_14 p_2324 $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_19 p_2324 $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_20 p_2324 $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_21 p_2324 $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_22 p_2324 $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_23 p_2324 $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_24 p_2324 $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_2122 p_1920 $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_13 p_1920 $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_14 p_1920 $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_19 p_1920 $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_20 p_1920 $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_21 p_1920 $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_22 p_1920 $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_23 p_1920 $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_24 p_1920 $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_13 p_2122 $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_14 p_2122 $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_19 p_2122 $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_20 p_2122 $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_21 p_2122 $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_22 p_2122 $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_23 p_2122 $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_24 p_2122 $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_14 p_13 $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_19 p_13 $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_20 p_13 $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_21 p_13 $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_22 p_13 $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_23 p_13 $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_24 p_13 $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_19 p_14 $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_20 p_14 $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_21 p_14 $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_22 p_14 $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_23 p_14 $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_24 p_14 $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_20 p_19 $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_21 p_19 $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_22 p_19 $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_23 p_19 $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_24 p_19 $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_21 p_20 $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_22 p_20 $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_23 p_20 $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_24 p_20 $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_22 p_21 $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_23 p_21 $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_24 p_21 $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_23 p_22 $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_24 p_22 $metric
# python ~/Work/pipelines/restseq/bin/module/KL_divergence.py p_24 p_23 $metric
cd ~/Work/pipelines/restseq/bin/module
rm -f ~/Work/dataset/restseq/binned_raw_MeanDescriptor_{1,2}.bed

#############################################################################

