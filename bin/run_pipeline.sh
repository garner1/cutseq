#!/bin/usr/env bash

# bash main.sh test human SE /home/garner1/Dropbox/pipelines/reduced_sequencing/pattern/barcode-cutsite_XZ114 CATG /home/garner1/Work/dataset/reduced_sequencing/test.fastq.gz

bash main.sh XZ114 human SE /home/garner1/Dropbox/pipelines/reduced_sequencing/pattern/barcode-cutsite_XZ114 CATG /home/garner1/Work/dataset/reduced_sequencing/XZ114.fastq.gz & pid1=$!
bash main.sh XZ115 human SE /home/garner1/Dropbox/pipelines/reduced_sequencing/pattern/barcode-cutsite_XZ115 CATG /home/garner1/Work/dataset/reduced_sequencing/XZ115.fastq.gz & pid2=$!
bash main.sh XZ117 human SE /home/garner1/Dropbox/pipelines/reduced_sequencing/pattern/barcode-cutsite_XZ117 CATG /home/garner1/Work/dataset/reduced_sequencing/XZ117.fastq.gz & pid3=$!
bash main.sh XZ118 human SE /home/garner1/Dropbox/pipelines/reduced_sequencing/pattern/barcode-cutsite_XZ118 CATG /home/garner1/Work/dataset/reduced_sequencing/XZ118.fastq.gz & pid4=$!
wait $pid1
wait $pid2
wait $pid3
wait $pid4

bash main.sh XZ119 human SE /home/garner1/Dropbox/pipelines/reduced_sequencing/pattern/barcode-cutsite_XZ119 CATG /home/garner1/Work/dataset/reduced_sequencing/XZ119.fastq.gz & pid5=$!
bash main.sh XZ120 human SE /home/garner1/Dropbox/pipelines/reduced_sequencing/pattern/barcode-cutsite_XZ120 CATG /home/garner1/Work/dataset/reduced_sequencing/XZ120.fastq.gz & pid6=$!
bash main.sh XZ121 human SE /home/garner1/Dropbox/pipelines/reduced_sequencing/pattern/barcode-cutsite_XZ121 CATG /home/garner1/Work/dataset/reduced_sequencing/XZ121.fastq.gz & pid7=$!
bash main.sh XZ122 human SE /home/garner1/Dropbox/pipelines/reduced_sequencing/pattern/barcode-cutsite_XZ122 CATG /home/garner1/Work/dataset/reduced_sequencing/XZ122.fastq.gz & pid8=$!
bash main.sh XZ91 human SE /home/garner1/Dropbox/pipelines/reduced_sequencing/pattern/barcode-cutsite_XZ91 CATG /home/garner1/Work/dataset/reduced_sequencing/XZ91.fastq.gz & pid9=$!
wait $pid5
wait $pid6
wait $pid7
wait $pid8
wait $pid9

