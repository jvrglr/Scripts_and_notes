## Redondear/ round
	round(variable,*number_of_decimals,*type) --> round(a) closer integer to a
	floor 
	ceil
	fix--> truncate

## Defined constants
	pi, eps (round-off error), realmin, realmax
	
## Elementary fuctions: elfun
	elementary functions of matrices : help elmat

## ; at the end of a line supresses printout

## Matrices A=[a b c;x y z]-->space (or comma) to introduce elements of row ; to separate rows
	A(1,3) selects element in row 1, column 3
	A(:,1) all elements of column 1 // A(1,:) all elements of row 1
	A(:,1:2) all elements from column 1 to column 2
	A([2 3],[2 1])= A22	A21
				    A32 A31
	A= ones (a,b) axb matrix filled with ones // zeros(a,b) --> axb matrix filled with zeros
	A'--> conjugate transpose // A.'--> non-conjugate transpose
	size(A)--> dimensions of A
	A.*B--> entry-wise multiplication
	V=0:0.1:10  v is filled with numbers from 0 to 10 equally spaced (0.1 step)
	find(statement as A==5) finds position where statement is true
	
## Logical operators (true and false are represented by 1 and 0)
	~= not equal
	& and
	| or
	~ not
	xor exclusive or ??
	<= less than or equal
	
