# coding: utf-8
#!/usr/bin/env python

from collections import defaultdict
import matplotlib.pyplot as plt

# Data below is the example
## 12      12      3970    1.53940886700739e-05
## 12      12      3977    0.0166666666666683
## 14      14      633     4.50755014656826e-05
## 14      14      1850    0.0169749216300928

# load numeric matrix from .txt file
def loadData(text):
    inFile = open(text,'r')
    # define a blank for coming input numeric data
    X = []
    for line in inFile:
        trainingSet = line.split()
        #print(trainingSet)
        X.append((int(trainingSet[0]),float(trainingSet[3])))
    #return (X)
    ab = defaultdict(list)
    for i in range(1,34):
        for n in X:
            if i == n[0]:
                ab[i].append(n[1])
    #return ab
    # calculate length
    abl = {}
    for ii in ab.keys():
        abl[ii] = len(ab[ii])
    #print(abl)
    ######################
    ## {1: 1, 2: 3, 3: 1, 4: 1, 5: 1, 6: 1, 7: 1, 8: 1, 9: 1, 10: 1, 11: 1, 12: 19, 13: 1, 14: 20} ##
    l = []
    for i in abl.keys():
        l.append(abl[i])
    #print(l)
    ######################
    for iii in abl.keys():
        if iii == 1:
            #print(range(1,abl[iii]+1))
            #print(ab[iii])
            plt.scatter(range(1,abl[iii]+1),ab[iii])
        elif iii == 2:
            #print(range(l[0]+1,sum(l[0:2])+1))
            #print(ab[iii])
            plt.scatter(range(l[0]+1,sum(l[0:2])+1),ab[iii])
        else:
            #print(range(sum(l[0:iii-1])+1,sum(l[0:iii])+1))
            #print(ab[iii])
            plt.scatter(range(sum(l[0:iii-1])+1,sum(l[0:iii])+1),ab[iii])
    plt.show()

##
