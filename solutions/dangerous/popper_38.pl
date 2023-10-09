dangerous(A):- formBlock(B),isLeft(B,A).
dangerous(A):- isBelow(A,B),isRight(B,A).
dangerous(A):- isRight(A,B),isOver(A,B).
dangerous(A):- wood(A),formBlock(A).
dangerous(A):- isRight(A,B),isBelow(B,A).
dangerous(A):- isOn(B,A),smallSize(B),orientedHorizontally(B).
dangerous(A):- isLeft(A,C),isOn(B,C),isLeft(C,B).
dangerous(A):- orientedHorizontally(A),isBelow(A,B),formPoly(B).
dangerous(A):- isLeft(A,B),isLeft(B,C),formPoly(C).
dangerous(A):- isBelow(B,C),isBelow(A,B),isLeft(C,B).
dangerous(A):- isOn(A,C),wood(B),isRight(B,C).
