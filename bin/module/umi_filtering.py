# -*- coding: utf-8 -*-

import sys
import csv
import numpy as np

filename = sys.argv[1]          # the file whose UMI need to be filtered
mm_gap = int(sys.argv[2])       # UMI differing at most by this value are identified
chromosome = sys.argv[3]        # which chromosome to consider
outfile = open(sys.argv[4], 'wa') 

with open(filename, 'rb') as f:
    reader = csv.reader(f,delimiter='\t')
    data = list(reader)

count = len(data)
ind1 = 0
# LOOP FIRST INDEX
while ind1 < count:
    ind2 = ind1+1
    # CONTROLED LOOP OVER SECOND INDEX BASED ON COLOCALIZATION
    while ind2 < count and data[ind2][1] == data[ind1][1]:
        s1 = data[ind1][4]
        s2 = data[ind2][4]
        if len(s1) == len(s2):
            numb_mismatches = sum(c1!=c2 for c1,c2 in zip(s1,s2))
        else:
            numb_mismatches = mm_gap+1
        # CONTROL OVER UMI SIMILARITY
        if numb_mismatches <= mm_gap:
            # RICH GETS RICHER
            if int(data[ind1][5]) >= int(data[ind2][5]):
                data[ind1][5] = str(int(data[ind1][5])+int(data[ind2][5]))
                del data[ind2]
            else:
                data[ind2][5] = str(int(data[ind1][5])+int(data[ind2][5]))        
                del data[ind1]
                ind2 = len(data)
                ind1 = ind1 - 1
        if numb_mismatches > mm_gap:
            ind2 += 1
        count = len(data)
    ind1 += 1

for item in data:
    print>>outfile, [item[0],item[1],item[2],item[3],item[4],item[5]]

print 'Done with filtering UMIs in ', chromosome
