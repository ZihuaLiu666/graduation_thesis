print('Plotting...')

import seaborn as sns
import pandas as pd
import matplotlib.pyplot as plt
from matplotlib.font_manager import FontProperties as FP
import argparse

###### arguments ######
parser = argparse.ArgumentParser()
parser.add_argument('-i','--input',metavar='File',dest='input',help='input file',type=open,required=True)
parser.add_argument('-o','--output',metavar='File',dest='output',help='output file directory',type=str,required=True)
parser.add_argument('-c','--color',metavar='Int',dest='num',help='number of CNVR',type=int,default=1)
args = parser.parse_args()
###### arguments ######

def plot_cnv():

    efp = FP('Times New Roman')
    sns.set_style('ticks')

    #fd = pd.read_csv('/Users/funnyboo/Desktop/exoc4.csv')
    bg = pd.read_csv(args.input)

    ##### exoc4 plotting #####
    #flatui = ["#9b59b6", "#3498db", "#95a5a6", "#e74c3c", "#34495e"]
    sns.violinplot(x='samples',y='CNVR{}'.format(args.num),data=bg,inner=None,size=20,palette='muted')
    sns.stripplot(x='samples',y='CNVR{}'.format(args.num),data=bg,jitter=True,edgecolor='none',size=4)

    plt.axhline(y=1.0, linestyle=':', color='black', linewidth=1)
    plt.axhline(y=1.5, linestyle=':', color='black', linewidth=1)
    plt.axhline(y=2.0, linestyle=':', color='black', linewidth=1)

    plt.xlabel('population',fontproperties=efp,fontsize=18)
    plt.ylabel('copy number variant',fontproperties=efp,fontsize=18)
    plt.xticks(fontproperties=efp,fontsize=14)
    plt.yticks(fontproperties=efp,fontsize=14)
    plt.title("CNV changed by ten years' artificial selection within CNVR{}".format(args.num),fontproperties=efp,fontsize=15)

    sns.plt.savefig('{}'.format(args.output),bbox_inches='tight')

plot_cnv()
