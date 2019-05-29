#!/usr/env/bin bash

cd /home/garner1/Work/dataset/XZ174BC158

# parallel "samtools view -s {1}.{2} -b XZ174BICRO158.GAATCCGA.deduplicated.sorted.bam | samtools view -bS - > {2}/bamfiles/perc-{1}.{2}.bam" ::: $(seq 210519001 210519200) ::: 005
# parallel "samtools view -s {1}.{2} -b XZ174BICRO158.GAATCCGA.deduplicated.sorted.bam | samtools view -bS - > {2}/bamfiles/perc-{1}.{2}.bam" ::: $(seq 210519001 210519200) ::: 01
# parallel "samtools view -s {1}.{2} -b XZ174BICRO158.GAATCCGA.deduplicated.sorted.bam | samtools view -bS - > {2}/bamfiles/perc-{1}.{2}.bam" ::: $(seq 210519001 210519200) ::: 05
# parallel "samtools view -s {1}.{2} -b XZ174BICRO158.GAATCCGA.deduplicated.sorted.bam | samtools view -bS - > {2}/bamfiles/perc-{1}.{2}.bam" ::: $(seq 210519001 210519200) ::: 10
# parallel "samtools view -s {1}.{2} -b XZ174BICRO158.GAATCCGA.deduplicated.sorted.bam | samtools view -bS - > {2}/bamfiles/perc-{1}.{2}.bam" ::: $(seq 210519001 210519200) ::: 25
# parallel "samtools view -s {1}.{2} -b XZ174BICRO158.GAATCCGA.deduplicated.sorted.bam | samtools view -bS - > {2}/bamfiles/perc-{1}.{2}.bam" ::: $(seq 210519001 210519200) ::: 50

# for perc in 005 01 05 10 25 50; do
#     for bin in 1000 100 10 500 50; do
# 	parallel /opt/R/3.5.3/bin/Rscript /home/garner1/Work/pipelines/CNV/prepare_cnv_profile.parallel.R {} ${bin} ::: \
# 		 /home/garner1/Work/dataset/XZ174BC158/${perc}/bamfiles/*.bam \
# 	    && mv /home/garner1/Work/dataset/XZ174BC158/${perc}/bamfiles/*.{pdf,tsv,bed} /home/garner1/Work/dataset/XZ174BC158/${perc}/${bin};
#     done;
# done

#THIS NEED TO BE RUN ONLY ONCE
for bin in 1000 100 10 500 50; do
    parallel /opt/R/3.5.3/bin/Rscript /home/garner1/Work/pipelines/CNV/prepare_cnv_profile.parallel.R {} ${bin} ::: \
	     /home/garner1/Work/dataset/XZ174BC158/100/bamfiles/*.bam \
	&& mv /home/garner1/Work/dataset/XZ174BC158/100/bamfiles/*.{pdf,tsv,bed} /home/garner1/Work/dataset/XZ174BC158/100/${bin};
done

# for kbp in 1000 500 100 50 10; do
#     for perc in 50 25 10 05 01 005; do
# 	echo ${kbp} ${perc};
# 	parallel "echo {1} {2};paste {1} {2} | tail -n+2 | tr '.' ',' | /usr/local/share/anaconda3/bin/datamash ppearson 5:10" ::: \
# 		 100/${kbp}/XZ174BICRO158.GAATCCGA.deduplicated.sorted.bam.tsv ::: \
# 		 ${perc}/${kbp}/perc-210519*tsv | \
# 	    paste - - | \
# 	    /usr/local/share/anaconda3/bin/datamash min 2 q1 2 median 2 q3 2 max 2;
#     done;
# done | paste - - | tr ',' '.'

# for kbp in 1000 500 100 50 10; do
#     for perc in 50 25 10 05 01 005;
#     do parallel "echo ${kbp} ${perc}; paste {1} {2} | tail -n+2 | tr '.' ',' | awk '{print sqrt((\$5-\$10)*(\$5-\$10))}'|/usr/local/share/anaconda3/bin/datamash mean 1" \
# 		::: 100/${kbp}/*.tsv ::: ${perc}/${kbp}/perc-*.tsv \
# 	    | paste - -;
#     done;
# done | tr ',' '.' 
