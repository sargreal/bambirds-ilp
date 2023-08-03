stable(A):- fixed(A).
stable(A):- fixed(B),centerDuring(B,A).
stable(A):- fixed(B),mostOverlapsMostI(B,A).
stable(A):- mobile(B),leftDuring(B,A).
stable(A):- fixed(B),overlapsYI(B,A).
stable(A):- fixed(C),before(C,B),lessOverlapsMost(B,A).
stable(A):- fixed(C),before(C,B),centerDuringI(B,A).
