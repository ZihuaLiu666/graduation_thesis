# coding: utf-8
#!/usr/bin/env python

import argparse
import functools
import time
from collections import defaultdict

###### arguments ######
parser = argparse.ArgumentParser()
parser.add_argument('-i','--Input',metavar='File',dest='input',help='Input file',type=open,required=True)
parser.add_argument('-o','--Output',metavar='File',dest='output',help='Output file',type=argparse.FileType('w'),required=True)
parser.add_argument('-s','--sca',metavar='Int',dest='sca',help='sca num',type=int,default=30)
args = parser.parse_args()
###### arguments ######

### alnSize: aligned length (alnSize1 and alnSize2 is not identity becasue of some gaps and mismatches)
### seqSize: for example, the length of scaffold 28 is 58444652

###   score             name1             start1   alnSize1 strand1 seqSize1        name2   start2   alnSize2  strand2 ###
###   128431   pilon_p_hic_scaffold_28   5910316   129308     +     58444652        chr1   75305415   129355     +     ###

def metric(func):
    @functools.wraps(func)
    def wrapper(*args,**kw):
        print('\n\nCall %s()'%func.__name__)
        print('...')
        print('%s executed in %s\n' %(func.__name__,time.strftime('%Y%m%d%H%M%S')))
        return func(*args,**kw)
    return wrapper

def num_only(text):
    '''pilon_p_hic_scaffold_28'''
    text = text.strip().split('_')
    return int(text[4])



@metric
def extract_sca():
    dict = defaultdict(list)
    for line in args.input:
        line = line.strip().split()
        if len(line) != 0:
            if line[0] != '#':
                if num_only(line[1]) <= args.sca:
                    index = num_only(line[1])
                    dict[index].append(line[6])
        else:
            continue
    SortedDict = sorted(dict.items(), key=lambda e:e[0], reverse=False)

    for i in SortedDict:
        print >> args.output,i[0],list(set(i[1]))

extract_sca()
