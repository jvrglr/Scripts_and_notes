module Subroutines

  !Module with public subroutines.
  !Depends on declarations_module and functions.

  use declarations_module
  use functions

contains

  subroutine read_xF_tf()
    !Example of subroutine, read data file
    implicit none
    integer*4 :: ios,i,dum
    double precision :: dummy

    open(unit=1001, file="data/F_Target_test3.dat", iostat=ios, status="old", action="read")
    if ( ios /= 0 ) stop "Error opening file "
    do i = 1, datapoints, 1
      read(1001,*) tF(i),dummy,xF(i),dum
    end do


  end subroutine read_xF_tf

end module subroutines
