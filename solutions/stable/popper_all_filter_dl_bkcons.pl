stable(A):- fixed(A).
stable(A):- fixed(B),startsYI(B,A).
stable(A):- object(B),duringY(B,A).
stable(A):- object(B),rightDuring(B,A).
stable(A):- mobile(B),after(B,A),overlapsY(B,A).
stable(A):- mobile(B),lessStartsI(B,A),below(B,A).
stable(A):- mobile(B),startsYI(B,C),mostFinishesI(C,A).
stable(A):- fixed(C),lessOverlapsMost(C,B),on(B,A).
stable(A):- mobile(B),leftDuringI(B,C),lessStarts(C,A).
stable(A):- mobile(B),centerDuringI(B,C),rightDuringI(C,A).
stable(A):- mobile(B),centerDuring(B,C),startsYI(C,A).
stable(A):- mobile(B),before(B,A),startsYI(B,A).
stable(A):- mobile(B),before(B,C),duringYI(C,A).
stable(A):- mobile(B),rightDuringI(B,A),on(B,A).
stable(A):- mobile(B),lessOverlapsLessI(B,C),on(C,A).
stable(A):- mobile(B),finishesYI(B,C),leftDuringI(C,A).
stable(A):- mobile(B),duringY(B,C),meetsI(C,A).
stable(A):- mobile(B),lessOverlapsMost(B,A),supports(A,B).
stable(A):- mobile(B),onI(B,C),lessOverlapsLessI(C,A).
stable(A):- mobile(B),rightDuring(B,C),centerDuring(C,A).
