supports(A,B):- fixed(A),startsY(A,B).
supports(A,B):- object(A),lessOverlapsLessI(A,B).
supports(A,B):- object(A),centerDuring(A,B).
supports(A,B):- mobile(A),centerDuringI(A,B).
supports(A,B):- fixed(A),lessFinishes(A,B).
supports(A,B):- object(B),mostFinishesI(B,C),lessOverlapsMostI(C,A).
supports(A,B):- mobile(C),startsYI(C,B),mostOverlapsMost(B,A).
supports(A,B):- mobile(C),finishesYI(C,B),mostOverlapsMost(B,A).
supports(A,B):- object(B),meets(B,C),lessFinishes(C,A).
supports(A,B):- object(B),overlapsYI(B,C),mostOverlapsMost(C,A).
supports(A,B):- object(B),mostFinishes(B,A),on(B,A).
supports(A,B):- mobile(C),lessStarts(C,B),startsYI(B,A).
supports(A,B):- object(B),on(B,A),equal(A,B).
supports(A,B):- object(B),mostFinishes(B,C),mostOverlapsMost(C,A).
supports(A,B):- object(B),mostOverlapsMostI(B,A),overlapsYI(B,A).
supports(A,B):- mobile(C),mostOverlapsLess(C,B),mostFinishesI(B,A).
supports(A,B):- object(B),mostOverlapsLess(B,C),lessOverlapsLessI(C,A).
supports(A,B):- object(B),fixed(C),mostFinishes(C,A).
supports(A,B):- object(B),on(B,A),lessFinishesI(A,B).
supports(A,B):- object(B),on(B,A),rightDuringI(A,B).
supports(A,B):- object(B),overlapsY(B,C),centerDuringI(C,A).
supports(A,B):- object(B),on(B,A),lessOverlapsLess(A,B).
supports(A,B):- object(B),overlapsYI(B,A),verticalContact(B,A).
supports(A,B):- object(B),mostOverlapsMostI(B,C),lessOverlapsLess(C,A).
supports(A,B):- object(B),mostOverlapsMost(B,C),mostOverlapsLess(C,A).
supports(A,B):- object(B),lessOverlapsMost(B,C),lessOverlapsMostI(C,A).
supports(A,B):- object(B),finishesY(B,A),surfaceContact(A,B).
supports(A,B):- object(B),lessStartsI(B,A),on(B,A).
supports(A,B):- object(B),lessStarts(B,A),on(B,A).
supports(A,B):- mobile(C),lessFinishesI(C,A),startsY(A,B).
supports(A,B):- object(B),rightDuring(B,C),mostFinishesI(C,A).
supports(A,B):- object(B),lessStartsI(B,C),lessStarts(C,A).
supports(A,B):- object(B),on(B,A),mostOverlapsLess(A,B).
supports(A,B):- object(B),mostOverlapsLessI(B,C),lessStarts(C,A).
supports(A,B):- object(B),mostOverlapsMostI(B,C),lessStarts(C,A).
supports(A,B):- object(B),lessOverlapsLessI(B,A),startsYI(B,A).
supports(A,B):- object(B),mostOverlapsLess(B,C),mostOverlapsMostI(C,A).
supports(A,B):- object(B),on(B,A),lessOverlapsMost(A,B).
supports(A,B):- object(B),duringY(B,A),surfaceContact(A,B).
supports(A,B):- object(B),lessOverlapsLessI(B,C),meets(C,A).
supports(A,B):- object(B),startsYI(B,A),mostOverlapsLessI(B,A).
supports(A,B):- object(B),lessOverlapsMost(B,A),surfaceContact(A,B).
supports(A,B):- object(B),on(B,A),leftDuringI(A,B).
supports(A,B):- object(B),centerDuringI(B,C),centerDuring(C,A).
supports(A,B):- object(B),mostOverlapsLess(B,A),on(B,A).
supports(A,B):- mobile(C),finishesYI(C,B),mostOverlapsMostI(B,A).
supports(A,B):- object(B),startsYI(B,C),mostOverlapsMostI(C,A).
supports(A,B):- mobile(C),mostFinishesI(C,A),mostOverlapsLess(C,B).
supports(A,B):- object(B),startsYI(B,A),lessOverlapsMost(B,A).
supports(A,B):- object(B),mostOverlapsMost(B,C),overlapsYI(C,A).
supports(A,B):- object(B),mostOverlapsMostI(B,C),lessOverlapsMostI(C,A).
supports(A,B):- object(B),overlapsY(B,C),lessFinishes(C,A).
