import seaborn as sns
import matplotlib.pyplot as plt
import pandas as pd
from matplotlib.font_manager import FontProperties as FP

efp = FP('Times New Roman')

fd = pd.read_csv('/Users/funnyboo/Desktop/a.csv')
sns.set_style('ticks')
sns.distplot(fd, rug=True, hist=False,color='r')

#plt.ylabel('frequency',fontproperties=efp,fontsize=18)
plt.xticks(fontproperties=efp,fontsize=14)
plt.yticks(fontproperties=efp,fontsize=14)
plt.title("distribution of Fst based on genome SNPs",fontproperties=efp,fontsize=15)

sns.plt.savefig('/Users/funnyboo/Desktop/distribution_Fst.pdf',bbox_inches='tight')
