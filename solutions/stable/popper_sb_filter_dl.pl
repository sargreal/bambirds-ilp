stable(A):- fixed(A).
stable(A):- object(B),lessOverlapsLess(B,A).
stable(A):- mobile(B),leftDuringI(B,A).
stable(A):- fixed(B),mostOverlapsLessI(B,A).
stable(A):- mobile(B),lessOverlapsLessI(B,A).
stable(A):- object(B),leftDuring(B,A).
stable(A):- fixed(B),mostOverlapsMostI(B,A).
