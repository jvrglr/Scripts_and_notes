### Table of Contents

* [Jupyter notebook](#chapter1)
* [Calling Fortran routines from Python](#chapter2)
* [Networkx](#chapter3)
* [Input/ Data from 'keyboard'](#chapter4)
* [Measure time](#chapter5)
* [Try/except](#chapter6)
* [Zip/unzip](#chapter7)
* [Logical operators](#chapter8)
* [Files](#chapter9)
* [OS](#chapter10)
* [Functions](#chapter11)
* [Numpy](#chapter12)
* [Strings](#chapter13)
* [Dictionary](#chapter14)
* [Booleans](#chapter15)
* [Tuple](#chapter16)
* [Set](#chapter17)
* [List](#chapter18)
* [Map](#chapter19)
* [Filter](#chapter20)
* [Import](#chapter21)
* [Pandas](#chapter22)
* [Debugger](#chapter23)
* [Matplotlib](#chapter24)
* [Fits](#chapter25)
* [Efficiency](#chapter26)
* [Stochastic processes](#chapter27)

### Jupyter notebook <a class="anchor" id="chapter1"></a>
```
%reset #delete variables/names
#%matplotlib notebook
import sys
from scipy.optimize import curve_fit
import numpy as np
import networkx as nx
import matplotlib.pyplot as plt
import time
import math 
import pandas as pd
from mpl_toolkits.mplot3d import Axes3D  # noqa: F401 unused import
from matplotlib import cm
from matplotlib.ticker import LinearLocator, FormatStrFormatter
import matplotlib.patches as patches
%matplotlib inline

def Plot_bonito(xlabel=r"name_x$",ylabel=r"name_y$",label_font_size=15,ticks_size=12,y_size=2.1,x_size=2.8):
    #FOR SINGLE COLUMN FIGURE; ,y_size=2.4,x_size=3.2
    #FOR TWO FIGURES TWO COLUMNS: ,y_size=2.1,x_size=2.8
    matplotlib.rcParams.update({'figure.autolayout': True})
    matplotlib.rcParams['mathtext.fontset'] = 'custom'
    matplotlib.rcParams['mathtext.rm'] = 'Bitstream Vera Sans'
    matplotlib.rcParams['mathtext.it'] = 'Bitstream Vera Sans:italic'
    matplotlib.rcParams['mathtext.bf'] = 'Bitstream Vera Sans:bold'
    matplotlib.rcParams['mathtext.fontset'] = 'cm'
    matplotlib.rcParams['font.family'] = 'STIXGeneral'
#-----------------------------------------------------
    plt.rcParams.update({'font.size':12})
    plt.figure(figsize=(x_size,y_size))
    plt.rcParams['axes.linewidth']=2 #Grosor del marco (doble del standard)
    plt.tick_params(labelsize=24)
    plt.xlabel(xlabel,fontsize=label_font_size)
    plt.ylabel(ylabel,fontsize=label_font_size)
    plt.xticks(fontsize=ticks_size)
    plt.yticks(fontsize=ticks_size)


```

### Calling Fortran routines from Python<a class="anchor" id="chapter2"></a>
https://www.numfys.net/howto/F2PY/  
  
  
### Networx <a class="anchor" id="chapter3"></a>
Create Edge list
```
#From networxs network to edge list. len(Ed)=len(G.nodes())*k_max
#Ed[i][0]=degree(i)
#Ed[i][j]=jth neighbor of i if j<degree(i)
#Ed[i][j]=0 if j>degree(i)
N=len(G.nodes())
ks=dict(G.degree())
k_max=max(ks.values())
Edge_list=np.zeros((N,k_max+1),dtype=int)
for n in G.nodes():
    Edge_list[n][0]=ks[n]
    for index,label in enumerate(G.neighbors(n)):
        Edge_list[n][index+1]=label+1
np.savetxt("networks/test_lattice.dat",Edge_list.T,delimiter=" ",fmt="%d") #Save so it is easily readable by fortran program 

```
Note -> a networkx Digraph object is a dictionary whose basic keys are:
```
G[source][target]["weight"] #source and target are node labels
```
Save network
```
nx.write_gpickle(G, "LFR_Benchmark_2.gpickle") #Save_network
```
Create/Save/load positions of nodes in canvas
```
#Create (G is a networkx network)
pos = nx.spring_layout(G,k=0.25)
#Save
pd.DataFrame.from_dict(data=pos, orient='index').to_csv('movie/dic_with_positions.csv', header=False)
#Load
pos=pd.read_csv('movie/dic_with_positions.csv',header=None)
pos_dic={a:np.array([pos[1].iloc[a],pos[2].iloc[a]]) for a in range(len(pos))}
pos=pos_dic
```
Plot network on map using basemap
```
from mpl_toolkits.basemap import Basemap as Basemap
#Plot filtered network on map:
#I have to have into account that:
# 1) The filtered network have holes in the sense that the labels are not consecutive integers
# 2) As the network IS directed, target nodes might or might not be sources
graph = nx.from_pandas_edgelist(Fd, source = "label_source", target = "label_target", #Load network from DataFrame
                                 edge_attr = True,create_using = nx.DiGraph())    #edge_attr=True so the rest of columns of the DataFrame are edge attribures
graph=nx.convert_node_labels_to_integers(G=graph, first_label=0, ordering='default', label_attribute=None) #relabel with consecutive integers
plt.figure(figsize = (10,9))
m= Basemap(projection='merc',llcrnrlon=-76,llcrnrlat=38,urcrnrlon=-70,
            urcrnrlat=42, lat_ts=0, resolution='h',suppress_ticks=True) #Select bbox and projection on map
sources=list(set(Fd["source"])) #set of names for sources
t=[a for a in set(Fd["target"]) if a not in sources] #There are targets that are not source!!-> set of names of targets that are not sources
nodes=sources+t #total number of nodes

long=[0 for _ in nodes] #List wiht longitudes of nodes
lat=[0 for _ in nodes] #list with latitudes of nodes
for edge in graph.edges():
    sE=edge[0] #label of source
    tE=edge[1] #label of target
    long[sE]=graph.edges[edge]["long_source"]
    lat[sE]=graph.edges[edge]["lat_source"]
    long[tE]=graph.edges[edge]["long_target"]
    lat[tE]=graph.edges[edge]["lat_target"]


mx,my=m(long,lat)
pos = {}

for count,elem in enumerate(nodes):
    pos[count] = (mx[count], my[count]) #get projection
    
nx.draw_networkx_nodes(G = graph, pos = pos, nodelist = graph.nodes(),node_color = 'r',
                       alpha = 0.1, node_size = 100) 
nx.draw_networkx_edges(G = graph, pos = pos, edge_color='g', alpha=0.3, arrows = False)

m.drawcountries(linewidth = 3)
m.drawstates(linewidth = 0.2)
m.drawcoastlines(linewidth=2)
plt.tight_layout()
plt.savefig("./NY_with_filter.png", format = "png", dpi = 300)
plt.show()

```
### Input/ Data from 'keyboard' <a class="anchor" id="chapter4"></a>
```
#How to run program: python program.py $value

#In  program.py...
import sys

y = float(sys.argv[1]) # y==$value
```

### Measure time <a class="anchor" id="chapter5"></a>
```
import time

start = time.time()
print("hello")
end = time.time()
print(end - start)
```
### Try/except <a class="anchor" id="chapter6"></a>
Execute {Try module}, if there is no error. if There is error in Try module, then Execute {Except module}.
"The classical Python mentality, though, is that it's easier to ask forgiveness than permission."
```
try:
    print(data["Total"][i])
except KeyError:
    print("Key error doesn't exist")
except:
    print("Something else went wrong") 
```
### zip - unzip (from touples to separate lists and viceversa) <a class="anchor" id="chapter7"></a>

https://www.geeksforgeeks.org/python-unzip-a-list-of-tuples/

List of tuples: https://www.programiz.com/python-programming/methods/built-in/zip
``` 
Let x=[x1,x2,x3,...], y=[y1,y2,y3,...]
Then list(zip(x,y))= [(x1,y1),(x2,y2),(x3,y3),...]   
```


### OPERADORES LÓGICOS <a class="anchor" id="chapter8"></a>
```
--> != "diferente que"  
--> >= "menor o igual"  
--> == "igual que"  
--> in --> x in lista, si x es un elemento de lista devuelve true  
```


### FILES <a class="anchor" id="chapter9"></a>
Save numpy array as columns
```
np.savetxt("filename.dat",np.c_[v1,v2]) #save two numpy arrays (v1,v2) as columns in file
```
```
--->abrir fichero: file_variable= open("file_name","mode")  
where mode can be: w-->write  
                   r-->read  
		   a-->append
                   wb--> write in binary mode  
-->escribir en fichero: file_variable.write( "text"+data)  
-->cerrar fichero: file_variable.close()  
-->escribir variables en columnas file_variable.write(str(variable_1)+" "+str(variable_2)+"\n") 
--> Better way https://stackoverflow.com/questions/9565426/saving-numpy-array-to-txt-file-row-wise
-->escribir variables en columnas file_variable.write("%i %i\n" % (x[i],y[i]))  
-->leer de fichero de datos y pasar a np array: np.loadtxt(file_variable,dtype=float)  
-->cerrar fichero: close mehod .--> file_variable.close() 
```
Read files of the type
a = 1  2  3
b = 2  2  2
creating lists of the type a= [1,2,3], b =[2,2,2]
```
import numpy as np
import re

# Initialize a dictionary to store variables as numpy arrays
variables = {}

# Open and read the file
with open('your_file.txt', 'r') as file:
    lines = file.readlines()

# Loop through each line and extract numbers
for line in lines:
    # Remove leading and trailing whitespaces
    line = line.strip()

    # Use regex to extract the variable name and numbers
    match = re.match(r'([\w\(\),:]+)\s*=\s*(.*)', line)
    if match:
        var_name = match.group(1)  # Variable name (e.g., C(t=0), a(1,:), etc.)
        values = match.group(2)    # The numbers after the '='
        
        # Extract the numbers using regex (supports scientific notation)
        value_list = re.findall(r'[-+]?\d*\.\d+|\d+\.\d+[eE][-+]?\d+', values)
        value_list = np.array([float(v) for v in value_list])  # Convert to NumPy array
        
        # Store the NumPy array in the dictionary with the variable name as the key
        variables[var_name] = value_list

# Display the parsed variables (name and array)
for key, value in variables.items():
    print(f"{key} = {value}")

```
### os <a class="anchor" id="chapter10"></a>
Check for files, if there is not file --> rerun program 
```
import os
if (os.path.isfile("PATH/FILENAME")==False):
	os.system("./exe.x {} {} {} {}".format(parameter1,parameter2,parameter3,parameter4)
```

### FUNCTIONS <a class="anchor" id="chapter11"></a>
Useful distributions functions
```
def G(x,mu,sig):
    PI=np.pi
    return np.exp(-(x - mu)*(x - mu) / (2.0 *sig*sig))/(np.sqrt(2.0*PI)*sig)

vG=np.vectorize(G)

def Pois(x,l):
    return x**l*np.exp(-l)/math.factorial(x)

vPois=np.vectorize(Pois)

def lgnorm(x,mu,sig):
    PI=np.pi
    return np.exp(-(np.log(x) - mu)*(np.log(x) - mu) / (2.0 *sig*sig))/(np.sqrt(2.0*PI)*sig*x)

vlgnorm=np.vectorize(G)
```
Rolling/moving average: f is a numpy array. Compute new array with simple moving average (average bin=N). https://en.wikipedia.org/wiki/Moving_average
```
Moving_mean=np.convolve(f, np.ones(N)/N, mode="same")
```

Comentarios:
```
--> se abren y cierran con tres comillas """  
```
lists as arguments:
```
---> lista como parámetro de función, con operador * (REVISAR)
ej: list=[thing1,thing2,...]---> def some_function (*list):
-->defino función de un único parámetro (que espera ser una cadena), si llamo a la función sin parámetro, param1 = "deafault"
    def my_func(param1='default'):
    """
    Docstring goes here.
    """
    print(param1)
    
my_func(hello)-->"hello"
my_func()-->default
```
### Numpy <a class="anchor" id="chapter12"></a>
Enumerate-like for 2D arrays:
```
for (x,y),value in np.ndenumerate(numpy array):
	...
```
Save in binary:
```
np.save("PATH/file_name.npy", Numpy_array, allow_pickle=True, fix_imports=True)

```
Load from binary:
```
Q=np.load("PATH/file_name.npy")
```
Save list as columns specifying format on txt file:
Format documentation: https://docs.python.org/3/library/string.html#format-specification-mini-language
```
np.savetxt("PATH/FILENAME",np.c_[list1,list2,list3,t],fmt='%.4f') # floating point with four decimals
```
Notes:
```
---> Array: Es parecido a una lista, pero las operaciones definidas sobre arrays son como las operaciones
sobre vectores Reales.
Sintaxis: a=np.array([1.0,2.0,3.0,4.0]). a[0] "=" 1.0
-->Creación de array con N primeros enteros como elementos c=np.arange( 4.0 ).
-->vector nulo--> np.zeros(3) "=" ([0.0, 0.0, 0.0]).
-->matriz nula--> np.zeros((i,j)) "=" matriz con i filas y j columnas, todos sus elementos son ceros.
-->v = np.linspace(a,b,c) "=" vector con c numeros reales, v(i)=a+b*i/c.
--> np.eye(D) "=" matriz identidad de dimension DxD.
--> np.random.rand(D) "=" vector D-dimensional, cada elemento es un numero aleatorio uniformemente distribuido en [0,1].
--> np.random.rand(i,j) "=" matriz con i filas y j columnas, cada elemento es un numero aleatorio uniformemente distribuido en [0,1].
--> np.random.randn(D) "=" vector D-dimensional, cada elemento es un numero aleatorio distribuido como una gaussiana centrada en cero.?desv.tipica?
--> np.random.randint(low,high,D) "=" vector D-dimensional cuyos elementos son numeros naturales aleatorios uniformemente distribuidos entre [low,high[.
--> v.reshape (i,j) "=" construye una matriz ixj usando como elementos los elementos del objeto v. v ha de tener ixj elementos.
-->v.max() "=" numero mayor de entre los numeros de v.// v.argmax "=" index location of v.max()
-->v.min() "=" numero menor de entre los numeros de v.
--> v.shape "=" tupla que informa sobre la forma de v.
--> v.dtype "=" informa sobre el tipo de dato que es cada elemento de v.
--> bool = v >5 "=" bool es un vector de booleanos, un elemento es True si dicho elemento en v es mayor que cinco. v[bool] "=" vector con todos los elementos > 5 de v.
--> v(sentencia_logica) "=" vector con todos los elementos de v que hacen True la sentencia_logica
--> UNIVERSAL ARRAY FUNCTIONS https://docs.scipy.org/doc/numpy/reference/ufuncs.html
```
### STRINGS <a class="anchor" id="chapter13"></a>
```
--> puedo pensar en un string como en una lista: x="Hola"--> x[0]=H
	#.split()
	--> genera lista a partir de string, las palabras separadas por espacios del string son los elementos de la lista.
	--> .split("caracter") busca "caracter" en el string y lo usa como separador para los elementos de la lista. EX:
		-->s = "user@domain"-->s.split(@) "=" ["user","domain"]
	#.format
	-->rellena huecos de un string con variables
	-->ejemplo 1: 
	>num = 12
	>name = 'Sam'
	>print('My number is: {}, and my name is: {}'.format(num,name))--->My number is: 12, and my name is: Sam
	--> ejemplo 2: MEJOR
	>num = 12
	>name = 'Sam'
	print('My number is: {one}, and my name is: {two}'.format(one=num,two=name))--->My number is: 12, and my name is: Sam
```
### DICTIONARY <a class="anchor" id="chapter14"></a>
Definition:
```
# Es una hash table.
d = {"key1":"value1",key2:123} #---> d["key1"] "=" string "value1", d["key2"] "=" number 123
```
Append to dictionary:
https://stackoverflow.com/questions/1024847/how-can-i-add-new-keys-to-a-dictionary
```
d = {'key': 'value'}
print(d)  # {'key': 'value'}

d['mynewkey'] = 'mynewvalue'

print(d)  # {'key': 'value', 'mynewkey': 'mynewvalue'}
```
Plot dictionary: https://stackoverflow.com/questions/37266341/plotting-a-python-dict-in-order-of-key-values/37266356
```
lists = sorted(d.items()) # sorted by key, return a list of tuples

x, y = zip(*lists) # unpack a list of pairs into two tuples
```
Iterate over dictionary (Python3):
https://stackoverflow.com/questions/5466618/too-many-values-to-unpack-iterating-over-a-dict-key-string-value-list
```
for field, possible_values in fields.items():
    print(field, possible_values)
```
Save dictionary on file using pandas:
```
pd.DataFrame.from_dict(data=dicname, orient='index').to_csv('file_name.csv', header=False)
```
### BOOLEANS <a class="anchor" id="chapter15"></a>
"True" and "False" !WITH CAPITALS T AND F!

### TUPLE <a class="anchor" id="chapter16"></a>
parecido a lista, su sintaxis es con () en vez de []. Sus elementos son inmutables, no puedo hacer tupla(0) = "nuevo_valor"

### SET <a class="anchor" id="chapter17"></a>
Definition and syntax:
```
--> sintaxis parecida a diccionario, set={1,2,3,4}, pero sin key:value.  
--> funcionan parecido a una lista, pero con elementos unicos, sus elementos no se repiten  
	-->ejemplo: s = {1,1,2,3,3} // print (s) "=" {1,2,3}  
-->lo puedo usar para quedarme con los elementos unicos de una lista:  
	--> s={[1,1,2,3,3]} // print (s) "=" {1,2,3}  
```
Append:
```
--> añado elementos al set con el método .add, que funciona igual que el método .append  
```

### LIST <a class="anchor" id="chapter18"></a>
List comprehension
```
--> forma abreviada de crear una lista, en vez de con el método .append  
	sea x= [1,2,3,4], queremos crar una nueva lista "out", tal que out[i]=x[i]**2 con i en range(1:5)  
		CON LIST COMPREHENSION  
		-->out = [item**2 for item in x]--> out = [1, 4, 9, 16]  
		CON MÉTODO .APPEND  
		-->out= [] #empty list  
		-->for num in x:  
			-->out.append(num)
```

### MAP <a class="anchor" id="chapter19"></a>
-->" it maps a function to every element of an iterable"
-->map(funcion,iterable)-->ejecuta la funcion sobre todos los elementos del iterable. si queremos que el resultado sea una lista,
hemos de usar list(map(...,...)).
-->Puede usarse Lambda expresion instead of function, ex:
	-->x=[1,2]
	-->list(map(lambda var: var*3,x)) "=" [3,6]

### FILTER <a class="anchor" id="chapter20"></a>
-->muy parecida a la funcion map, filter(func,iterable), la funcion ha de devolver un booleano. list(filter(func,iterable)) 
tiene como elementos a los elementos de iterable tales que han generado un valor "True" en func.

### IMPORT FUNCTION FROM A MODULE <a class="anchor" id="chapter21"></a> 

two different (and equivalent) methods:
--> from module import function // function(variables)
--> import module // module.function(variables)

### PANDAS DATAFRAME <a class="anchor" id="chapter22"></a>  
Binning data and groupby
```
cut_bins =np.arange(0,1.3,1.0/50) #Limits of the bins
cut_label = cut_bins[1::] #Label of the bins, could be a list of names
d['x1_bins'] = pd.cut(d['x1'], bins=cut_bins, labels = cut_label) #New column with binned data
q=d.groupby(["x1_bins"]).mean() # q is a different dataframe with cut_label as index. Rherefore, is a set, repetitions are replaced by the average value.
```
Groupby operations  
```
https://www.shanelynn.ie/summarising-aggregation-and-grouping-data-in-python-pandas/
```

Iterate over rows:  **WARNING!! does not preserv data type** 
```
for index, row in data.iterrows():
    cell=int(row["cell"])
```
Intersect two dataframes by column
```
df = pd.merge(data1, data2, how ='inner', on =['column']) 
```
Convert column to integer
```
dataW["column"] = dataW["column"].astype(int) #Converts "column" to integer
data=data.astype({"column1":type1,"column2":type2,...} #Converts diferent columns to different types
data=data.astype(type) #Converts the whole dataset
```
Proper way of changing value of dataframe,  getting rid of SettingWithCopyWarning  
https://stackoverflow.com/questions/20625582/how-to-deal-with-settingwithcopywarning-in-pandas
```
dataframe.loc[dataframe[condition]]=new_value(s)
```
Append column:
```
day=[today(data["date"][i]) for i in range(len(data))]
data["day"]=day
```
Print row:
```
print(df.iloc[[index]])
```
Filter out new data frame from previous one:
```
data1= data[data["ine_code"]==i]
```
Write data:
```
DATA.to_csv('data.dat', header=True, index=False, sep='\t', mode='a') --> vuelca data frame en fichero "data.dat"  
#mode ="a" --> append mode  
#mode = "w" --> write mode (overwrite) 
```
Read data:
```
data= pd.read_csv("covid19-provincias-spain_consolidated.csv")
data= pd.read_csv("Trajectories/t1.dat",delimiter=" ",skipinitialspace=True) #Read data from Fortran format (*,*)
```
Print columns:
```
for col in data.columns: 
    print(col) 
```
### PDB DEBUGGER // DEPURADO // DEPURATE <a class="anchor" id="chapter23"></a>
```
-->import pdb
--> python3 -m pdb myscript.py --> invoke pdb from shell to debugg "myscript.py"
--> import pdb; pdb.set_trace() "="  to break into the debugger from a running program
--> Commands:
	step (s) --> execute current line
	continue (c) -->  Continue execution till next breakpoint
```
### MATPLOTLIB <a class="anchor" id="chapter24"></a>
Remove space between multiplots
```
fig, (ax1,ax2,ax3) = plt.subplots(n_rows, n_columns,sharex=True,figsize=(2,3.6)) #sharey=True
fig.tight_layout() ! This remobes space between rows in this example
```
Heatmap using pcolormesh and adding contours
```
x_mesh, y_mesh = np.meshgrid(xs, ys)
z_mesh = f(x_mesh, y_mesh)
heatmap = plt.pcolormesh(x_mesh, y_mesh, z_mesh, shading='auto', cmap='coolwarm')
contours = plt.contour(x_mesh, y_mesh, z_mesh, levels=4, colors='black')
plt.clabel(contours, inline=True, fontsize=10)
cbar = plt.colorbar(heatmap,ticks=list_with_ticks)
cbar.set_label(cbar_name)
```
Set number of ticks for labels with locator_params:https://matplotlib.org/stable/api/_as_gen/matplotlib.axes.Axes.locator_params.html
```
plt.locator_params(axis='both', nbins=5,tight=True) #axis ="y" and axis ="x" are also available
```
Custom color maps:
```
color1 = (211/255, 211/255, 211/255)
color2 = (70/255, 130/255, 180/255)
colors = [color1, color2]  # RGB for white and steelblue
n_bins = 100  # Number of bins for the colormap
custom_cmap = LinearSegmentedColormap.from_list('steelblue_cmap', colors, N=n_bins)
plt.scatter(x_data,y_data,c=color_data,s=s,cmap=custom_cmap)
```
Plot dates in x axis:
```
date_time = pd.to_datetime(d["temporal_data"])
plt.plot(date_time,y_data)
```
Proper setting for errorbar: No lines connecting data and errorbar centered on point
```
color = "darkblue"
plt.errorbar(xdata,ydata,yerr=y_errors,capsize=10,fmt="none",color=color,lw=1)
plt.scatter(xdata,ydata,color=color)
```
Nat. Com. review matplotlib options (By Mattia)
```
def Plot_bonito(xlabel=r"$name_x$",ylabel=r"$name_y$"):
	plt.rcParams.update({'font.size':12})
	plt.figure(figsize=(8,6))
	plt.rcParams['axes.linewidth']=2 #marco doble
	plt.tick_params(labelsize=24)
	plt.xlabel(xlabel,fontsize=30)
	plt.ylabel(ylabel,fontsize=30)
	plt.xticks(fontsize=20)
	plt.yticks(fontsize=20)
	plt.legend(fontsize=15)
plt.savefig("Imax_Nat_review.pdf", bbox_inches='tight')
```
Add coloured rectangle
```
import matplotlib.patches as patches

# Create a Rectangle patch
rect = patches.Rectangle((x0, y0), dx, dy, linewidth=1, edgecolor='r', facecolor='grey',alpha=0.3)
ax = plt.gca()
# Add the patch to the Axes
ax.add_patch(rect)
```
Vector fields with quiver
https://krajit.github.io/sympy/vectorFields/vectorFields.html
https://matplotlib.org/stable/gallery/images_contours_and_fields/quiver_demo.html#sphx-glr-gallery-images-contours-and-fields-quiver-demo-py
```
x,y = np.meshgrid(np.linspace(0.0,1.5,20),np.linspace(0.0,2.5,20))
n=4
S=0.5
a=1.2
u = a*x**n/(S**n+x**n)+S**n/(S**n+y**n)-x
v = a*y**n/(S**n+y**n)+S**n/(S**n+x**n)-y
M = np.hypot(u, v) #Color
plt.quiver(x,y,u,v,M,alpha=0.5,width=0.005,
               scale=1 / 0.05)
```
Add legend item manually
https://stackoverflow.com/questions/39500265/manually-add-legend-items-python-matplotlib
```
import matplotlib.patches as patches
red_patch = patches.Patch(color='red', label="red")
plt.legend(handles=[red_patch])
```
3D Scatter plot
```
from mpl_toolkits.mplot3d import Axes3D
fig = plt.figure()
ax = Axes3D(fig)
ax.scatter(x,y,z,s=markersize)
plt.show()
```
Rotate ylabel
```
h = plt.ylabel('y')
h.set_rotation(0)
```
Add text to scatter plot:
```
city=["name1","name2",...,"namen"]
for i, txt in enumerate(city):
    plt.annotate(txt, (x[i], y[i]),fontsize=20)
```
Add xtics with name:
```
plt.xticks([1,8,28,46,41,52], ["1","B","M","V","S","52"])  
```
LATEX options-->https://matplotlib.org/3.3.1/tutorials/text/usetex.html  

FUNCTIONAL METHOD:
```
	plt.plot(x,y) (x and y are numpy arrays)
	plt.xlabel('X Axis Title Here')
	plt.ylabel('Y Axis Title Here')
	plt.title('String Title Here')
	plt.show()
	-->multiplot:
	# plt.subplot(nrows, ncols, plot_number)
	plt.subplot(1,2,1)
	plt.plot(x, y, 'r--') # More on color options later
	plt.subplot(1,2,2)
	plt.plot(y, x, 'g*-');
```
-OBJECT ORIENTED METHOD
```
	# Creates blank canvas
	fig = plt.figure()

	axes1 = fig.add_axes([0.1, 0.1, 0.8, 0.8]) # [% from the left, % from the bottom,% of the canvas (lienzo) size in width, high] main axes
	axes2 = fig.add_axes([0.2, 0.5, 0.4, 0.3]) # inset axes, cada .add_axes define una caja, los numeros van del 0 al 1, y multiplicados por 100 son el porcentaje.

	# Larger Figure Axes 1
	axes1.plot(x, y, 'b')
	axes1.set_xlabel('X_label_axes2')
	axes1.set_ylabel('Y_label_axes2')
	axes1.set_title('Axes 2 Title')

	# Insert Figure Axes 2
	axes2.plot(y, x, 'r')
	axes2.set_xlabel('X_label_axes2')
	axes2.set_ylabel('Y_label_axes2')
	axes2.set_title('Axes 2 Title');
```
 Saving on a file:
 ```
	Matplotlib can generate high-quality output in a number formats, including PNG, JPG, EPS, SVG, PGF and PDF
	-->To save a figure to a file we can use the savefig method in the Figure class: fig.savefig("filename.png")
	-->Here we can also optionally specify the DPI and choose between different output formats: fig.savefig("filename.png", dpi=200)
--> Deal with overlapping
	fig.tight_layout() or plt.tight_layout() method, which automatically adjusts the positions of the axes on the figure canvas so that there is no overlapping content:
--> Leyend:
	ax.plot(x, x**2, label="x**2")
	ax.plot(x, x**3, label="x**3")
	ax.legend()
	ax.legend(loc=1) # upper right corner
	ax.legend(loc=2) # upper left corner
	ax.legend(loc=3) # lower left corner
	ax.legend(loc=4) # lower right corner
	ax.legend(loc=0) # let matplotlib decide the optimal location
	--> DOCUMENTATION http://matplotlib.org/users/legend_guide.html#legend-location
-->alpha parameter-->transparence of lines
	ax.plot(x,x+1,alpha=0.1)-->alpha goes from 0 to 1
-->changing sizes
plt.subplot(1,2,1)
plt.plot(x,y,"r--")
-->fig.tight_layout()--> separa graficas para que no se superpongan
--> EXAMPLES
	fig, axes = plt.subplots(1, 2, figsize=(10,4)) --> 10x4 inches
```
### Fits <a class="anchor" id="chapter25"></a>
Tutorial on fits using scikit-learn: https://realpython.com/linear-regression-in-python/#python-packages-for-linear-regression
```
model = LinearRegression(fit_intercept=False).fit(xs.reshape((-1, 1)), ys)
R2 = model.score(xs.reshape((-1, 1)), ys) #coefficient of determination R^2, R^2 = 1 is the perfect fit, if slower->worse
intercept = model.intercept_
slope = model.coef_
plt.plot(xs,slope*xs+intercept)
```
### Efficiency <a class="anchor" id="chapter26"></a>
In general, it is more efficient to iterate over the "inner" dimension first (in this case, j), followed by the "outer" dimension (in this case, i). The reason is that numpy arrays are stored in memory in a row-major order. By iterating over the inner dimension first, you access contiguous memory locations, which can take better advantage of the CPU cache and improve performance.
```
for i in list1:
	for j in list2:
		m[j][i]=something #inner first!
``
```
### Stochastic processes <a class="anchor" id="chapter27"></a>
Learn diffusion function using quadratic variation
```
def learn_dif(xs,ts):
    """
    learn diffusion function for time series {ts,xs} using quadratic variation estimator.
    """
    dt = ts[1]-ts[0]
    xmax = max(xs)
    xmin = min(xs)
    N = 100
    dx = (xmax-xmin)/N
    Dn = np.zeros(N+1)
    count = np.zeros(N+1)
    for ww,x in enumerate(xs[:-1:]):
        n = int((x-xmin)/dx)
        Dn[n] += (xs[ww+1]-x)**2.0
        count[n] += 1
    Dn = sqrt(Dn/count/dt)
    x_bins = np.arange(N+1)*dx+xmin
    threshold = 10
    mask = count >= threshold
    count = count[mask]
    Dn = Dn[mask]
    x_bins = x_bins[mask]
    return x_bins,Dn,count
```


					
