import numpy as np
import matplotlib.pyplot as plt

my_file= open("first_passage_D=10.0.dat","r")
histo= open("histogram_D=10.0.dat","w")

#Save data from file in numpy array
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
