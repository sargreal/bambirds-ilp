stable(A):- fixed(A).
stable(A):- fixed(B),lessStartsI(B,A).
stable(A):- fixed(B),centerDuring(B,A).
stable(A):- fixed(B),mostOverlapsMost(B,A).
stable(A):- fixed(B),mostFinishesI(B,A),surfaceContact(B,A).
stable(A):- fixed(B),startsYI(B,A),surfaceContact(B,A).
stable(A):- fixed(B),mostOverlapsLessI(B,A),surfaceContact(B,A).
stable(A):- fixed(B),lessOverlapsMost(B,A),surfaceContact(B,A).
