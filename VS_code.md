# To create/modify user snipetts
1. ctrl + mayus + p
2. type "Snippets: Configure User Snipetts"
3. Look for "programming_language.json"

#Python.json
```
// Place your snippets for python here. Each snippet is defined under a snippet name and has a prefix, body and 
	// description. The prefix is what is used to trigger the snippet and the body will be expanded and inserted. Possible variables are:
	// $1, $2 for tab stops, $0 for the final cursor position, and ${1:label}, ${2:another} for placeholders. Placeholders with the 
	// same ids are connected.
	// Example:
	// "Print to console": {
	// 	"prefix": "log",
	// 	"body": [
	// 		"console.log('$1');",
	// 		"$2"
	// 	],
	// 	"description": "Log output to console"
	// }
	"": {
		"prefix": "start_python",
		"body": [
			"# %%",
			"%reset", 
			"import sys",
			"import matplotlib",
			"from scipy.optimize import curve_fit",
			"import numpy as np",
			"import networkx as nx",
			"import matplotlib.pyplot as plt",
			"import time",
			"import math",
			"import pandas as pd",
			"from mpl_toolkits.mplot3d import Axes3D  # noqa: F401 unused import",
			"from matplotlib import cm",
			"from matplotlib.ticker import LinearLocator, FormatStrFormatter",
			"import matplotlib.patches as patches",
			"matplotlib.rcParams.update({'figure.autolayout': True})",
			"matplotlib.rcParams['mathtext.fontset'] = 'custom'",
			"matplotlib.rcParams['mathtext.rm'] = 'Bitstream Vera Sans'",
			"matplotlib.rcParams['mathtext.it'] = 'Bitstream Vera Sans:italic'",
			"matplotlib.rcParams['mathtext.bf'] = 'Bitstream Vera Sans:bold'",
			"matplotlib.rcParams['mathtext.fontset'] = 'cm'",
			"matplotlib.rcParams['font.family'] = 'STIXGeneral'",
			"matplotlib.rcParams.update({'font.size':12})",
			"matplotlib.rcParams['axes.linewidth']=2 #Grosor del marco (doble del standard)",
			"def Plot_bonito(xlabel=r\" $ x$\",ylabel=r\"$ y$\",label_font_size=15,ticks_size=12,y_size=2.4,x_size=3.2):",
			"	plt.figure(figsize=(x_size,y_size))",
			"	plt.tick_params(labelsize=24)",
			"	plt.xlabel(xlabel,fontsize=label_font_size)",
			"	plt.ylabel(ylabel,fontsize=label_font_size)",
			"	plt.xticks(fontsize=ticks_size)",
			"	plt.yticks(fontsize=ticks_size)",
			"def axis_bonito(ax,xlabel=r\" $ x$\",ylabel=r\"$ y$\",label_font_size=12,ticks_size=10):",
			"	ax.set_xlabel(xlabel,fontsize=label_font_size)",
			"	ax.set_ylabel(ylabel,fontsize=label_font_size)",
			"	ax.tick_params(axis=\"x\", labelsize=ticks_size)",
			"	ax.tick_params(axis=\"y\", labelsize=ticks_size)",
			"	# For two column figure that fits in one column of a two-columns paper:",
			" 		#fig, (ax1,ax2) = plt.subplots(1, 2,figsize=(4.2,1.8))",
		],
		"description": ""
	  }
	  
}
```
