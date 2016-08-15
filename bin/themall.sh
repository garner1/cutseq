#!/usr/bin/env bash
pattern=/home/garner1/Work/pipelines/restseq/pattern
data=/home/garner1/Work/dataset/restseq

# exp=NC24;./module/EDA_tss.sh ~/Work/dataset/restseq/"$exp"/outdata aux1 aux2 5000 ~/Work/pipelines/data/AAGCTT.bed | cut -f-2 | LC_ALL=C sort -k2,2nr | cat -n - > ~/Work/dataset/restseq/"$exp"/outdata/rank.csv
# exp=NC421;./module/EDA_tss.sh ~/Work/dataset/restseq/"$exp"/outdata aux1 aux2 5000 ~/Work/pipelines/data/AAGCTT.bed | cut -f-2 | LC_ALL=C sort -k2,2nr | cat -n - > ~/Work/dataset/restseq/"$exp"/outdata/rank.csv
# exp=NC25;./module/EDA_tss.sh ~/Work/dataset/restseq/"$exp"/outdata aux1 aux2 5000 ~/Work/pipelines/data/AAGCTT.bed | cut -f-2 | LC_ALL=C sort -k2,2nr | cat -n - > ~/Work/dataset/restseq/"$exp"/outdata/rank.csv
# exp=NC26;./module/EDA_tss.sh ~/Work/dataset/restseq/"$exp"/outdata aux1 aux2 5000 ~/Work/pipelines/data/AAGCTT.bed | cut -f-2 | LC_ALL=C sort -k2,2nr | cat -n - > ~/Work/dataset/restseq/"$exp"/outdata/rank.csv

exp=NC432;./module/EDA_tss.sh ~/Work/dataset/restseq/"$exp"/outdata aux1 aux2 5000 ~/Work/pipelines/data/AAGCTT.bed | cut -f-2 | LC_ALL=C sort -k2,2nr | cat -n - > ~/Work/dataset/restseq/"$exp"/outdata/rank.csv

exp=NC53;./module/EDA_tss.sh ~/Work/dataset/restseq/"$exp"/outdata aux1 aux2 5000 ~/Work/pipelines/data/AAGCTT.bed | cut -f-2 | LC_ALL=C sort -k2,2nr | cat -n - > ~/Work/dataset/restseq/"$exp"/outdata/rank.csv
exp=NC55;./module/EDA_tss.sh ~/Work/dataset/restseq/"$exp"/outdata aux1 aux2 5000 ~/Work/pipelines/data/AAGCTT.bed | cut -f-2 | LC_ALL=C sort -k2,2nr | cat -n - > ~/Work/dataset/restseq/"$exp"/outdata/rank.csv
exp=NC56_PE;./module/EDA_tss.sh ~/Work/dataset/restseq/"$exp"/outdata aux1 aux2 5000 ~/Work/pipelines/data/AAGCTT.bed | cut -f-2 | LC_ALL=C sort -k2,2nr | cat -n - > ~/Work/dataset/restseq/"$exp"/outdata/rank.csv
exp=NC56_SE;./module/EDA_tss.sh ~/Work/dataset/restseq/"$exp"/outdata aux1 aux2 5000 ~/Work/pipelines/data/AAGCTT.bed | cut -f-2 | LC_ALL=C sort -k2,2nr | cat -n - > ~/Work/dataset/restseq/"$exp"/outdata/rank.csv
exp=NC57;./module/EDA_tss.sh ~/Work/dataset/restseq/"$exp"/outdata aux1 aux2 5000 ~/Work/pipelines/data/AAGCTT.bed | cut -f-2 | LC_ALL=C sort -k2,2nr | cat -n - > ~/Work/dataset/restseq/"$exp"/outdata/rank.csv
exp=NC6466;./module/EDA_tss.sh ~/Work/dataset/restseq/"$exp"/outdata aux1 aux2 5000 ~/Work/pipelines/data/GAATTC.bed | cut -f-2 | LC_ALL=C sort -k2,2nr | cat -n - > ~/Work/dataset/restseq/"$exp"/outdata/rank.csv
exp=NC87;./module/EDA_tss.sh ~/Work/dataset/restseq/"$exp"/outdata aux1 aux2 5000 ~/Work/pipelines/data/AAGCTT.bed | cut -f-2 | LC_ALL=C sort -k2,2nr | cat -n - > ~/Work/dataset/restseq/"$exp"/outdata/rank.csv
exp=NC88;./module/EDA_tss.sh ~/Work/dataset/restseq/"$exp"/outdata aux1 aux2 5000 ~/Work/pipelines/data/AAGCTT.bed | cut -f-2 | LC_ALL=C sort -k2,2nr | cat -n - > ~/Work/dataset/restseq/"$exp"/outdata/rank.csv
exp=NC89;./module/EDA_tss.sh ~/Work/dataset/restseq/"$exp"/outdata aux1 aux2 5000 ~/Work/pipelines/data/AAGCTT.bed | cut -f-2 | LC_ALL=C sort -k2,2nr | cat -n - > ~/Work/dataset/restseq/"$exp"/outdata/rank.csv
exp=NC101;./module/EDA_tss.sh ~/Work/dataset/restseq/"$exp"/outdata aux1 aux2 5000 ~/Work/pipelines/data/AAGCTT.bed | cut -f-2 | LC_ALL=C sort -k2,2nr | cat -n - > ~/Work/dataset/restseq/"$exp"/outdata/rank.csv
exp=NC105;./module/EDA_tss.sh ~/Work/dataset/restseq/"$exp"/outdata aux1 aux2 5000 ~/Work/pipelines/data/AAGCTT.bed | cut -f-2 | LC_ALL=C sort -k2,2nr | cat -n - > ~/Work/dataset/restseq/"$exp"/outdata/rank.csv

exp=XZ1;./module/EDA_tss.sh ~/Work/dataset/restseq/"$exp"/outdata aux1 aux2 5000 ~/Work/pipelines/data/GAATTC.bed | cut -f-2 | LC_ALL=C sort -k2,2nr | cat -n - > ~/Work/dataset/restseq/"$exp"/outdata/rank.csv
exp=XZ4;./module/EDA_tss.sh ~/Work/dataset/restseq/"$exp"/outdata aux1 aux2 5000 ~/Work/pipelines/data/GAATTC.bed | cut -f-2 | LC_ALL=C sort -k2,2nr | cat -n - > ~/Work/dataset/restseq/"$exp"/outdata/rank.csv
exp=XZ13;./module/EDA_tss.sh ~/Work/dataset/restseq/"$exp"/outdata aux1 aux2 5000 ~/Work/pipelines/data/AAGCTT.bed | cut -f-2 | LC_ALL=C sort -k2,2nr | cat -n - > ~/Work/dataset/restseq/"$exp"/outdata/rank.csv
exp=XZ14;./module/EDA_tss.sh ~/Work/dataset/restseq/"$exp"/outdata aux1 aux2 5000 ~/Work/pipelines/data/AAGCTT.bed | cut -f-2 | LC_ALL=C sort -k2,2nr | cat -n - > ~/Work/dataset/restseq/"$exp"/outdata/rank.csv
exp=XZ16;./module/EDA_tss.sh ~/Work/dataset/restseq/"$exp"/outdata aux1 aux2 5000 ~/Work/pipelines/data/AAGCTT.bed | cut -f-2 | LC_ALL=C sort -k2,2nr | cat -n - > ~/Work/dataset/restseq/"$exp"/outdata/rank.csv
exp=XZ17;./module/EDA_tss.sh ~/Work/dataset/restseq/"$exp"/outdata aux1 aux2 5000 ~/Work/pipelines/data/AAGCTT.bed | cut -f-2 | LC_ALL=C sort -k2,2nr | cat -n - > ~/Work/dataset/restseq/"$exp"/outdata/rank.csv
exp=XZ18;./module/EDA_tss.sh ~/Work/dataset/restseq/"$exp"/outdata aux1 aux2 5000 ~/Work/pipelines/data/AAGCTT.bed | cut -f-2 | LC_ALL=C sort -k2,2nr | cat -n - > ~/Work/dataset/restseq/"$exp"/outdata/rank.csv
exp=XZ19;./module/EDA_tss.sh ~/Work/dataset/restseq/"$exp"/outdata aux1 aux2 5000 ~/Work/pipelines/data/AAGCTT.bed | cut -f-2 | LC_ALL=C sort -k2,2nr | cat -n - > ~/Work/dataset/restseq/"$exp"/outdata/rank.csv
exp=XZ20;./module/EDA_tss.sh ~/Work/dataset/restseq/"$exp"/outdata aux1 aux2 5000 ~/Work/pipelines/data/AAGCTT.bed | cut -f-2 | LC_ALL=C sort -k2,2nr | cat -n - > ~/Work/dataset/restseq/"$exp"/outdata/rank.csv
exp=XZ21;./module/EDA_tss.sh ~/Work/dataset/restseq/"$exp"/outdata aux1 aux2 5000 ~/Work/pipelines/data/AAGCTT.bed | cut -f-2 | LC_ALL=C sort -k2,2nr | cat -n - > ~/Work/dataset/restseq/"$exp"/outdata/rank.csv
exp=XZ22;./module/EDA_tss.sh ~/Work/dataset/restseq/"$exp"/outdata aux1 aux2 5000 ~/Work/pipelines/data/AAGCTT.bed | cut -f-2 | LC_ALL=C sort -k2,2nr | cat -n - > ~/Work/dataset/restseq/"$exp"/outdata/rank.csv
exp=XZ23;./module/EDA_tss.sh ~/Work/dataset/restseq/"$exp"/outdata aux1 aux2 5000 ~/Work/pipelines/data/AAGCTT.bed | cut -f-2 | LC_ALL=C sort -k2,2nr | cat -n - > ~/Work/dataset/restseq/"$exp"/outdata/rank.csv
exp=XZ24;./module/EDA_tss.sh ~/Work/dataset/restseq/"$exp"/outdata aux1 aux2 5000 ~/Work/pipelines/data/AAGCTT.bed | cut -f-2 | LC_ALL=C sort -k2,2nr | cat -n - > ~/Work/dataset/restseq/"$exp"/outdata/rank.csv
exp=XZ30;./module/EDA_tss.sh ~/Work/dataset/restseq/"$exp"/outdata aux1 aux2 5000 ~/Work/pipelines/data/AAGCTT.bed | cut -f-2 | LC_ALL=C sort -k2,2nr | cat -n - > ~/Work/dataset/restseq/"$exp"/outdata/rank.csv
exp=BICRO22_XZ16;./module/EDA_tss.sh ~/Work/dataset/restseq/"$exp"/outdata aux1 aux2 5000 ~/Work/pipelines/data/AAGCTT.bed | cut -f-2 | LC_ALL=C sort -k2,2nr | cat -n - > ~/Work/dataset/restseq/"$exp"/outdata/rank.csv
exp=BICRO22_XZ17;./module/EDA_tss.sh ~/Work/dataset/restseq/"$exp"/outdata aux1 aux2 5000 ~/Work/pipelines/data/AAGCTT.bed | cut -f-2 | LC_ALL=C sort -k2,2nr | cat -n - > ~/Work/dataset/restseq/"$exp"/outdata/rank.csv
exp=BICRO22_XZ32;./module/EDA_tss.sh ~/Work/dataset/restseq/"$exp"/outdata aux1 aux2 5000 ~/Work/pipelines/data/AAGCTT.bed | cut -f-2 | LC_ALL=C sort -k2,2nr | cat -n - > ~/Work/dataset/restseq/"$exp"/outdata/rank.csv





















