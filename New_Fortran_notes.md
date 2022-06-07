### References
Brainerd, W. S. (2009). Guide to Fortran 2003 programming (pp. 1-326). Berlin: Springer.  

### Array
Assumed shape: Array declarations in modules, functions,...  
The user has to make explicit the lowerbound of the array if it is different from 1.  
```
subroutine test()
implicit none
double precision, dimension(lowerbound:), intent(inout) :: array1


subroutine test
```
Define array from keyboard:
```
double precision :: x(2)=(/1.0d0,5.0d0/)
```

### Count
Counts the number of occurrences of condition on an array.
https://gcc.gnu.org/onlinedocs/gfortran/COUNT.html  
  
Count for non-zero values in array:  
```
print *, count(array/=0)
```

### Measure time
Example from: https://gcc.gnu.org/onlinedocs/gfortran/CPU_005fTIME.html
```
program test_cpu_time
    real :: start, finish
    call cpu_time(start)
        ! put code to test here
    call cpu_time(finish)
    print '("Time = ",f6.3," seconds.")',finish-start
end program test_cpu_time
```
### Tips
1. There are reserved units!! Use big numbers (>100) for the units  
https://stackoverflow.com/questions/42348449/fortran-not-writing-to-screen-while-file-is-open  

2. Allocatable memory depends on machine!

3. carefull with type conversion! let i, n be integers,  ```i**n ``` is different from ```dble(i)**n``` !!!!

4. Integer division truncates by deafault: 5/2 generates 2 as outcome. nint(dble(5)/2) generates 3 as outcome. 

5. WORK ALWAYS IN DOUBLE PRECISION--> int*8!! if a,b are positive numbers of integer type and a*b>max(integer type) then the output a*b is NEGATIVE!!! TRY TO AVOID THIS SITUATION. ESTIMATE RANGE OF VARIABLES!

6. FORTRAN uses column-major ordering! Meaning that first index runs quickier than the second (and so on with the third and fourth)!! So wrihte do loops like this: 
``` 
do i = 1, N, 1
    do j = 1, N, 1
      M(j,i)=...
    end do
  end do
``` 
This loop runs, at least, twice faster than the same loop evaluating M(i,j),

### From number to string and vice versa
https://coderwall.com/p/dqwzea/str2num-and-num2str-functions-in-fortran

### Optional arguments
Example:
```
  subroutine example(nonopt,opt)
    implicit none
    integer*4, intent (out) :: nonopt
    character (len=*),optional,intent(in) :: opt ! optional character argument with length=* (already defined in main)
   
      if ( present(opt) ) then
         !Do something if opt was introduced
       else
         !Do a different thing if opt was not introduced
      end if
  end subroutine example
```

### Rename / change alias of functions with pointers
Example extracted from: https://stackoverflow.com/questions/8612466/how-to-alias-a-function-name-in-fortran/8612679
```
module ExampleFuncs

   implicit none

contains

function f1 (x)
  real :: f1
  real, intent (in) :: x

  f1 = 2.0 * x

  return
end function f1


function f2 (x)
   real :: f2
   real, intent (in) :: x

   f2 = 3.0 * x**2

   return
end function f2

end module ExampleFuncs


program test_func_ptrs

    use ExampleFuncs
    implicit none

   abstract interface
      function func (z)
         real :: func
         real, intent (in) :: z
      end function func
   end interface

   procedure (func), pointer :: f_ptr => null ()

   real :: input

   write (*, '( / "Input test value: ")', advance="no" )
   read (*, *) input

   if ( input < 0 ) then
      f_ptr => f1
   else
      f_ptr => f2
   end if

   write (*, '(/ "evaluate function: ", ES14.4 )' )  f_ptr (input)

   stop

end program test_func_ptrs

```

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
Read from bash script
```
b=2
echo $b | ./program.x
....
program program.x
...
read (*,*) b
end program
```
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
