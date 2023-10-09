stable(A):- fixed(A).
stable(A):- fixed(B),overlapsYI(B,A).
stable(A):- fixed(B),lessOverlapsLess(B,A).
stable(A):- fixed(B),onI(B,A),mostFinishesI(A,B).
stable(A):- fixed(B),onI(B,A),mostFinishes(A,B).
stable(A):- fixed(B),onI(B,A),mostOverlapsLess(A,B).
stable(A):- fixed(B),onI(B,A),lessFinishes(A,B).
stable(A):- fixed(B),onI(B,A),equal(B,A).
