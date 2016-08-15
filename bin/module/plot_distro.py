import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
import sys

data1 = np.loadtxt(str(sys.argv[1]))
data2 = np.loadtxt(str(sys.argv[2]))
name = sys.argv[3]

fig, ax = plt.subplots()

sns.distplot(data1,ax=ax,label='all genes')
sns.distplot(data2,ax=ax,label='PAM50')
#ax.set_xlim(0,1000)
ax.legend()
ax.set_title(str(name))
plt.show()

