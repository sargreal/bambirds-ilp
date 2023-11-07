supports(A,B):- mobile(B),on(B,A),surfaceContact(B,A).
supports(A,B):- mobile(C),lessOverlapsMostI(C,A),onI(A,B).
supports(A,B):- object(A),onI(A,B),lessOverlapsMostI(A,B).
supports(A,B):- object(A),mostOverlapsLess(A,B),onI(A,B).
supports(A,B):- object(A),onI(A,B),mostOverlapsLess(B,A).
supports(A,B):- mobile(A),lessFinishesI(A,C),mostOverlapsLess(C,B).
% supports(A,B):- mobile(C),rightDuring(C,B),meets(B,A).
% supports(A,B):- mobile(B),lessOverlapsLessI(B,C),centerDuringI(C,A).
% supports(A,B):- mobile(C),leftDuring(C,A),meetsI(A,B).
% supports(A,B):- object(A),mostOverlapsMost(A,B),pointContact(A,B).
% supports(A,B):- mobile(B),mostOverlapsMost(B,C),mostOverlapsMost(C,A).
% supports(A,B):- mobile(C),centerDuringI(C,B),lessOverlapsLessI(C,A).
% supports(A,B):- fixed(C),on(C,A),mostOverlapsMostI(A,B).
