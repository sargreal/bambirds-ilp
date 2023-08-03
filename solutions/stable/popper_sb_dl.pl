stable(A):- mobile(B),on(B,A).
stable(A):- object(B),centerDuringI(B,A).
stable(A):- mobile(B),rightDuringI(B,A).
stable(A):- fixed(B),equalY(B,A).
stable(A):- object(B),mostOverlapsMost(B,A).
stable(A):- object(B),mostOverlapsMostI(B,A).
