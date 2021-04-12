module functions
  !Module with public functions.
  !Depends on declarations_module.
  use declarations_module
  implicit none
  
  double precision, public, parameter :: pi = &
   3.1415926535897932384626433832795028841972

  double precision, private :: f
contains

  character(len=30) function str(k) !fUNCTION
    implicit none
!   "Convert an integer to string."
    integer, intent(in) :: k
    write (str, *) k !write to a string
    str = adjustl(str)
  end function str

  function dble_mean(x) result(a)
    !compute average of double precision vector
    implicit none
    double precision :: a
    double precision, dimension (:), intent(in) :: x
    a=sum(x)/size(x)
  end function dble_mean

  function dble_var(x) result(a)
    !compute variance of double precision vector
    implicit none
    double precision :: a
    double precision, dimension (:), intent(in) :: x
    double precision, dimension (:), allocatable :: dummy
    integer*4 :: i, len

    len=size(x)
    allocate(dummy(len))

    dummy=x-dble_mean(x)
    a=sum(dummy*dummy)/len
    deallocate(dummy)
  end function dble_var

  function dble_err(x) result(a)
    !compute standard error of double precision vector
    implicit none
    double precision :: a
    double precision, dimension (:), intent(in) :: x
    a=sqrt(dble_var(x)/size(x))
  end function dble_err
  
    double precision function G(x,mu,sig)
    !Gaussian function
    implicit none
    double precision, intent (in):: x,mu,sig
    G=(1.0/(sqrt(2.0*pi)*sig))*exp(-(x - mu)*(x - mu) / (2.0d0 *sig*sig))
  end function G

end module functions
