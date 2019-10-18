	!! There are reserved units!! Use big numbers (>100) for the units
	!!https://stackoverflow.com/questions/42348449/fortran-not-writing-to-screen-while-file-is-open
	
	!!NUMBERS ON STRINGS+FILE NAMES
	!!----------------------------------------------------------------------
	PROGRAM SOMETHIN
	character(len=30) str
	open(unit=6, file="zzinfo_"
     c //trim(str(int(dum)))//".dat", status="unknown")
     	!DO THINGS
	CLOSE(6)
	END PROGRAM SOMETHIN
	
      character(len=30) function str(k) !fUNCTION
      implicit none
      !   "Convert an integer to string."
          integer, intent(in) :: k
          write (str, *) k !write to a string
          str = adjustl(str)
      end function str
      	!!-------------------------------------------------------------------------
      
      
	open(unit=number,file="file_name",status="unknown")
	close(number)

	read from file (unknown end of file) IOSTAT "=" INTEGER VARIABLE!!
	DO
   READ(*,*,IOSTAT=Reason)  a, b, c
   IF (Reason > 0)  THEN
      ... something wrong ...
   ELSE IF (Reason < 0) THEN
      ... end of file reached ...
   ELSE
      ... do normal stuff ...
   END IF
END DO

!stop-->ends program
