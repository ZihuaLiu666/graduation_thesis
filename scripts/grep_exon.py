# coding: utf-8
#!/usr/bin/env python

import argparse

###### arguments ######
parser = argparse.ArgumentParser()
parser.add_argument('-p','--Position',metavar='File',dest='position',help='Position file',type=open,required=True)
parser.add_argument('-f','--fasta',metavar='File',dest='fasta',help='Fasta file',type=open,required=True)
parser.add_argument('-o','--Output',metavar='File',dest='output',help='Output file',type=argparse.FileType('w'),required=True)
args = parser.parse_args()
###### arguments ######

def grep_exon():
    a = []
    for line in args.position:
        line = line.strip().split()
        if line[2] == 'exon':
            a.append([line[3],line[4]])
    a.sort()

# store all the position info to dict
    dict = {}
    index = 1
    for ia in a:
        dict[index] = [int(ia[0]),int(ia[1])]
        index = index + 1

    ab = {}
    for line in args.fasta:
        line = line.strip()
        for k in dict.keys():
            #print(k)
            p1 = int(dict[k][0]) - 1
            p2 = int(dict[k][1])
            ab[k] = line[p1:p2]
    #print(ab)

    #oo = open(args.output,'w')
    value = []
    for k in ab.keys():
        value.append(ab[k])
    #print(value)
    #oo.write(''.join(list(value)))
    #oo.close()
    print >> args.output,''.join(list(value))

grep_exon()

