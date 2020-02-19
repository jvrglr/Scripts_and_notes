# Merge pdf files
```
pdftk Portada.pdf TFM_cristobal_structure.pdf cat output merge.pdf

```

# Kill process using PID from top

```
kill -9 PID

```
or press k and enter PID in top mode

# create .txt file from command line
```
echo 'Hello, world.' >foo.txt

```

# Remove folder filled with files

```
rm -rf folder

```

# Save compilation errors in file

```
gfortran -g  program.f -o exe > log.txt 2>&1

```

# Give exe permisson to file

```
chmod +x fichero_1 

```

# Run on background saving terminal outcome in file

```
nohup time ./exe_phase > Output_phase.out &

```

# Scp example: copy from local to remote

```
scp /home/javi/Desktop/file_name  javieraguilar@ifisc.uib-csic.es:/home/javieraguilar/Desktop

```
