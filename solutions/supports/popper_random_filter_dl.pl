supports(A,B):- mobile(B),leftDuringI(B,A).
supports(A,B):- mobile(B),lessOverlapsLessI(B,A).
supports(A,B):- fixed(A),meets(A,B).
supports(A,B):- fixed(A),mostOverlapsLess(A,B).
supports(A,B):- mobile(B),lessStartsI(B,A).
supports(A,B):- fixed(A),lessOverlapsMostI(A,B).
supports(A,B):- object(A),mostFinishes(A,B).
supports(A,B):- object(A),lessFinishesI(A,B).
supports(A,B):- object(A),lessOverlapsLess(A,B).
supports(A,B):- mobile(B),rightDuring(B,A).
supports(A,B):- object(B),overlapsYI(B,A),lessOverlapsLess(B,A).
supports(A,B):- object(A),finishesYI(A,B),surfaceContact(A,B).
supports(A,B):- object(B),on(B,A),rightDuringI(A,B).
supports(A,B):- object(B),meets(B,C),lessStarts(C,A).
supports(A,B):- object(B),mostOverlapsMostI(B,A),overlapsYI(B,A).
supports(A,B):- object(B),overlapsYI(B,A),mostFinishes(B,A).
supports(A,B):- object(B),on(B,A),lessOverlapsMost(B,A).
supports(A,B):- object(B),object(A),equal(A,B).
supports(A,B):- object(B),mostOverlapsLess(B,C),mostOverlapsLessI(C,A).
supports(A,B):- object(B),mostOverlapsLessI(B,A),startsYI(B,A).
supports(A,B):- object(B),centerDuring(B,A),overlapsYI(B,A).
supports(A,B):- object(A),lessStartsI(A,B),surfaceContact(A,B).
supports(A,B):- object(B),centerDuringI(B,A),on(B,A).
supports(A,B):- object(B),lessOverlapsMost(B,C),finishesYI(C,A).
supports(A,B):- object(B),mostOverlapsLess(B,C),centerDuring(C,A).
supports(A,B):- object(B),mostOverlapsMostI(B,C),mostOverlapsMost(C,A).
supports(A,B):- object(B),lessOverlapsLessI(B,C),lessOverlapsMost(C,A).
supports(A,B):- object(B),mostFinishes(B,C),centerDuringI(C,A).
supports(A,B):- object(B),lessOverlapsLessI(B,C),lessOverlapsLess(C,A).
supports(A,B):- object(B),on(B,A),lessOverlapsLessI(A,B).
supports(A,B):- object(B),leftDuringI(B,C),leftDuring(C,A).
supports(A,B):- object(B),startsYI(B,A),on(B,A).
supports(A,B):- object(B),duringYI(B,C),mostFinishes(C,A).
supports(A,B):- object(B),overlapsYI(B,A),mostOverlapsMost(B,A).
supports(A,B):- object(B),finishesY(B,C),lessOverlapsMost(C,A).
supports(A,B):- object(B),on(B,A),centerDuring(B,A).
supports(A,B):- object(B),mostFinishesI(B,C),lessOverlapsLessI(C,A).
supports(A,B):- object(B),lessOverlapsMostI(B,C),lessFinishesI(C,A).
supports(A,B):- object(B),mostOverlapsMost(B,C),lessOverlapsLess(C,A).
supports(A,B):- object(B),lessOverlapsMost(B,C),mostFinishes(C,A).
supports(A,B):- object(B),startsYI(B,A),verticalContact(B,A).
supports(A,B):- object(B),finishesY(B,A),mostOverlapsMostI(B,A).
supports(A,B):- object(B),lessStarts(B,A),on(B,A).
supports(A,B):- object(B),mostOverlapsLessI(B,A),overlapsYI(B,A).
supports(A,B):- object(B),startsYI(B,A),lessOverlapsLessI(A,B).
supports(A,B):- object(B),on(B,A),mostFinishes(B,A).
supports(A,B):- object(B),on(B,A),leftDuringI(A,B).
supports(A,B):- object(A),lessOverlapsMost(A,B),surfaceContact(A,B).
supports(A,B):- object(B),lessOverlapsLess(B,C),mostOverlapsLessI(C,A).
supports(A,B):- object(B),meetsI(B,C),centerDuring(C,A).
supports(A,B):- object(B),on(B,A),pointSurfaceContact(B,A).
supports(A,B):- object(B),mostFinishes(B,C),mostOverlapsMost(C,A).
supports(A,B):- object(B),centerDuring(B,C),mostOverlapsMost(C,A).
supports(A,B):- object(C),lessOverlapsLessI(C,B),mostOverlapsMostI(B,A).
supports(A,B):- object(B),on(B,A),horizontalContact(B,A).
supports(A,B):- object(B),lessFinishes(B,C),mostOverlapsMost(C,A).
supports(A,B):- object(B),mostOverlapsLessI(B,C),centerDuring(C,A).
supports(A,B):- object(B),lessOverlapsMost(B,A),overlapsYI(B,A).
