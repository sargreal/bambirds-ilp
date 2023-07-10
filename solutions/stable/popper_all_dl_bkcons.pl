stable(A):- object(A),fixed(A).
stable(A):- object(C),onI(C,B),lessStartsI(B,A).
stable(A):- object(C),duringYI(C,B),mostFinishes(B,A).
stable(A):- object(C),mostOverlapsLess(C,B),lessOverlapsMostI(B,A).
stable(A):- object(C),mostOverlapsLessI(C,B),duringYI(B,A).
stable(A):- object(C),finishesYI(C,B),duringYI(B,A).
stable(A):- object(C),mostOverlapsLess(C,B),lessOverlapsLess(B,A).
stable(A):- object(C),rightDuringI(C,B),finishesY(B,A).
stable(A):- object(C),lessStartsI(C,B),startsYI(B,A).
stable(A):- object(C),centerDuring(C,B),finishesYI(B,A).
stable(A):- object(C),duringY(C,B),finishesY(B,A).
stable(A):- object(C),rightDuring(C,B),lessFinishesI(B,A).
stable(A):- object(C),lessStarts(C,B),meetsI(B,A).
stable(A):- object(C),finishesY(C,B),rightDuringI(B,A).
stable(A):- object(C),leftDuringI(C,B),lessOverlapsMost(B,A).
stable(A):- object(C),finishesYI(C,B),finishesYI(B,A).
stable(A):- object(C),rightDuringI(C,B),centerDuringI(B,A).
stable(A):- object(C),mostFinishesI(C,B),centerDuringI(B,A).
stable(A):- object(C),lessOverlapsLessI(C,B),mostOverlapsLessI(B,A).
stable(A):- object(C),leftDuringI(C,B),centerDuringI(B,A).
stable(A):- object(A),finishesYI(A,B),pointSurfaceContact(B,A).
stable(A):- object(C),lessStartsI(C,B),startsY(B,A).
stable(A):- object(C),lessStarts(C,B),on(B,A).
stable(A):- object(C),lessOverlapsLess(C,B),finishesYI(B,A).
stable(A):- object(C),leftDuringI(C,B),duringYI(B,A).
stable(A):- object(C),lessStarts(C,B),centerDuring(B,A).
stable(A):- object(C),rightDuring(C,B),startsYI(B,A).
stable(A):- object(C),rightDuringI(C,B),mostOverlapsLess(B,A).
stable(A):- object(C),duringYI(C,B),lessFinishes(B,A).
stable(A):- object(C),leftDuringI(C,B),mostFinishes(B,A).
stable(A):- object(C),lessOverlapsLessI(C,B),rightDuringI(B,A).
stable(A):- object(C),lessFinishesI(C,B),finishesY(B,A).
stable(A):- object(C),rightDuringI(C,B),centerDuring(B,A).
stable(A):- object(C),lessOverlapsLessI(C,B),mostFinishes(B,A).
stable(A):- object(C),mostFinishesI(C,B),lessStarts(B,A).
stable(A):- object(C),rightDuring(C,B),lessOverlapsLess(B,A).
stable(A):- object(C),lessFinishes(C,B),lessOverlapsMostI(B,A).
stable(A):- object(C),startsY(C,B),leftDuringI(B,A).
stable(A):- object(C),lessStarts(C,B),startsY(B,A).
stable(A):- object(C),lessStarts(C,B),lessOverlapsMost(B,A).
stable(A):- object(C),lessFinishes(C,B),finishesY(B,A).
stable(A):- object(C),finishesYI(C,B),lessFinishesI(B,A).
stable(A):- object(C),leftDuringI(C,B),lessOverlapsMostI(B,A).
stable(A):- object(C),duringYI(C,B),lessStarts(B,A).
stable(A):- object(C),lessOverlapsMost(C,B),centerDuring(B,A).
stable(A):- object(C),lessStarts(C,B),mostOverlapsLessI(B,A).
stable(A):- object(C),finishesY(C,B),centerDuringI(B,A).
stable(A):- object(C),lessFinishesI(C,B),duringYI(B,A).