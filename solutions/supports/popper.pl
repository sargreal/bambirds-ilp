supports(A,B):- on(B,A),surfaceContact(A,B).
supports(A,B):- lessFinishes(B,C),lessOverlapsLess(C,A).
supports(A,B):- rightDuring(B,C),lessFinishes(A,C).
supports(A,B):- pointSurfaceContact(B,A),meets(B,C),lessOverlapsMost(B,C).
supports(A,B):- centerDuring(B,C),pointSurfaceContact(B,A),below(B,C).
supports(A,B):- below(B,C),pointSurfaceContact(B,A),rightDuring(A,C).
supports(A,B):- lessStarts(B,C),pointSurfaceContact(B,A),noContact(B,C).