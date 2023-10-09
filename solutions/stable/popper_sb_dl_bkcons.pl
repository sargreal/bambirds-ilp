stable(A):- fixed(A).
stable(A):- fixed(B),object(A),supports(B,A).
stable(A):- mobile(A),fixed(C),startsY(C,B),horizontalContact(B,A).
stable(A):- fixed(C),leftDuringI(C,B),below(C,A),surfaceContact(B,C).
