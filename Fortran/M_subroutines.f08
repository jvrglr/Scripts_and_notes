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
  
  subroutine search_list_binary_algoritm(list,position,p)
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

  end subroutine search_list_binary_algoritm

end module subroutines
