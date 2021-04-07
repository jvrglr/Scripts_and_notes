import numpy as np
import matplotlib.pyplot as plt

data = np.random.normal(size=10000)
plt.hist(data, bins=np.logspace(np.log10(0.1),np.log10(1.0), 50))
plt.gca().set_xscale("log")
plt.gca().set_yscale("log")
plt.show()


my_file= open("first_passage_D=10.0.dat","r")
histo= open("histogram_D=10.0.dat","w")

#Saved data from file in numpy array
data=np.loadtxt(my_file,dtype=float)
bins=15
frc, bin_edges = np.histogram(data,bins=bins)
h=bin_edges[1]-bin_edges[0]
norm=1/(h*np.sum(frc))
print(np.sum(frc))
for i in range(bins):
    x=np.min(data)+h*float(i)
    histo.write((str(x)+" "+str(float(frc[i])*norm)+"\n"))

my_file.close()
histo.close()
