#!/usr/bin/env bash

bamfile=$1

samtools view $bamfile | cut -f3,4 | LC_ALL=C uniq | LC_ALL=C grep "^1\|^2\|^3\|^4\|^5\|^6\|^7\|^8\|^9\|^10\|^11\|^12\|^13\|^14\|^15\|^16\|^17\|^18\|^19\|^20\|^21\|^22" | wc -l

