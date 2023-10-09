stable(A):- fixed(A).
stable(A):- fixed(B),centerDuring(B,A).
stable(A):- fixed(B),finishesY(B,A).
stable(A):- fixed(B),mostOverlapsLess(B,A).
stable(A):- fixed(B),mostFinishesI(B,A).
stable(A):- object(B),rightDuring(B,A).
stable(A):- fixed(B),lessFinishes(B,A).
stable(A):- fixed(B),lessOverlapsLessI(B,A).
stable(A):- mobile(C),leftDuringI(C,B),below(B,A).
stable(A):- mobile(C),centerDuringI(C,B),mostFinishesI(B,A).
stable(A):- mobile(C),startsYI(C,B),centerDuring(B,A).
stable(A):- mobile(B),mostFinishes(B,A),on(B,A).
stable(A):- mobile(C),onI(C,B),leftDuringI(B,A).
stable(A):- mobile(C),mostFinishes(C,B),lessOverlapsMost(B,A).
stable(A):- mobile(C),duringYI(C,B),startsYI(B,A).
stable(A):- mobile(C),rightDuring(C,B),on(B,A).
stable(A):- mobile(B),startsY(B,A),pointContact(B,A).
stable(A):- mobile(C),lessOverlapsMostI(C,B),startsY(B,A).
stable(A):- mobile(C),duringYI(C,B),mostOverlapsLessI(B,A).
stable(A):- mobile(B),mostOverlapsMost(B,A),on(B,A).
stable(A):- mobile(B),mostOverlapsMost(B,A),on(A,B).
stable(A):- mobile(C),mostOverlapsLess(C,B),startsYI(B,A).
stable(A):- mobile(C),startsYI(C,B),lessOverlapsMostI(B,A).
stable(A):- mobile(C),mostOverlapsLess(C,B),mostFinishes(B,A).
stable(A):- fixed(B),rightDuringI(B,C),startsY(C,A).
stable(A):- mobile(B),mostOverlapsMostI(B,A),on(B,A).
stable(A):- mobile(B),lessFinishes(B,A),on(A,B).
stable(A):- mobile(B),mostOverlapsMostI(B,A),on(A,B).
stable(A):- mobile(C),lessOverlapsMostI(C,B),mostFinishesI(B,A).
stable(A):- mobile(B),lessFinishesI(B,A),on(B,A).
stable(A):- mobile(B),startsYI(B,A),pointContact(B,A).
stable(A):- mobile(C),lessOverlapsMostI(C,B),lessStartsI(B,A).
stable(A):- mobile(C),leftDuring(C,B),on(B,A).
stable(A):- fixed(B),rightDuringI(B,C),finishesY(C,A).
stable(A):- mobile(B),mostOverlapsLessI(B,A),verticalContact(A,B).
