supports(A,B):- mobile(A),lessOverlapsMost(A,B).
supports(A,B):- object(A),onI(A,B),mostOverlapsLessI(A,B).
supports(A,B):- object(A),onI(A,B),surfaceContact(A,B).
supports(A,B):- object(A),lessStartsI(A,C),lessOverlapsMostI(C,B).
supports(A,B):- object(A),lessFinishesI(A,C),mostOverlapsLess(C,B).
supports(A,B):- object(A),meetsI(A,B),mostOverlapsLess(B,A).
