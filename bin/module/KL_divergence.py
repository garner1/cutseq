from scipy import stats
from numpy import loadtxt
from numpy import linalg as LA
from numpy import count_nonzero
from scipy.spatial import distance as DIST
import sys

p1 = sys.argv[1]
p2 = sys.argv[2]
var = sys.argv[3]

data1 = loadtxt(str(p1))
data2 = loadtxt(str(p2))

if count_nonzero(data1)*count_nonzero(data2) > 0:
    if var == 'sym': 
        print "The symmetrized KL divergence of "+str(p1)+" from the "+str(p2)+" is: "+ str(0.5*( stats.entropy(data1,data2)+stats.entropy(data2,data1) ))
    if var == 'asym':
        print "The information lost in "+str(p2)+" from "+str(p1)+" is: "+ str(stats.entropy(data1,data2))
    if var == 'norm_1':
        delta = data1*1.0/LA.norm(data1,1) - data2*1.0/LA.norm(data2,1) 
        print 'The norm-1 difference is: '+str( LA.norm(delta,1)  )
    if var == 'norm_2':
        # print 'The cosine distance is: '+str( DIST.cosine(data1,data2)  )
        print DIST.cosine(data1,data2)
else: print 'nan'
