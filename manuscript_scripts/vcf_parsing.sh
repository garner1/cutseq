#!/usr/bin/env bash

vcffile_1=$1
vcffile_2=$2
dir=$3
DP=$4
QUAL=$5

bcftools view -i "MIN(FMT/DP)>$DP & QUAL>$QUAL" ${vcffile_1} | bgzip -c > ${vcffile_1}.ge${DP}.vcf.gz
bcftools view -i "MIN(FMT/DP)>$DP & QUAL>$QUAL" ${vcffile_2} | bgzip -c > ${vcffile_2}.ge${DP}.vcf.gz

tabix ${vcffile_1}.ge${DP}.vcf.gz
tabix ${vcffile_2}.ge${DP}.vcf.gz

bcftools isec -p ${dir} ${vcffile_1}.ge${DP}.vcf.gz ${vcffile_2}.ge${DP}.vcf.gz
###############################################
# AFTER RUNNING AND COMMENTING THE FIRST PART:
# parallel -k "bcftools stats {} |grep 'number of records:'|cut -f4" ::: ${dir}/000{0,1,2}.vcf | paste - - - |awk '{print $3/($1+$2+$3)}'
# parallel -k "bcftools stats {} |grep 'number of records:'|cut -f4" ::: ${dir}/000{0,1,2}.vcf | paste - - - 
###############################################
# COMPARE DEPTH FROM DIFFERENT VCF FILES
# bcftools query -f '%CHROM %POS[\t%ID\t%DP]\n' PATH2FILE/0002.vcf
# bcftools query -f '%CHROM %POS[\t%ID\t%DP]\n' PATH2FILE/0003.vcf 
