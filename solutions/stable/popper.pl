stable(A):- mostOverlapsLessI(A,B),object(B),equalY(B,A).
stable(A):- object(B),startsY(B,A),centerDuringI(B,A).
stable(A):- object(B),lessOverlapsLess(B,C),mostOverlapsMost(C,A).
stable(A):- above(B,A),object(B),mostFinishes(B,A).
stable(A):- object(B),meets(B,A),recursive_supports(A,B).
stable(A):- object(B),mostOverlapsLessI(B,A),equalY(B,A).
stable(A):- above(B,A),object(B),lessOverlapsMost(B,A).
stable(A):- object(B),leftDuring(B,C),equalY(C,A).