supports(A,B):- object(B),lessFinishesI(B,A).
supports(A,B):- mobile(B),rightDuringI(B,A).
supports(A,B):- fixed(A),lessOverlapsLess(A,B).
supports(A,B):- object(A),lessOverlapsMostI(A,B).
supports(A,B):- mobile(B),lessStarts(B,A).
supports(A,B):- mobile(A),rightDuringI(A,C),mostOverlapsMost(C,B).
supports(A,B):- mobile(A),overlapsY(A,B),pointContact(B,A).
supports(A,B):- mobile(A),overlapsY(A,B),lessOverlapsLess(B,A).
supports(A,B):- mobile(A),onI(A,B),lessFinishesI(A,B).
supports(A,B):- mobile(A),lessOverlapsMost(A,B),verticalContact(B,A).
supports(A,B):- mobile(A),startsY(A,C),lessOverlapsMost(C,B).
supports(A,B):- mobile(A),mostOverlapsMostI(A,B),onI(A,B).
supports(A,B):- mobile(A),overlapsY(A,B),mostOverlapsMostI(B,A).
supports(A,B):- mobile(A),mostFinishesI(A,B),overlapsYI(B,A).
supports(A,B):- mobile(A),lessStarts(A,C),centerDuring(C,B).
supports(A,B):- mobile(A),mostFinishesI(A,B),onI(A,B).
supports(A,B):- mobile(A),onI(A,B),centerDuringI(A,B).
supports(A,B):- mobile(A),finishesYI(A,B),lessOverlapsLess(B,A).
supports(A,B):- mobile(A),lessStarts(A,C),lessOverlapsLessI(C,B).
supports(A,B):- mobile(A),onI(A,B),leftDuringI(A,B).
supports(A,B):- mobile(A),meetsI(A,C),lessOverlapsLess(C,B).
supports(A,B):- mobile(A),onI(A,B),mostOverlapsLess(B,A).
supports(A,B):- mobile(A),overlapsY(A,C),lessStarts(C,B).
supports(A,B):- mobile(A),rightDuringI(A,C),lessOverlapsMostI(C,B).
supports(A,B):- mobile(A),finishesYI(A,B),lessOverlapsLessI(B,A).
supports(A,B):- mobile(A),meets(A,C),lessOverlapsMostI(C,B).
supports(A,B):- mobile(A),overlapsY(A,B),equal(A,B).
supports(A,B):- mobile(A),mostOverlapsMost(A,C),overlapsY(C,B).
supports(A,B):- mobile(A),finishesYI(A,B),mostOverlapsMostI(B,A).
supports(A,B):- mobile(A),onI(A,B),lessOverlapsLess(A,B).
supports(A,B):- mobile(A),onI(A,B),mostOverlapsMostI(B,A).
supports(A,B):- mobile(A),onI(A,B),lessOverlapsMostI(B,A).
supports(A,B):- fixed(A),onI(A,B),mobile(B).
supports(A,B):- mobile(A),lessFinishesI(A,C),overlapsYI(C,B).
supports(A,B):- mobile(A),lessOverlapsLessI(A,B),verticalContact(B,A).
supports(A,B):- mobile(B),fixed(C),duringY(C,A).
supports(A,B):- mobile(A),overlapsY(A,B),verticalContact(B,A).
supports(A,B):- mobile(A),onI(A,B),meetsI(B,A).
supports(A,B):- mobile(A),lessOverlapsMost(A,C),overlapsYI(C,B).
supports(A,B):- mobile(A),overlapsY(A,B),lessOverlapsLessI(B,A).
supports(A,B):- mobile(A),meetsI(A,C),lessOverlapsMost(C,B).
supports(A,B):- mobile(A),onI(A,B),rightDuringI(A,B).
supports(A,B):- mobile(A),onI(A,B),verticalContact(B,A).
supports(A,B):- mobile(A),duringY(A,B),verticalContact(B,A).
supports(A,B):- mobile(A),finishesYI(A,B),verticalContact(B,A).
supports(A,B):- mobile(A),lessOverlapsLess(A,B),equalY(B,A).
supports(A,B):- mobile(A),onI(A,B),mostOverlapsLessI(B,A).
supports(A,B):- mobile(A),overlapsY(A,B),mostOverlapsLessI(B,A).
supports(A,B):- mobile(A),lessOverlapsLess(A,C),mostOverlapsMostI(C,B).
supports(A,B):- mobile(A),mostOverlapsMostI(A,C),mostOverlapsLess(C,B).
supports(A,B):- mobile(A),onI(A,B),equal(A,B).
supports(A,B):- mobile(A),meetsI(A,C),mostOverlapsLess(C,B).
supports(A,B):- mobile(A),onI(A,B),lessOverlapsLess(B,A).
supports(A,B):- mobile(A),onI(A,B),lessStartsI(B,A).
supports(A,B):- mobile(A),startsY(A,B),lessStartsI(B,A).
supports(A,B):- mobile(A),mostOverlapsLessI(A,C),lessOverlapsMostI(C,B).
supports(A,B):- mobile(A),lessFinishesI(A,C),mostOverlapsLess(C,B).
supports(A,B):- mobile(A),mostOverlapsLess(A,B),startsYI(B,A).
supports(A,B):- mobile(A),lessStartsI(A,C),centerDuring(C,B).
supports(A,B):- mobile(A),lessOverlapsLess(A,B),startsYI(B,A).



stable(A):- mobile(B),lessOverlapsLessI(B,A).
stable(A):- mobile(B),meets(B,C),lessFinishesI(C,A).
stable(A):- fixed(B),startsY(B,A),leftDuring(A,B).
stable(A):- mobile(B),lessFinishes(B,C),meets(C,A).
stable(A):- fixed(C),startsY(C,B),mostFinishes(B,A).
stable(A):- mobile(B),lessOverlapsMostI(B,C),mostFinishes(C,A).
stable(A):- mobile(B),mostOverlapsLess(B,C),lessOverlapsMostI(C,A).
stable(A):- fixed(B),centerDuringI(B,A),onI(B,A).
stable(A):- mobile(B),mostOverlapsLess(B,C),lessFinishes(C,A).
stable(A):- mobile(B),meets(B,A),pointContact(B,A).
stable(A):- mobile(B),centerDuringI(B,C),lessFinishes(C,A).
stable(A):- fixed(C),below(C,B),leftDuringI(B,A).
stable(A):- mobile(B),centerDuringI(B,C),mostOverlapsMostI(C,A).
stable(A):- fixed(C),onI(C,B),lessFinishesI(B,A).
stable(A):- above(B,A),mobile(B),meets(B,A).
stable(A):- mobile(B),meets(B,C),lessStarts(C,A).
stable(A):- fixed(B),equalY(B,A),pointSurfaceContact(B,A).
stable(A):- fixed(B),onI(B,A),pointContact(B,A).
stable(A):- fixed(C),leftDuringI(C,B),rightDuringI(B,A).
stable(A):- fixed(C),startsY(C,B),rightDuring(B,A).
stable(A):- fixed(B),rightDuringI(B,A),onI(B,A).
stable(A):- mobile(B),meets(B,C),mostOverlapsMost(C,A).
