module Subroutines

  !Module with public subroutines.
  !Depends on declarations_module and functions.

  use declarations_module
  use functions

contains

  subroutine read_xF_tf()
    !Example of subroutine, read data file
    implicit none
    integer*4 :: ios,i,dum,datapoints
    double precision :: dummy

    open(unit=1001, file="data/F_Target_test3.dat", iostat=ios, status="old", action="read")
    if ( ios /= 0 ) stop "Error opening file "
    do i = 1, datapoints, 1
      read(1001,*) dummy,dummy,dummy,dum
    end do


  end subroutine read_xF_tf
  
  subroutine search_list_binary_algorithm(list,position,p)
    !Rafle event:
    !Given a list of probabilities called "list" such that sum(list)=1 and a probability p.
    !Look for "position" such that C(position)>=p and C(j)<p for all j in [1,position[.
    !Where C is the cumulative of list: C(i)=list(1)+list(2)+...+list(i)-
    !REFERENCE:Brainerd, W. S. (2015). Guide to Fortran 2008 programming (p. 141). Berlin: Springer.

    implicit none
    double precision, dimension(:), intent (in) :: list
    double precision, intent (in) :: p
    integer*4, intent(out) :: position
    double precision, dimension(size(list)) :: C
    integer*4 ii,N,first,last,half

    N=size(list) !It would be cool to define this as a parameter (constant), I don't know how...
    C(1)=list(1)
    do ii = 2, N, 1 !Compute cumulative of list
      c(ii)=C(ii-1)+list(ii)
    end do

    first=1;last=N
    do while ( first.ne.last )
      half=(first+last)/2
      if ( p>C(half) ) then
        first=half+1
      else
        last=half
      end if
    end do

    position=first

  end subroutine search_list_binary_algorithm

  subroutine float_to_string(a, n, result)
    !Convert float number a to string with format int(a)//"d"//dec(a).
    !E.g. 0.00543--> "0d00543"
    !For dec(a) select first n decimals
    !If number of digits in dec(a)>n then add zeros to the left
    double precision, intent(in) :: a
    integer, intent(in) :: n
    character(len=*), intent(out) :: result
    character(len=n) :: dumc
    integer :: digit,zeros

  
    integer :: int_part
    double precision :: dec_part
  
    ! Get the integer and decimal parts
    int_part = int(a)
    dec_part = a - int_part

    ! Convert the decimal part to a string with n digits
    zeros=0
    digit=int(dec_part*10**(zeros+1))
    do while ((digit==0).and.(zeros<n))
      zeros=zeros+1
      digit=int(dec_part*10**(zeros+1))
    enddo
    dumc=repeat("0",zeros)//trim(str(int(dec_part*10**(n)))) 


    result=trim(str(int_part))//"d"//trim(dumc)

  
  end subroutine float_to_string

end module subroutines
