#!/bin/usr/env bash

# RUN AS: bash prepare_run.sh samplesheet.csv /media/bicroserver_2-seq/BICRO67/FASTQ
# head -1 samplesheet.csv as: XZ82,CATCACGC,CATG

inputfile=$1
dir=$2	     # /media/bicroserver_2-seq/BICRO67/FASTQ

rm -f run_pipeline.sh

echo "#!/bin/usr/env bash" >> run_pipeline.sh # first line
echo >> run_pipeline.sh			   # empty space

while read -r line; do
    lib=`echo $line|cut -d',' -f1`
    barcode=`echo $line|cut -d',' -f2`
    cutsite=`echo $line|cut -d',' -f3`
    mode=SE
    cutsite=$cutsite
    echo $barcode$cutsite > ../pattern/barcode-cutsite_$lib
    fastq=$dir/$lib.fastq.gz
    echo bash main.sh $lib human $mode /home/garner1/Dropbox/pipelines/reduced_sequencing/pattern/barcode-cutsite_$lib $cutsite $fastq >> run_pipeline.sh
    echo >> run_pipeline.sh
done < $inputfile

chmod +x run_pipeline.sh
