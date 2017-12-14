import seaborn as sns
import matplotlib.pyplot as plt
import pandas as pd
from matplotlib.font_manager import FontProperties as FP

efp = FP('Times New Roman')

fd = pd.read_csv('/Users/funnyboo/Desktop/pca_kde.csv')
sns.set_style('ticks')
y2005=fd.loc[fd.year == 2005]
y2008=fd.loc[fd.year == 2008]
y2011=fd.loc[fd.year == 2011]
y2014=fd.loc[fd.year == 2014]

sns.kdeplot(y2005.pc1,y2005.pc2,cmap="Reds", shade=True, shade_lowest=False)
#sns.kdeplot(y2008.pc1,y2008.pc2,cmap="YlGn", shade=True, shade_lowest=False)
#sns.kdeplot(y2011.pc1,y2011.pc2,cmap="Greens", shade=True, shade_lowest=False)
sns.kdeplot(y2014.pc1,y2014.pc2,cmap="Blues", shade=True, shade_lowest=False)


plt.xlabel('PC1',fontproperties=efp,fontsize=14)
plt.ylabel('PC2',fontproperties=efp,fontsize=14)

plt.xticks(fontproperties=efp,fontsize=14)
plt.yticks(fontproperties=efp,fontsize=14)
plt.title("year 2014 population evolved from year 2005 population",fontproperties=efp,fontsize=16)
plt.legend()

sns.plt.show()
#sns.plt.savefig('/Users/funnyboo/Desktop/dvd.pdf',bbox_inches='tight')
