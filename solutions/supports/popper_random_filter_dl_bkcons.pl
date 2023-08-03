supports(A,B):- object(A),rightDuringI(A,B).
supports(A,B):- mobile(B),lessOverlapsLessI(B,A).
supports(A,B):- fixed(A),onI(A,B).
supports(A,B):- mobile(A),mostFinishesI(A,B).
supports(A,B):- mobile(B),centerDuringI(B,A).
supports(A,B):- object(A),centerDuringI(A,B).
supports(A,B):- mobile(B),lessOverlapsMost(B,A).
supports(A,B):- object(A),lessFinishesI(A,B).
supports(A,B):- mobile(B),rightDuringI(B,A).
supports(A,B):- object(B),on(B,A),lessFinishes(A,B).
supports(A,B):- object(B),startsYI(B,A),meetsI(A,B).
supports(A,B):- object(B),duringY(B,A),pointContact(A,B).
supports(A,B):- object(B),on(B,A),mostOverlapsLessI(A,B).
supports(A,B):- object(B),overlapsYI(B,A),pointSurfaceContact(B,A).
supports(A,B):- object(B),mostOverlapsLessI(B,A),startsY(A,B).
supports(A,B):- object(B),on(B,A),pointSurfaceContact(B,A).
supports(A,B):- object(B),startsYI(B,A),mostOverlapsMost(A,B).
supports(A,B):- object(B),lessOverlapsMostI(B,A),onI(A,B).
supports(A,B):- object(B),equalY(B,A),verticalContact(A,B).
supports(A,B):- object(B),mostOverlapsMostI(B,A),overlapsY(A,B).
supports(A,B):- object(B),mostOverlapsMostI(B,A),onI(A,B).
supports(A,B):- object(B),startsYI(B,A),verticalContact(A,B).
supports(A,B):- object(B),overlapsYI(B,A),equal(A,B).
supports(A,B):- object(B),lessOverlapsLess(B,A),overlapsY(A,B).
supports(A,B):- object(B),lessOverlapsLess(B,A),surfaceContact(A,B).
supports(A,B):- object(B),on(B,A),equal(A,B).
supports(A,B):- object(B),on(B,A),lessOverlapsLessI(A,B).
supports(A,B):- object(B),on(B,A),mostOverlapsMostI(A,B).
supports(A,B):- object(B),mostOverlapsMost(B,A),overlapsY(A,B).
supports(A,B):- object(B),meetsI(B,A),duringY(A,B).
supports(A,B):- object(B),finishesY(B,A),verticalContact(A,B).