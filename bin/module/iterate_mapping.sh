#!/usr/bin/env bash

numbproc=$1
refgen=$2
in=$3
out=$4
barcode=$5
aux=$6
mode=$7

chop=5

#first mapping
if [ "$mode" == "PE" ]
then
    bwa mem -t $numbproc $refgen "$in"/"$barcode".fq "$in"/"$barcode"-r2.fq > "$out"/"$barcode".sam
fi
if [ "$mode" == "SE" ]
then
    # echo $mode
    bwa mem -t $numbproc $refgen "$in"/"$barcode".fq > "$out"/"$barcode".sam
fi


#keep only q>1 reads
samtools view -hq 1 "$out"/"$barcode".sam > "$out"/keep.sam

# iteratively shorten the read by 5bp, and stop when the length is 30bp
if [ "$mode" == "PE" ]
then
    for chop in {5..30..5}
    do
	echo $chop
	# samtools view "$out"/keep.sam | wc -l
	
	#exclude from barcode.sam the keep.sam part
	java -jar ~/tools/picard-tools-2.1.0/picard.jar FilterSamReads I="$out"/"$barcode".sam FILTER=excludeReadList RLF="$out"/keep.sam O="$aux"/tryagain.sam
    
	#bring tryagain.sam in fq format
	java -jar ~/tools/picard-tools-2.1.0/picard.jar SamToFastq I="$aux"/tryagain.sam F="$aux"/r1long.fq F2="$aux"/r2long.fq

	#chop R1 and R2 
	cat "$aux"/r1long.fq|paste - - - -| awk -v chop="$chop" '{print $1,substr($2, 1, length($2)-chop),$3,substr($4, 1, length($4)-chop)}'|tr ' ' '\n' > "$aux"/r1.fq
	cat "$aux"/r2long.fq|paste - - - -| awk -v chop="$chop" '{print $1,substr($2, 1, length($2)-chop),$3,substr($4, 1, length($4)-chop)}'|tr ' ' '\n' > "$aux"/r2.fq

	#map the new R1-2
	bwa mem -t $numbproc $refgen "$aux"/r1.fq "$aux"/r2.fq > "$out"/"$barcode"_new.sam
	
	#from the new mapping keep only the mapped ones
	samtools view -Sq 1 "$out"/"$barcode"_new.sam | cat "$out"/keep.sam - > "$out"/newkeep.sam
	mv "$out"/newkeep.sam "$out"/keep.sam
    done
    mv "$out"/keep.sam "$out"/"$barcode".sam
fi
if [ "$mode" == "SE" ]
then
    for chop in {5..30..5}
    do
	echo $chop
	# samtools view "$out"/keep.sam | wc -l
	
	#exclude from barcode.sam the keep.sam part
	java -jar ~/tools/picard-tools-2.1.0/picard.jar FilterSamReads I="$out"/"$barcode".sam FILTER=excludeReadList RLF="$out"/keep.sam O="$aux"/tryagain.sam
    
	#bring tryagain.sam in fq format
	java -jar ~/tools/picard-tools-2.1.0/picard.jar SamToFastq I="$aux"/tryagain.sam F="$aux"/r1long.fq

	#chop R1
	cat "$aux"/r1long.fq|paste - - - -| awk -v chop="$chop" '{print $1,substr($2, 1, length($2)-chop),$3,substr($4, 1, length($4)-chop)}'|tr ' ' '\n' > "$aux"/r1.fq

	#map the new R1
	bwa mem -t $numbproc $refgen "$aux"/r1.fq > "$out"/"$barcode"_new.sam
	
	#from the new mapping keep only the mapped ones
	samtools view -Sq 1 "$out"/"$barcode"_new.sam | cat "$out"/keep.sam - > "$out"/newkeep.sam
	mv "$out"/newkeep.sam "$out"/keep.sam
    done
    mv "$out"/keep.sam "$out"/"$barcode".sam
fi

