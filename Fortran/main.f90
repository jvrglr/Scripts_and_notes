program main_program
  !Main program, depends on the rest of modules (declarations_module, functions and subroutines))
  use declarations_module
  use functions
  use subroutines
  implicit none

  call assingments()
  !Print variables from assignments()

  !Do stuff

  !Deallocate and close files
101 end program main_program
