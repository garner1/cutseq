# -*- coding: utf-8 -*-

import sys
import csv
import numpy as np

filename = sys.argv[1]

with open(filename, 'rb') as f:
    reader = csv.reader(f)
    data = list(reader)

# GROUP TOGETHER CONSECUTIVE IDENTICAL UMIS, ASSUMING THEIR PROXIMITY
row_old = data[0]
data_aggegated_by_umi_identity = [row_old]
for row in data[1:]:
    # do not consider the strand, which is better for restseq; same chr and UMI
    if (row_old[0]==row[0] and row_old[4]==row[4]): 
        if int(row[5]) >= int(row_old[5]):
            row[5] = str(int(row[5])+int(row_old[5]))
        else:
            row[5] = str(int(row[5])+int(row_old[5]))
            row[1:3] = row_old[1:3]
        del data_aggegated_by_umi_identity[-1]
    data_aggegated_by_umi_identity.append(row)
    row_old = row

# GROUP TOGETHER CLOSE SPATIAL CONSECUTIVE READS WHOSE UMI DIFFERS AT MOST BY 1 MISMATCHES
row_old = data_aggegated_by_umi_identity[0]
data_aggegated_by_umi_similarity = [row_old]
space_gap = 100 
mm_gap = 1 #mismatch tolerance
for row in data_aggegated_by_umi_identity[1:]:
    s1 = row_old[4]
    s2 = row[4]
    if len(s1) == len(s2):
        numb_mismatches = sum(c1!=c2 for c1,c2 in zip(s1,s2))
    else:
        numb_mismatches = mm_gap+1
    dist = abs(int(row[1])-int(row_old[1]))
    if (row_old[0]==row[0] and dist<=space_gap and numb_mismatches<=mm_gap): # do not consider the strand, which is better for restseq
        if int(row[5]) >= int(row_old[5]):
            row[5] = str(int(row[5])+int(row_old[5]))
        else:
            row[5] = str(int(row[5])+int(row_old[5]))
            row[1:3] = row_old[1:3]
            row[4] = row_old[4]
        del data_aggegated_by_umi_similarity[-1]
    data_aggegated_by_umi_similarity.append(row)
    row_old = row

thefile = open(sys.argv[2], 'wa') 
for item in data_aggegated_by_umi_similarity:
  print>>thefile, item

print 'Done with filtering UMIs!'
