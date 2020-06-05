# VIM commands
search and replace: Find each occurrence of 'foo' (in all lines), and replace it with 'bar'.  
https://vim.fandom.com/wiki/Search_and_replace
```
:%s/foo/bar/g
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
