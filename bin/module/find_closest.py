# -*- coding: utf-8 -*-

# First filter filename and enzyme wrt to a chromosome, 
# so that 'filename' contains list of locations only of UMI for a chromosome
# while 'enzyme' is the list of locations for a given chromosome.
# At the end parse the UMI file, substituting the output of this script to the UMI location for a given chromosome

from bisect import bisect_left
import sys
import csv
import numpy as np

filename = sys.argv[1]          # the file whose UMI need to be filtered
enzyme = sys.argv[2]            # the file with list of restriction sites
thefile = open(sys.argv[3], 'wa') # output file name


with open(filename, 'rb') as f:
    reader = csv.reader(f)
    data = list(reader)
data = map(int, [item for sublist in data for item in sublist] )

with open(enzyme, 'rb') as f:
    reader = csv.reader(f)
    RS = list(reader)
RS = map(int, [item for sublist in RS for item in sublist] )

def takeClosest(myList, myNumber):
    """
    Assumes myList is sorted. Returns closest value to myNumber.

    If two numbers are equally close, return the smallest number.
    """
    pos = bisect_left(myList, myNumber)
    if pos == 0:
        return myList[0]
    if pos == len(myList):
        return myList[-1]
    before = myList[pos - 1]
    after = myList[pos]
    if after - myNumber < myNumber - before:
       return after
    else:
       return before

for ind in range(len(data)):
    data[ind] = takeClosest(RS,data[ind])

for item in data:
    print>>thefile, item


