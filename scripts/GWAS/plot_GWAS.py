from collections import defaultdict
import math
from matplotlib.font_manager import FontProperties as FP
import matplotlib.pyplot as plt
import numpy as np
import argparse

###### arguments ######
parser = argparse.ArgumentParser()
parser.add_argument('-i','--input',metavar='File',dest='input',help='input file',type=open,required=True)
parser.add_argument('-o','--output',metavar='File',dest='output',help='output file directory',type=str,required=True)
parser.add_argument('-oo','--ooutput',metavar='File',dest='ooutput',help='ooutput file directory',type=argparse.FileType('w'),required=True)
parser.add_argument('-t','--threshold',metavar='Int',dest='trhd',help='threshold',type=int,default=3)
parser.add_argument('-c','--color',metavar='Int',dest='color',help='color mode',type=int,default=8)
args = parser.parse_args()
###### arguments ######

def plot_GWAS():
    # define a blank for coming input numeric data
    X = []
    yy = []
    for line in args.input:
        trainingSet = line.split()
        #print(trainingSet)
        if not trainingSet[0] == 'Z':
            if not trainingSet[0] == 'W':
                if not trainingSet[0] == 'U':
                    if math.log10(float(trainingSet[2])) <= -1*args.trhd:
                        X.append((int(trainingSet[0]),math.log10(float(trainingSet[2]))*(-1)))
                        #print(X)
                    else:
                        continue

    #return (X)
    #print(X)
    ab = defaultdict(list)
    for i in range(1,30):
        for n in X:
            if i == n[0]:
                ab[i].append(n[1])
    #print(ab)

    ## find maximum and minimum##
    ma = 0
    mi = 0
    for i in ab.keys():
        print(i,max(ab[i]))
        if max(ab[i]) > ma:
            ma = max(ab[i])
        else:
            ma = ma

        if min(ab[i]) < mi:
            mi = mi
        else:
            mi = min(ab[i])
    #print(mi)
    #print(ma)
    #return m
    ## find maximum and minimum##

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
    plt.figure(figsize = (14,4))
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
                plt.scatter(range(1,abl[iii]+1),ab[iii],edgecolor = 'none',s = 12,c = (0.82,0.28,0.27),alpha=0.65)
            elif iii == 2:
                plt.scatter(range(l[0]+1,sum(l[0:2])+1),ab[iii],edgecolor = 'none',s = 12,c = (0.82,0.72,0.27),alpha=0.65)
            else:
                cvalue = ['n','n','n',cg,cgb,cc,cb,cp,cm,cr,cy,cg,cgb,cc,cb,cp,cm,cr,cy,cg,cgb,cc,cb,cp,cm,cr,cy,cg,cgb,cc,cb,cp,cm,cr,cy]
                plt.scatter(range(sum(l[0:iii-1])+1,sum(l[0:iii])+1),ab[iii],edgecolor = 'none',s = 12,c = cvalue[iii],alpha=0.65)

    #plt.hlines(0.40, 0, sum(l),linestyles = 'dashed',color=(0.82,0.22,0.64),linewidth=0.8,alpha=0.65)
    #plt.show()
    ## plot information

    plt.ylim(mi,ma+1)
    plt.xlim(0,sum(l))
    plt.axes().get_xaxis().set_visible(False)
    ####
    efp = FP('Times New Roman')
    plt.title('genome-wide association study on breast weight',fontsize=60,fontproperties=efp)
    #plt.xlabel('relative position',fontsize=14,fontproperties=efp)
    plt.ylabel('-log10(p)',fontsize=24,fontproperties=efp)
    plt.tick_params(axis='both',labelsize=10)

    #print(args.output)
    #/Users/funnyboo/Desktop
    plt.savefig('{}/name.pdf'.format(args.output))

plot_GWAS()
