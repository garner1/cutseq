#!/usr/bin/env bash

tsvfile=$1			# obtained from bedops bam2bed 

uniqSites=`cut -f-2 $tsvfile | LC_ALL=C uniq | LC_ALL=C grep "^1\|^2\|^3\|^4\|^5\|^6\|^7\|^8\|^9\|^10\|^11\|^12\|^13\|^14\|^15\|^16\|^17\|^18\|^19\|^20\|^21\|^22" | wc -l`
size=`cat $tsvfile | grep "^1\|^2\|^3\|^4\|^5\|^6\|^7\|^8\|^9\|^10\|^11\|^12\|^13\|^14\|^15\|^16\|^17\|^18\|^19\|^20\|^21\|^22" | awk '{print $3-$2}' |datamash sum 1`
umi=`cat $tsvfile | grep "^1\|^2\|^3\|^4\|^5\|^6\|^7\|^8\|^9\|^10\|^11\|^12\|^13\|^14\|^15\|^16\|^17\|^18\|^19\|^20\|^21\|^22" | wc -l`

read_length=60
genome_length=3137161264

echo "The number of times a sequenced base is covered by a read is" `echo $umi $uniqSites | awk '{print $1/$2}'`
echo "The percentage of the relevant genome which is sequenced is" `echo $uniqSites $read_length $genome_length | awk '{print ($1*$2/$3)*100}'`
