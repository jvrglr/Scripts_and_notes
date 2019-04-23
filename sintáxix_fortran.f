	program nombre
	integer a-b
	real	m-i
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
