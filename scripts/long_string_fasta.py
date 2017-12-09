# coding: utf-8
#!/usr/bin/env python

import argparse


###### arguments ######
parser = argparse.ArgumentParser()
parser.add_argument('-i','--Input',metavar='File',dest='input',help='Input file',type=open,required=True)
parser.add_argument('-o','--Output',metavar='File',dest='output',help='Output file',type=argparse.FileType('w'),required=True)
args = parser.parse_args()
###### arguments ######

def product_list():
    aDict={}
    for line in args.input:
        if line[0]=='>':
            key=line.strip().split()[0]
            aDict[key]=[]
        else:
            aDict.setdefault(key,[]).append(line.strip())
    #print(aDict)
    for k in aDict.keys():
        #print(k.lstrip('>'))
        value = ''.join(list(aDict[k]))
        print >> args.output,value



product_list()
