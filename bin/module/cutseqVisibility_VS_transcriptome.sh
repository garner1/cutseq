#!/usr/bin/env bash

annotations=$1			# ~/Work/dataset/bioinf.iasi.cnr.it/bed/brca/rnaseqv2/gene.quantification/annotations.tsv
bedfile=$2

# total=`cat $bedfile | wc -l`	# total number of reads
# sed 's/^chr//' $annotations | grep -v chromosome |
#     bedtools intersect -a - -b $bedfile -c |
#     awk -v total=${total} '{print $5"\t"$NF}' |
#     sort -k2,2nr > ${bedfile}:gene-RC.tsv # provide RC per gene and myRPKM

# q3_RC=`cat ${bedfile}:gene-RC.tsv | tr '.' ',' | datamash q3 2 | tr ',' '.'` # 75perc of RM

# cat ${bedfile}:gene-RC.tsv | awk -v q3_RC=$q3_RC '$2>q3_RC' > ${bedfile}:gene-top25RC.tsv # filter top RC

# cut -f1 ${bedfile}:gene-top25RC.tsv > ${bedfile}.top25RC.genelist # get the list of top genes

# parallel "LC_ALL=C grep -nwf ${bedfile}.top25RC.genelist {} | cut -d':' -f1 | datamash mean 1" ::: /home/garner1/Work/dataset/bioinf.iasi.cnr.it/bed/brca/rnaseqv2/gene.quantification/bedfiles/*.sorted |
#     datamash mean 1 > ${bedfile}.top25RC.genelist.mean.txt # take the mean of the mean ranks of the selected genes in each TCGA case

n=`cat ${bedfile}.top25RC.genelist|wc -l`
rm ${bedfile}.random.genelist-RC.mean.txt
for loop in `seq 1 1000`;
do
    tfile=$(mktemp /tmp/foo.XXXXXXXXX)
    cut -f5 $annotations | shuf -n $n > $tfile
    parallel "LC_ALL=C grep -nwf $tfile {}|cut -d':' -f1|datamash mean 1" ::: /home/garner1/Work/dataset/bioinf.iasi.cnr.it/bed/brca/rnaseqv2/gene.quantification/bedfiles/*.sorted |
	datamash mean 1 >> ${bedfile}.random.genelist-RC.mean.txt
done

mymean=`cat ${bedfile}.top25RC.genelist.mean.txt | datamash round 1`
samplemean=`cat ${bedfile}.random.genelist-RC.mean.txt | datamash mean 1 | datamash round 1`
samplestd=`cat ${bedfile}.random.genelist-RC.mean.txt | datamash sstdev 1 | datamash round 1`
significance=$(( ($mymean-$samplemean)/$samplestd ))
echo "file: "$bedfile "number of random instances: " $n "top cutseq genes mean rank: "$mymean "top transcribed genes mean rank: "$samplemean "significance: "$significance
