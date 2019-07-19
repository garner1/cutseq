# CUTseq
Pipeline for CUTseq 

Some of the tools needed are: umi_tools, gnu parallel, alfred tool

cd ./bin

bash main.sh {samplename} {human||mourse} {SE||PE} ./pattern/{BARCODE}-{CUTSITE}_{samplename} {CUTSITE} {fullpath2 fastq.gz file}

To test the pipeline, in the bin directory run:
bash test_pipeline

Or 
bash main.sh test human SE ../pattern/test CATG test/fastq/test.fastq.gz

