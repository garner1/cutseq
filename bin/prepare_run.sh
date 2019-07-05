#!/bin/usr/env bash

# RUN AS: bash prepare_run.sh samplesheet.csv /media/bicroserver_2-seq/BICRO67/FASTQ
# head -1 samplesheet.csv as: XZ82,CATCACGC,CATG

inputfile=$1		      # samplesheet_BICRO67
dir=$2	     # /media/bicroserver_2-seq/BICRO67/FASTQ
sample=$3	     # XZ156BICRO67
mode=$4	     # PE or SE

rm -f run_pipeline_"$sample".sh

echo "#!/bin/usr/env bash" >> run_pipeline_"$sample".sh # first line
echo >> run_pipeline_"$sample".sh			   # empty space

rm -f /home/garner1/Work/pipelines/cutseq/pattern/*${sample}
while read -r line; do
    lib=`echo $line|cut -d',' -f1`
    run=`echo $line|cut -d',' -f4`
    barcode=`echo $line|cut -d',' -f2`
    cutsite=`echo $line|cut -d',' -f3`
    echo $barcode$cutsite >> /home/garner1/Work/pipelines/cutseq/pattern/${sample}
    fastq=${dir}/${sample}.fastq.gz
    fastq_R1=${dir}/${sample}_R1.fastq.gz
    fastq_R2=${dir}/${sample}_R2.fastq.gz
done < $inputfile
if [ "$mode" == "SE" ]; then
    ls -lh /home/garner1/Work/pipelines/cutseq/pattern/${sample} $fastq
    echo "if [ -f ${fastq} ]; then" >> run_pipeline_"$sample".sh
    echo "if [ -f /home/garner1/Work/pipelines/cutseq/pattern/${sample} ]; then" >> run_pipeline_"$sample".sh
    echo bash main.sh $sample human $mode /home/garner1/Work/pipelines/cutseq/pattern/${sample} $cutsite $fastq >> run_pipeline_"$sample".sh
    echo fi >> run_pipeline_"$sample".sh
    echo fi >> run_pipeline_"$sample".sh
fi
if [ "$mode" == "PE" ]; then
    ls -lh /home/garner1/Work/pipelines/cutseq/pattern/${sample} $fastq_R1 $fastq_R2
    echo "if [ -f ${fastq_R1} ]; then" >> run_pipeline_"$sample".sh
    echo "if [ -f ${fastq_R2} ]; then" >> run_pipeline_"$sample".sh
    echo "if [ -f /home/garner1/Work/pipelines/cutseq/pattern/${sample} ]; then" >> run_pipeline_"$sample".sh
    echo bash main.sh $sample human $mode /home/garner1/Work/pipelines/cutseq/pattern/${sample} $cutsite $fastq_R1 $fastq_R2 >> run_pipeline_"$sample".sh
    echo fi >> run_pipeline_"$sample".sh
    echo fi >> run_pipeline_"$sample".sh
    echo fi >> run_pipeline_"$sample".sh
fi
chmod +x run_pipeline_"$sample".sh
