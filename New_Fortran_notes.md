### References
Brainerd, W. S. (2009). Guide to Fortran 2003 programming (pp. 1-326). Berlin: Springer.  

### Modules
Example:
```
module declarations_module

  implicit none
  double precision, public :: b,u,dt  #public variables can be used outside module
  integer*4, public :: N,itmax,I0,tmax


contains

  subroutine assingments()
    u=1.0d0 !recovery rate
    b=2.0d0*u !infection rate
    I0=1 !Initial condition
    N=300 !Number of individuals
    tmax=10 !final time for simulation
    dt=1.0/((b+u)*N) !Integration step
    itmax=int(tmax/dt) !Final iteration
  end subroutine assingments

end module declarations_module
```
Use statement:
```
program main
use declarations_module
implicit none
call assingments()

...
end main
```
### Forall is restricted 

https://stackoverflow.com/questions/8602596/fortran-forall-restrictions  
https://stackoverflow.com/questions/4122099/do-fortran-95-constructs-such-as-where-forall-and-spread-generally-result-in-fa/4141572#4141572
```
#Create Arrays checking condition
FORALL (i=1:n,j=1:n,i/=j) A(i,j) = REAL(i+j)
```
### Files read and write
FORM=Unformatted: save memory and is faster to read, **is not portable**. Can be used with stream,sequential and direct access
```
#Write in sequential unformatted
open(unit=1001, file="leeme.dat", iostat=ios, status="unknown", action="write", &
  access="sequential",form="unformatted")
  if ( ios /= 0 ) stop "Error opening file "
  write(1001) x+0.1d0,x+0.2d0
  write(1001) x+0.3d0,x+0.4d0
 close(1001)
 
 #Read in sequential unformatted
 open(unit=1001, file="one_line.dat", iostat=ios, status="unknown", action="read", &
   access="sequential",form="unformatted") !leeme.dat
  if ( ios /= 0 ) stop "Error opening file "
  do while ( 1==1 ) !Read until end of time
    read(1001,end=102) a,b,c,y !end=102 is like goto !F77 standard!!!!
    print *, a,b,c,y
  end do
 102 close(1001)
```
