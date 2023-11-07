supports(A,B):- fixed(A),lessFinishes(A,B).
supports(A,B):- fixed(A),mostOverlapsLess(A,B).
supports(A,B):- fixed(A),mostFinishesI(A,B).
supports(A,B):- fixed(A),startsY(A,B).
supports(A,B):- mobile(C),lessOverlapsLess(C,A),mostOverlapsMost(A,B).
supports(A,B):- mobile(C),startsYI(C,A),lessFinishesI(A,B).
supports(A,B):- mobile(C),mostOverlapsLessI(C,A),centerDuring(A,B).
supports(A,B):- mobile(C),lessOverlapsMostI(C,A),overlapsY(A,B).
supports(A,B):- mobile(C),startsYI(C,A),lessFinishes(A,B).
supports(A,B):- mobile(C),lessOverlapsLessI(C,A),mostOverlapsLess(A,B).
supports(A,B):- mobile(C),lessFinishes(C,A),lessOverlapsMostI(A,B).
supports(A,B):- mobile(C),rightDuring(C,A),lessFinishesI(A,B).
supports(A,B):- mobile(C),rightDuring(C,A),rightDuringI(A,B).
supports(A,B):- mobile(C),mostFinishes(C,A),lessOverlapsMost(C,B).
supports(A,B):- mobile(C),lessOverlapsMostI(C,A),lessOverlapsMostI(A,B).
supports(A,B):- mobile(C),mostOverlapsLess(C,B),lessFinishes(C,A).
supports(A,B):- mobile(C),overlapsY(C,A),mostOverlapsMostI(A,B).
supports(A,B):- mobile(C),lessOverlapsLess(C,A),startsY(A,B).
supports(A,B):- mobile(C),lessFinishes(C,A),mostOverlapsMost(A,B).
supports(A,B):- mobile(C),lessOverlapsLessI(C,A),lessStartsI(A,B).
supports(A,B):- mobile(C),mostOverlapsLess(C,A),centerDuring(A,B).
supports(A,B):- mobile(C),mostFinishes(C,A),mostOverlapsMostI(C,B).
supports(A,B):- mobile(C),mostFinishesI(C,B),centerDuring(C,A).
supports(A,B):- mobile(C),lessStarts(C,A),mostOverlapsLess(A,B).
supports(A,B):- mobile(C),centerDuringI(C,A),lessOverlapsMost(C,B).
supports(A,B):- mobile(C),lessOverlapsMost(C,A),meets(A,B).
supports(A,B):- mobile(C),lessOverlapsMostI(C,A),finishesYI(A,B).
supports(A,B):- mobile(C),leftDuringI(C,A),mostOverlapsLess(A,B).
supports(A,B):- mobile(C),mostOverlapsLess(C,A),mostFinishes(A,B).
supports(A,B):- mobile(C),lessStartsI(C,A),mostFinishes(C,B).
supports(A,B):- mobile(C),mostFinishes(C,A),mostFinishes(A,B).
supports(A,B):- mobile(C),lessOverlapsMost(C,A),mostOverlapsLess(A,B).
supports(A,B):- mobile(C),lessStarts(C,A),overlapsY(A,B).
supports(A,B):- mobile(C),startsYI(C,A),mostFinishesI(A,B).
supports(A,B):- mobile(C),mostOverlapsLess(C,A),lessFinishes(A,B).
supports(A,B):- mobile(C),startsYI(C,A),lessOverlapsMostI(A,B).
supports(A,B):- mobile(C),finishesY(C,A),meets(A,B).
supports(A,B):- mobile(C),mostFinishesI(C,A),mostOverlapsMost(A,B).
supports(A,B):- mobile(C),centerDuringI(C,A),lessOverlapsMost(A,B).
supports(A,B):- mobile(C),mostFinishes(C,A),startsY(A,B).
supports(A,B):- mobile(C),leftDuringI(C,A),meetsI(A,B).
supports(A,B):- mobile(C),finishesYI(C,A),lessFinishesI(A,B).
supports(A,B):- mobile(C),on(C,A),centerDuringI(A,B).
supports(A,B):- mobile(C),lessFinishes(C,A),meets(C,B).
supports(A,B):- mobile(C),lessStarts(C,A),lessOverlapsLessI(A,B).
supports(A,B):- mobile(C),mostOverlapsLessI(C,A),meets(A,B).
supports(A,B):- mobile(C),lessOverlapsMostI(C,A),mostOverlapsMost(C,B).
supports(A,B):- mobile(C),mostOverlapsLess(C,A),lessOverlapsMost(C,B).
supports(A,B):- mobile(C),finishesYI(C,A),leftDuringI(A,B).
supports(A,B):- mobile(C),meetsI(C,A),mostFinishes(C,B).
supports(A,B):- mobile(C),startsYI(C,A),rightDuringI(A,B).
supports(A,B):- mobile(C),lessOverlapsLess(C,A),finishesY(C,B).
supports(A,B):- mobile(C),duringYI(C,A),meetsI(C,B).
supports(A,B):- mobile(C),mostFinishes(C,A),rightDuringI(A,B).
supports(A,B):- mobile(C),startsYI(C,A),mostOverlapsMostI(A,B).
supports(A,B):- mobile(C),lessStartsI(C,A),onI(A,B).
supports(A,B):- mobile(C),lessOverlapsLessI(C,A),mostFinishesI(A,B).
supports(A,B):- mobile(C),overlapsYI(C,A),mostOverlapsMost(A,B).
supports(A,B):- mobile(C),mostOverlapsLess(C,A),mostOverlapsMostI(C,B).
supports(A,B):- mobile(C),mostOverlapsMostI(C,A),lessStartsI(A,B).
supports(A,B):- mobile(C),rightDuringI(C,A),onI(A,B).
supports(A,B):- mobile(C),mostFinishes(C,B),mostOverlapsLess(C,A).
supports(A,B):- mobile(C),lessOverlapsLessI(C,B),startsY(C,A).
supports(A,B):- mobile(C),lessStarts(C,A),mostOverlapsLess(C,B).
supports(A,B):- mobile(C),finishesYI(C,A),lessOverlapsMostI(C,B).
supports(A,B):- mobile(C),startsY(C,A),lessOverlapsLessI(A,B).
supports(A,B):- mobile(C),mostFinishesI(C,A),mostFinishesI(A,B).
