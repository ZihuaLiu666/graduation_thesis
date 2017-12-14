import math
import argparse

###### arguments ######
parser = argparse.ArgumentParser()
parser.add_argument('-i','--input',metavar='File',dest='input',help='input file',type=open,required=True)
parser.add_argument('-t','--threshold',metavar='Int',dest='trhd',help='threshold',type=float,default=3)
parser.add_argument('-c','--color',metavar='Int',dest='color',help='color mode',type=int,default=8)
args = parser.parse_args()
def filter():
    # define a blank for coming input numeric data
    X = []
    for line in args.input:
        trainingSet = line.split()
        #print(trainingSet)
        if not trainingSet[0] == 'Z':
            if not trainingSet[0] == 'W':
                if not trainingSet[0] == 'U':
                    if math.log10(float(trainingSet[2])) <= -1*args.trhd:
                        X.append((int(trainingSet[0]),int(trainingSet[1]),math.log10(float(trainingSet[2]))*(-1)))
                        print(X)
                    else:
                        continue

filter()
