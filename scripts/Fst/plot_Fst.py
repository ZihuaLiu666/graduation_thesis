# coding: utf-8
#!/usr/bin/env python

from collections import defaultdict
from matplotlib.font_manager import FontProperties as FP
import matplotlib.pyplot as plt
import numpy as np
import argparse

###### arguments ######
parser = argparse.ArgumentParser()
parser.add_argument('-i','--input',metavar='File',dest='input',help='input file',type=open,required=True)
parser.add_argument('-t','--threshold',metavar='Int',dest='trhd',help='threshold',type=float,default=0.15)
parser.add_argument('-c','--color',metavar='Int',dest='color',help='color mode',type=int,default=2)
args = parser.parse_args()
###### arguments ######

# Data below is the example
## 12      12      3970    1.53940886700739e-05
## 12      12      3977    0.0166666666666683
## 14      14      633     4.50755014656826e-05
## 14      14      1850    0.0169749216300928

# load numeric matrix from .txt file
def plot_Fst():
    # define a blank for coming input numeric data
    X = []
    for line in args.input:
        trainingSet = line.split()
        #print(trainingSet)
        X.append((int(trainingSet[0]),float(trainingSet[3])))
    #return (X)
    ab = defaultdict(list)
    for i in range(1,29):
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
    efp = FP('Times New Roman')

    if args.color == 2:
        def circle(x):
            if -1*np.cos(np.pi*x) == 1:
                return (0.78,0.78,0.78)
            else:
                return (0.43,0.43,0.43)
        for iii in abl.keys():
            if iii == 1:
                plt.scatter(range(1,abl[iii]+1),ab[iii],edgecolor = 'none',s = 12,c = circle(iii),alpha=0.65)
            elif iii == 2:
                plt.scatter(range(l[0]+1,sum(l[0:2])+1),ab[iii],edgecolor = 'none',s = 12,c = circle(iii),alpha=0.65)
            else:
                plt.scatter(range(sum(l[0:iii-1])+1,sum(l[0:iii])+1),ab[iii],edgecolor = 'none',s = 12,c = circle(iii),alpha=0.65)
    else:
        ## color ##
        cr = (0.82,0.28,0.27)
        cy = (0.82,0.72,0.27)
        cg = (0.51,0.84,0.27)
        cgb = (0.35,0.84,0.42)
        cc = (0.30,0.80,0.82)
        cb = (0.27,0.34,0.82)
        cp = (0.55,0.22,0.82)
        cm = (0.82,0.22,0.64)
        ## color ##
        for iii in abl.keys():
            if iii == 1:
                #print(range(1,abl[iii]+1))
                #print(ab[iii])
                plt.scatter(range(1,abl[iii]+1),ab[iii],edgecolor = 'none',s = 12,c = (0.82,0.28,0.27),alpha=0.65)
            elif iii == 2:
                #print(range(l[0]+1,sum(l[0:2])+1))
                #print(ab[iii])
                plt.scatter(range(l[0]+1,sum(l[0:2])+1),ab[iii],edgecolor = 'none',s = 12,c = (0.82,0.72,0.27),alpha=0.65)
            else:
                #print(range(sum(l[0:iii-1])+1,sum(l[0:iii])+1))
                #print(ab[iii])
                cvalue = ['n','n','n',cg,cgb,cc,cb,cp,cm,cr,cy,cg,cgb,cc,cb,cp,cm,cr,cy,cg,cgb,cc,cb,cp,cm,cr,cy,cg,cgb,cc,cb,cp,cm,cr,cy]
                plt.scatter(range(sum(l[0:iii-1])+1,sum(l[0:iii])+1),ab[iii],edgecolor = 'none',s = 12,c = cvalue[iii],alpha=0.65)
    #plt.show()
    ## plot information
    plt.ylim(args.trhd,0.55)
    plt.xlim(0,sum(l))

    ## set tick
    #ax=plt.gca()
    #ax.set_yticks(np.linspace(0,1,5))
    #ax.set_yticklabels(('0.15', '0.25', '0.35', '0.45', '0.55'))
    ##
    ####
    #plt.axes().get_xaxis().set_visible(False)
    ####
    plt.title('Fst (>= {}) among genome SNPs'.format(args.trhd),fontsize=16,fontproperties=efp)
    plt.xlabel('relative position',fontsize=14,fontproperties=efp)
    plt.ylabel('Fst',fontsize=14,fontproperties=efp)
    plt.tick_params(axis='both',labelsize=10)
    plt.savefig('/Users/funnyboo/Desktop/name.pdf')

plot_Fst()
