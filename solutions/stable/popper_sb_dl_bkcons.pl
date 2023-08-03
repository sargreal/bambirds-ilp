stable(A):- fixed(B),onI(B,A).
stable(A):- mobile(B),onI(B,A),pointSurfaceContact(A,B).
