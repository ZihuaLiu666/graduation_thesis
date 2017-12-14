import seaborn as sns
import matplotlib.pyplot as plt
import pandas as pd
from matplotlib.font_manager import FontProperties as FP

efp = FP('Times New Roman')

bw = pd.read_csv('/Users/funnyboo/Desktop/4years.bw.trait.csv')
sns.set_style('ticks')

sns.violinplot(x='year',y='weight',data=bw,inner=None,palette="muted",size=8)
#sns.stripplot(x='year',y='weight',data=bw,jitter=True,edgecolor='none')
plt.xlabel('year',fontproperties=efp,fontsize=18)
plt.ylabel('breast weight',fontproperties=efp,fontsize=18)
plt.xticks(fontproperties=efp,fontsize=14)
plt.yticks(fontproperties=efp,fontsize=14)
plt.title("breast weight increased among 10 years' artificial selection",fontproperties=efp,fontsize=15)

sns.plt.savefig('/Users/funnyboo/Desktop/breast_weight.pdf',bbox_inches='tight')
