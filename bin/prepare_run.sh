#!/bin/usr/env bash

# RUN AS: bash prepare_run.sh samplesheet.csv /media/bicroserver_2-seq/BICRO67/FASTQ
# head -1 samplesheet.csv as: XZ82,CATCACGC,CATG

inputfile=$1		      # samplesheet_BICRO67
dir=$2	     # /media/bicroserver_2-seq/BICRO67/FASTQ
run=$3	     # BICRO67
mode=$4	     # PE or SE

rm -f run_pipeline_"$run".sh

echo "#!/bin/usr/env bash" >> run_pipeline_"$run".sh # first line
echo >> run_pipeline_"$run".sh			   # empty space

while read -r line; do
    lib=`echo $line|cut -d',' -f1`
    barcode=`echo $line|cut -d',' -f2`
    cutsite=`echo $line|cut -d',' -f3`
    # mode=SE
    # cutsite=$cutsite
    echo $barcode$cutsite >> /home/garner1/Dropbox/pipelines/cutseq/pattern/${lib}${run}
done < $inputfile
fastq=$dir/${lib}*fast*.gz
echo bash main.sh $lib$run human $mode /home/garner1/Dropbox/pipelines/cutseq/pattern/${lib}${run} $cutsite $fastq >> run_pipeline_"$run".sh
echo >> run_pipeline_"$run".sh

chmod +x run_pipeline_"$run".sh
