stable(A):- fixed(A).
stable(A):- fixed(B),centerDuring(B,A).
stable(A):- mobile(B),leftDuring(B,A).
stable(A):- fixed(B),overlapsYI(B,A).
stable(A):- fixed(B),meetsI(B,A),equalY(A,B).
stable(A):- object(A),rightDuringI(A,B),supports(A,B).
stable(A):- object(A),finishesYI(A,B),supports(B,A).
stable(A):- object(A),mostOverlapsLessI(A,B),supports(A,B).
stable(A):- object(A),mostFinishes(A,B),supports(A,B).
stable(A):- object(C),leftDuring(C,B),meetsI(B,A).
stable(A):- fixed(C),startsYI(C,B),meetsI(B,A).
stable(A):- object(A),leftDuringI(A,B),supports(B,A).
stable(A):- object(A),mostFinishesI(A,B),supports(B,A).
stable(A):- object(A),centerDuring(A,B),supports(A,B).
stable(A):- object(A),mostOverlapsLess(A,B),supports(A,B).
stable(A):- object(A),mostOverlapsLess(A,B),overlapsYI(B,A).
stable(A):- fixed(C),lessFinishesI(C,B),meetsI(B,A).
stable(A):- object(B),meetsI(B,A),supports(A,B).
stable(A):- object(A),lessOverlapsMostI(A,B),supports(A,B).
stable(A):- object(A),rightDuringI(A,B),supports(B,A).
stable(A):- fixed(B),meetsI(B,A),surfaceContact(B,A).
