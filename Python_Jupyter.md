### Jupyter notebook
```
%matplotlib notebook
import sys
from scipy.optimize import curve_fit
import numpy as np
import networkx as nx
import matplotlib.pyplot as plt
import time
import pandas as pd
from mpl_toolkits.mplot3d import Axes3D  # noqa: F401 unused import
from matplotlib import cm
from matplotlib.ticker import LinearLocator, FormatStrFormatter
#%matplotlib inline


```
### Networx
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
### Data from 'keyboard'
```
#How to run program: python program.py $value

#In  program.py...
import sys

y = float(sys.argv[1]) # y==$value
```

### Measure time
```
import time

start = time.time()
print("hello")
end = time.time()
print(end - start)
```
### Try/except
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
### zip - unzip (from touples to separate lists and viceversa)

https://www.geeksforgeeks.org/python-unzip-a-list-of-tuples/

### OPERADORES LÓGICOS
```
--> != "diferente que"  
--> >= "menor o igual"  
--> == "igual que"  
--> in --> x in lista, si x es un elemento de lista devuelve true  
```

### LISTAS
``` 
--> crear lista de tuplas con zip: sea x=[x1,x2,x3,...], y=[y1,y2,y3,...]--> list(zip(x,y))= [(x1,y1),(x2,y2),(x3,y3),...]   
https://www.programiz.com/python-programming/methods/built-in/zip
```

### FICHEROS
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

### FUNCIONES
```
Comentarios:
--> se abren y cierran con tres comillas """  

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
### MODULO numpy
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
### STRINGS
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
### DICCIONARIOS
```
# Es una hash table.
d = {"key1":"value1",key2:123} #---> d["key1"] "=" string "value1", d["key2"] "=" number 123
```
Save dictionary on file using pandas:
```
pd.DataFrame.from_dict(data=dicname, orient='index').to_csv('file_name.csv', header=False)
```
### BOOLEANS
--> "True" and "False" !WITH CAPITALS T AND F!

### TUPLA
--> parecido a lista, su sintaxis es con () en vez de [], sus elementos son inmutables, no puedo hacer tupla(0) = "nuevo_valor"

### SET
--> sintaxis parecida a diccionario, set={1,2,3,4}, pero sin key:value.
--> funcionan parecido a una lista, pero con elementos unicos, sus elementos no se repiten
	-->ejemplo: s = {1,1,2,3,3} // print (s) "=" {1,2,3}
-->lo puedo usar para quedarme con los elementos unicos de una lista:
	--> s={[1,1,2,3,3]} // print (s) "=" {1,2,3}
--> añado elementos al set con el método .add, que funciona igual que el método .append

### LIST COMPREHENSION
--> forma abreviada de crear una lista, en vez de con el método .append
	sea x= [1,2,3,4], queremos crar una nueva lista "out", tal que out[i]=x[i]**2 con i en range(1:5)
		CON LIST COMPREHENSION
		-->out = [item**2 for item in x]--> out = [1, 4, 9, 16]
		CON MÉTODO .APPEND
		-->out= [] #empty list
		-->for num in x:
			-->out.append(num)

### MAP
-->" it maps a function to every element of an iterable"
-->map(funcion,iterable)-->ejecuta la funcion sobre todos los elementos del iterable. si queremos que el resultado sea una lista,
hemos de usar list(map(...,...)).
-->Puede usarse Lambda expresion instead of function, ex:
	-->x=[1,2]
	-->list(map(lambda var: var*3,x)) "=" [3,6]

### FILTER
-->muy parecida a la funcion map, filter(func,iterable), la funcion ha de devolver un booleano. list(filter(func,iterable)) 
tiene como elementos a los elementos de iterable tales que han generado un valor "True" en func.

### IMPORT FUNCTION FROM A MODULE  

two different (and equivalent) methods:
--> from module import function // function(variables)
--> import module // module.function(variables)

### PANDAS DATAFRAME  
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
### PDB DEBUGGER // DEPURADO // DEPURATE
```
-->import pdb
--> python3 -m pdb myscript.py --> invoke pdb from shell to debugg "myscript.py"
--> import pdb; pdb.set_trace() "="  to break into the debugger from a running program
--> Commands:
	step (s) --> execute current line
	continue (c) -->  Continue execution till next breakpoint
```
# MATPLOTLIB
Nat. Com. review matplotlib options (By Mattia)
```
plt.rcParams.update({'font.size':12})
plt.figure(figsize=(8,6))
plt.rcParams['axes.linewidth']=2 #marco doble
plt.xlabel(r"$X_s$ value",fontsize=30)
plt.ylabel("Frecuency",fontsize=30)
plt.legend(fontsize=15)
plt.savefig("Imax_Nat_review.pdf", bbox_inches='tight')
```
Add text to scatter plot:
```
city=["name1","name2",...,"namen"]
for i, txt in enumerate(city):
    plt.annotate(txt, (x[i], y[i]))
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




					
