# -*- coding: utf-8 -*-
#!/usr/bin/env python3
"""
Created on Wed Mar 22 09:50:41 2017
@Mail: minnglee@163.com
@Author: Ming Li
"""

import sys
import os
import argparse
import math
import time
import re

def GetCommandLine():
    CommandLine = 'python3 {0}'.format(' '.join(sys.argv))
    return(CommandLine)
LogFile = None
def log(LogInfo):
    '''
    Output the LogInfo to log file
    '''
    global LogFile
    if sys.platform == 'linux':
        CurrentFolder = os.getcwd()
        LogFileName = re.split('/|\\\\',sys.argv[0].strip())
        LogFileName = LogFileName[-1].split('.')
        LogFileName = '{0}/{1}.log'.format(CurrentFolder,LogFileName[0])
        if LogFile: LogFile.write(LogInfo+'\n')
        else:
            LogFile = open(LogFileName,'w')
            LogFile.write(LogInfo+'\n')
    else:
        print(LogInfo)
def MakeIntraChrMatrix():
    '''
    E00509:81:HF7YCALXX:8:1107:17513:39809  chr28   46      +       chr28   169     -       123     chr28   0       109     chr28    109     973
    E00509:81:HF7YCALXX:8:2122:4898:45734   chr28   59      +       chr28   11168   +       154     chr28   0       109     chr28    10681   11272
    E00509:81:HF7YCALXX:8:2209:16823:41708  chr28   69      +       chr28   204     -       135     chr28   0       109     chr28    109     973
    '''
    Dict = {}
    for line in args.input:
        line = line.strip().split()
        if int(line[2]) < args.start or  int(line[2]) > args.end: continue
        if int(line[5]) < args.start or  int(line[5]) > args.end: continue
        Index = '{0}\t{1}'.format(math.ceil((int(line[2])-args.start)/args.bin), math.ceil((int(line[5])-args.start)/args.bin))
        if Index in Dict:
            Dict[Index] += 1
        else:
            Dict[Index] = 1
    SortedDict = sorted(Dict.items(), key=lambda e:e[0], reverse=False)
    for matrix in SortedDict:
        args.output.write('{0}\t{1}\n'.format(matrix[0],matrix[1]))
def main():
    print('Running...')
    log('The start time: {0}'.format(time.ctime()))
    log('The command line is:\n{0}'.format(GetCommandLine()))
    MakeIntraChrMatrix()
    log('The end time: {0}'.format(time.ctime()))
    print('Done!')
#############################Argument
parser = argparse.ArgumentParser(description=print(__doc__),formatter_class=argparse.ArgumentDefaultsHelpFormatter)
parser.add_argument('-i','--Input',metavar='File',dest='input',help='Input file',type=open,required=True)
parser.add_argument('-b','--bin',metavar='Int',dest='bin',help='bin size',type=int,default=10000)
parser.add_argument('-s','--start',metavar='Int',dest='start',help='start pos',type=int,default=0)
parser.add_argument('-e','--end',metavar='Int',dest='end',help='end pos',type=int,default=100000000)
parser.add_argument('-o','--Output',metavar='File',dest='output',help='Output file',type=argparse.FileType('w'),required=True)
args = parser.parse_args()
###########################
if __name__ == '__main__':
    main()