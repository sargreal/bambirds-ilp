stable(A):- fixed(A).
stable(A):- fixed(B),lessOverlapsLess(B,A).
stable(A):- fixed(B),overlapsYI(B,A).
stable(A):- mobile(C),duringY(C,B),mostOverlapsLess(B,A).
stable(A):- fixed(B),mostOverlapsLess(B,A),pointContact(A,B).
