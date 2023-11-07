supports(A,B):- fixed(A),startsY(A,B).
supports(A,B):- fixed(A),overlapsY(A,B).
supports(A,B):- mobile(B),startsYI(B,A),surfaceContact(A,B).
supports(A,B):- mobile(B),overlapsYI(B,A),surfaceContact(A,B).
supports(A,B):- mobile(B),on(B,A),surfaceContact(A,B).
supports(A,B):- mobile(B),fixed(A),horizontalContact(B,A).
supports(A,B):- mobile(B),finishesY(B,A),surfaceContact(A,B).
supports(A,B):- mobile(B),mostOverlapsMost(B,A),surfaceContact(A,B).
