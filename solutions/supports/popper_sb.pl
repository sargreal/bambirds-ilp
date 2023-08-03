supports(A,B):- object(A),onI(A,B),lessOverlapsMost(A,B).
supports(A,B):- object(A),onI(A,B),surfaceContact(B,A).
supports(A,B):- object(A),onI(A,B),mostOverlapsLessI(A,B).
