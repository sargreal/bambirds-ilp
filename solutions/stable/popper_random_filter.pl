stable(A):- fixed(B),overlapsYI(B,A).
stable(A):- fixed(B),mostOverlapsLessI(B,A).
stable(A):- fixed(B),duringYI(B,A).
stable(A):- fixed(B),startsYI(B,A).
stable(A):- fixed(B),lessFinishesI(B,A).
stable(A):- fixed(B),on(B,A).
stable(A):- fixed(B),startsY(B,C),leftDuring(C,A).
stable(A):- fixed(B),lessStartsI(B,C),before(C,A).
stable(A):- fixed(B),startsY(B,C),mostOverlapsLess(C,A).
stable(A):- fixed(B),object(A),surfaceContact(A,B).
