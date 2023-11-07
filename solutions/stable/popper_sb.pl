stable(A):- fixed(A).
stable(A):- fixed(B),lessStartsI(B,A).
stable(A):- fixed(B),meets(B,A),pointContact(B,A).
stable(A):- fixed(B),centerDuringI(B,A),supports(B,A).
stable(A):- fixed(B),centerDuring(B,C),onI(C,A).
stable(A):- fixed(B),leftDuringI(B,A),supports(B,A).
stable(A):- fixed(B),rightDuring(B,C),onI(C,A).
stable(A):- fixed(B),mostOverlapsLessI(B,C),onI(C,A).
