* Folder with modules for a general Fortran 2008 program.

* Compile with gfortran:
Checking arrays
```
gfortran -fbounds-check  M_declarations.f08 M_functions.f08 M_subroutines.f08 main.f95 -o exe.x
```
With optimization
```
gfortran -Ofast   M_declarations.f08 M_functions.f08 M_subroutines.f08 main_SIS.f95 -o exe.x
```
