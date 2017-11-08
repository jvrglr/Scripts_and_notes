set xlabel "Canal"
set ylabel "Energie (KeV)"
#set logscale x
#Cuadrícula
#set grid   
#Posición de la leyenda           
set key lmargin
#set xrange [530:560]
#set term postscript eps enhanced color 14
#set output "Calibrado.eps"
#fit f(x) "datos.dat" u 1:2 via a,b 
plot "calibrado_energia_Am241.dat" with points pointtype 7 title "Am241"
#pause -1


