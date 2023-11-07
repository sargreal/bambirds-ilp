supports(A,B):- mobile(B),mostOverlapsLess(B,A),on(B,A).
supports(A,B):- mobile(B),on(B,A),mostOverlapsMostI(A,B).
supports(A,B):- mobile(B),on(B,A),lessOverlapsMostI(A,B).
supports(A,B):- mobile(B),mostOverlapsMost(B,C),mostOverlapsMost(C,A).
supports(A,B):- mobile(B),centerDuring(B,C),lessOverlapsLessI(C,A).
supports(A,B):- object(C),rightDuring(C,B),meets(B,A).
supports(A,B):- mobile(B),on(B,A),surfaceContact(A,B).
supports(A,B):- object(A),lessFinishesI(A,C),mostOverlapsLess(C,B).
supports(A,B):- object(C),mostOverlapsLess(C,A),lessOverlapsMostI(C,B).
supports(A,B):- mobile(B),lessOverlapsLessI(B,C),centerDuringI(C,A).
supports(A,B):- mobile(B),on(B,A),mostOverlapsMost(A,B).
supports(A,B):- mobile(B),on(B,A),mostOverlapsLess(A,B).
supports(A,B):- mobile(C),lessOverlapsMostI(C,A),onI(A,B).
