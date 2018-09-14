#!/usr/bin/env bash

bamfile=$1			# full path to bamfile
mode=$2				# PE or SE


if [ "$mode" == "SE" ];	then
    numbReads=`samtools view -F 0x904 $bamfile | cut -f3- | LC_ALL=C grep "^1\|^2\|^3\|^4\|^5\|^6\|^7\|^8\|^9\|^10\|^11\|^12\|^13\|^14\|^15\|^16\|^17\|^18\|^19\|^20\|^21\|^22" | wc -l`
    uniqLoc=`samtools view -F 0x904 $bamfile | cut -f3,4 | LC_ALL=C uniq | LC_ALL=C grep "^1\|^2\|^3\|^4\|^5\|^6\|^7\|^8\|^9\|^10\|^11\|^12\|^13\|^14\|^15\|^16\|^17\|^18\|^19\|^20\|^21\|^22" | wc -l`
fi
if [ "$mode" == "PE" ];	then
    numbReads=`samtools view -F 0x4 $bamfile | awk '{print $3"\t"$0}' | LC_ALL=C grep "^1\|^2\|^3\|^4\|^5\|^6\|^7\|^8\|^9\|^10\|^11\|^12\|^13\|^14\|^15\|^16\|^17\|^18\|^19\|^20\|^21\|^22" | cut -f2 | LC_ALL=C sort | LC_ALL=C uniq | wc -l`
    uniqLoc=`samtools view -F 0x4 $bamfile | awk '{print $3"\t"$0}' | LC_ALL=C grep "^1\|^2\|^3\|^4\|^5\|^6\|^7\|^8\|^9\|^10\|^11\|^12\|^13\|^14\|^15\|^16\|^17\|^18\|^19\|^20\|^21\|^22" | cut -f4,5 | LC_ALL=C sort | LC_ALL=C uniq | wc -l`
fi
echo $numbReads $uniqLoc
