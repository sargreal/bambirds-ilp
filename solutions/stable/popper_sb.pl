stable(A):- fixed(A).
stable(A):- mobile(A),object(B),supports(B,A).
