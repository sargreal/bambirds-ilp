supports(A,B):- fixed(A),onI(A,B).
supports(A,B):- object(A),mostFinishes(A,C),lessFinishesI(C,B).
supports(A,B):- object(A),mostOverlapsLessI(A,C),lessFinishesI(C,B).
supports(A,B):- object(C),lessFinishesI(C,B),meets(B,A).
supports(A,B):- object(A),lessFinishes(A,C),lessFinishesI(C,B).
supports(A,B):- object(A),mostOverlapsMostI(A,C),lessFinishesI(C,B).
supports(A,B):- mobile(A),centerDuringI(A,C),lessFinishesI(C,B).
supports(A,B):- object(C),lessFinishesI(C,B),mostOverlapsLess(B,A).
