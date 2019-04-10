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

rm -f /home/garner1/Dropbox/pipelines/cutseq/pattern/*${sample}
while read -r line; do
    lib=`echo $line|cut -d',' -f1`
    barcode=`echo $line|cut -d',' -f2`
    cutsite=`echo $line|cut -d',' -f3`
    echo $barcode$cutsite >> /home/garner1/Dropbox/pipelines/cutseq/pattern/${sample}
    fastq=${dir}/${lib}.fastq.gz
done < $inputfile
echo "if [ -f ${fastq} ]; then" >> run_pipeline_"$sample".sh
echo bash main.sh $sample human $mode /home/garner1/Dropbox/pipelines/cutseq/pattern/${sample} $cutsite $fastq >> run_pipeline_"$sample".sh
echo fi >> run_pipeline_"$sample".sh
chmod +x run_pipeline_"$sample".sh
