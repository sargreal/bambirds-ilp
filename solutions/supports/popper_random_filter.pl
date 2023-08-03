supports(A,B):- fixed(A),onI(A,B).
supports(A,B):- mobile(B),lessStartsI(B,A).
supports(A,B):- mobile(A),rightDuringI(A,B).
supports(A,B):- mobile(B),leftDuring(B,A).
supports(A,B):- mobile(B),rightDuringI(B,A).
supports(A,B):- mobile(B),lessFinishes(B,A).
supports(A,B):- mobile(B),centerDuring(B,A).
supports(A,B):- mobile(B),mostFinishes(B,A).
supports(A,B):- fixed(C),lessOverlapsMost(C,A),mostOverlapsLessI(A,B).
supports(A,B):- mobile(C),finishesY(C,A),mostOverlapsLessI(A,B).
supports(A,B):- mobile(A),lessOverlapsLessI(A,C),overlapsY(C,B).
supports(A,B):- mobile(A),lessOverlapsLessI(A,C),mostOverlapsMost(C,B).
supports(A,B):- object(C),lessOverlapsLessI(C,B),lessOverlapsMostI(B,A).
supports(A,B):- mobile(A),lessOverlapsLessI(A,C),mostOverlapsLess(C,B).
supports(A,B):- object(C),lessOverlapsLessI(C,B),centerDuring(C,A).
supports(A,B):- object(C),lessOverlapsLessI(C,B),mostOverlapsMostI(C,A).
supports(A,B):- object(C),lessOverlapsLessI(C,B),meetsI(B,A).
supports(A,B):- object(C),lessOverlapsLessI(C,B),mostOverlapsMost(B,A).
supports(A,B):- mobile(A),lessOverlapsLessI(A,C),meets(C,B).
supports(A,B):- object(C),lessOverlapsLessI(C,B),overlapsYI(B,A).
supports(A,B):- object(C),onI(C,A),lessOverlapsLessI(C,B).
supports(A,B):- object(C),lessOverlapsLessI(C,B),mostOverlapsMostI(B,A).
supports(A,B):- object(C),lessOverlapsLessI(C,B),finishesYI(B,A).