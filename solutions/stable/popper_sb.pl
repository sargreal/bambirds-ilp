stable(A):- fixed(A).
stable(A):- fixed(B),mostFinishes(B,A).
stable(A):- fixed(B),mostOverlapsMostI(B,A).
stable(A):- object(B),mostOverlapsLessI(B,A),equalY(A,B).
stable(A):- mobile(B),meets(B,A),pointContact(A,B).
stable(A):- above(B,A),mobile(B),meets(B,A).
stable(A):- mobile(B),meetsI(B,C),lessFinishesI(C,A).
stable(A):- object(C),leftDuringI(C,B),mostOverlapsLessI(B,A).
stable(A):- fixed(B),mostOverlapsLessI(B,A),below(A,B).
stable(A):- mobile(B),meetsI(B,C),mostFinishes(C,A).
stable(A):- object(C),lessFinishes(C,B),mostOverlapsLessI(B,A).
