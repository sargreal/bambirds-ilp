stable(A):- fixed(A).
stable(A):- fixed(B),lessFinishesI(B,A).
stable(A):- mobile(B),leftDuringI(B,A).
stable(A):- fixed(B),mostOverlapsLessI(B,A).
stable(A):- mobile(C),leftDuringI(C,B),lessOverlapsMostI(B,A).
stable(A):- mobile(C),mostOverlapsMostI(C,B),lessOverlapsMostI(B,A).
stable(A):- mobile(C),lessOverlapsLess(C,B),lessOverlapsMostI(B,A).
