# Table of Contents
1. [Check](#example)

## Append labeled list of files
```
cat mini_file_{i0..if}.txt >> big_file.txt
```
## Check if there is not file
```
if [[ ! -f "filename" ]] # ! is logical not. -f "filename" = true if filename is in folder
		then
		    do things
		fi #End of if statement
```
## [example]Arithmetic operations on float variables. bc
Output is integer
```
var1=`echo "($var2*10000)/1" | bc` #The operations have into account float nature of var2

```
Output is float
```
var1=`echo "($var2*10000)/1" | bc -l` 
```

Output is float with two decimals
```
var1=`echo "scale=2;($var2*10000)/1" | bc -l` 
```
## #!/bin/bash  

Rubén:"Cuando lo ejecutas en la terminal, por defecto estás usando bash para interpretar tu script. pero al lanzarlo con run, no hay ningun interprete por defecto, así que el sistema busca algún tipo de indicación en tu script sobre que interprete debe utilizar...  

Para eso sirve la primera línea que siempre hay que poner en un script bash:  

#!/bin/bash  "

## Videos with FFmpeg  

Documentation: https://www.ffmpeg.org/ffmpeg-formats.html#Demuxers  

Formatting index and example:
%03d indicate:index with 3 digits padded by zeros--> 001,002,...,010,...,125,...
```
ffmpeg -r 14 -i Images_sin_pelos/%03d.picture.png -c:v libx264 -r 30 -pix_fmt yuv420p -vf scale=1600:800 out_sin.mp4

```
## delete by type
```
find . -type f -name '*.dat' -delete
```
## VIM commands
copy, paste, cut
https://vim.fandom.com/wiki/Copy,_cut_and_paste
```
y-> copy
p-> paste
```
search and replace: Find each occurrence of 'foo' (in all lines), and replace it with 'bar'.  
https://vim.fandom.com/wiki/Search_and_replace
```
:%s/foo/bar/g
```
search: Fin occurrence of "word". Go over every occurence pressing "n" on the keyboard
```
/word
```
## Create n new folders
Example: n=52. Folders are named Trajectories1, Trajectories2,...,Trajectories52
```
mkdir Trajectories{1..52}
```
## Add line at first line of file
```
for i in {1..2}; do sed -i -e '1iHello, world\' a${i}.csv;done
```
## replace line at Nth line of file
https://stackoverflow.com/questions/11145270/how-to-replace-an-entire-line-in-a-text-file-by-line-number
```
sed -i 'Ns/.*/New line  /' file.dat
```
## Rename file from terminal

```
mv oldname.format newname.format
```

## Merge pdf files
```
pdftk Portada.pdf TFM_cristobal_structure.pdf cat output merge.pdf

```

## Kill process using PID from top

```
kill -9 PID

```
or press k and enter PID in top mode

## create .txt file from command line
```
echo 'Hello, world.' >foo.txt

```

## Remove folder filled with files

```
rm -rf folder

```

## Save compilation errors in file

```
gfortran -g  program.f -o exe > log.txt 2>&1

```

## Give exe permisson to file

```
chmod +x fichero_1 

```

## Run on background saving terminal outcome in file

```
nohup time ./exe_phase > Output_phase.out &

```

## Scp example: copy from local to remote

```
scp /home/javi/Desktop/file_name  javieraguilar@ifisc.uib-csic.es:/home/javieraguilar/Desktop 

```
## Scp example: from remote to local, copy all
```
scp -r javieraguilar@ifisc.uib-csic.es:/data/social/mobility_map_2020/networks_model /home/javi/Desktop/Corona/Cities/data
```
