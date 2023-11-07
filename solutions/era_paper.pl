% This file contains the rules for the ERA-stable predicate from the paper 
% "Qualitative Spatial Representation and Reasoning in Angry Birds: The Extended Rectangle Algebra"

:- table stable/1.

% Rule 1.0 
% fixed objects are stable
stable(A) :- fixed(A), !.
% Rule 1.1
% x lies on the ground.
stable(A) :- on(A,B), A\=B, fixed(B), !.

% Rule 1.2
% ∃y, z ∈ θ such that y and z are both ERAstable and CD(y, x) = CD(z, x) = vc: ERAx(x, y) ∈ {momi, moli, lomi, loli, msi, lsi, ldi} ∧ ERAx(x, z) ∈ {mom, mol, lom, lol, mf i, lf i, rdi}.
stable(A) :- object(B), object(C), verticalContact(B,A), verticalContact(C,A),stable(B), stable(C),
  (
    once(mostOverlapsMostI(A,B);
    mostOverlapsLessI(A,B);
    lessOverlapsMostI(A,B);
    lessOverlapsLessI(A,B);
    mostStartsI(A,B);
    lessStartsI(A,B);
    leftDuringI(A,B))
  ),
  (
    once(mostOverlapsMost(A,C);
    mostOverlapsLess(A,C);
    lessOverlapsMost(A,C);
    lessOverlapsLess(A,C);
    mostFinishesI(A,C);
    lessFinishesI(A,C);
    rightDuringI(A,C))
    ), !.

% Rule 1.3
% ∃y ∈ θ such that y is ERA-stable and CD(y, z) = vc: ERAx(x, y) ∈ {ms, mf, msi, ls, mf i, lf, cd, cdi, ld, rd, mom, momi, lomi, mol}.
stable(A) :- object(B), verticalContact(B,A),stable(B), 
  (
    once(lessStarts(A,B);
    mostFinishesI(A,B);
    lessFinishes(A,B);
    centerDuring(A,B);
    centerDuringI(A,B);
    leftDuring(A,B);
    rightDuring(A,B);
    mostOverlapsMost(A,B);
    mostOverlapsMostI(A,B);
    lessOverlapsMostI(A,B);
    mostOverlapsLess(A,B))
  ), !.

% Rule 1.4
% ∃y, z ∈ θ such that y and z are both ERA-stable, CD(x, y) = hc and CD(x, z) = hc: ((ERAx(x, y) ∈ {mi} ∧ ERAx(x, z) ∈ {mom, mol, lom, lol, mf i, lf i, rdi}) ∨ (ERAx(x, y) ∈ {m} ∧ ERAx(x, z) ∈ {momi, moli, lomi, loli, msi, lsi, ldi}))
stable(A) :- object(B), object(C), horizontalContact(A,B), horizontalContact(A,C), stable(B), stable(C), 
  (
    (
      meetsI(A,B),
      once(
        mostOverlapsMost(A,C);
        mostOverlapsLess(A,C);
        lessOverlapsMost(A,C);
        lessOverlapsLess(A,C);
        mostStartsI(A,C);
        lessStartsI(A,C);
        leftDuringI(A,C)
      )
    );
    (
      meets(A,B),
      once(
        mostOverlapsMostI(A,C);
        mostOverlapsLessI(A,C);
        lessOverlapsMostI(A,C);
        lessOverlapsLessI(A,C);
        mostFinishesI(A,C);
        lessFinishesI(A,C);
        rightDuringI(A,C)
      )
    )
  ), !.

% Rule 1.5
% ∃y, z ∈ θ such that y and z are both ERAstable and CD(y, x) = CD(z, x) = vc: 
% ERAx(x, y) ∈ {momi, moli, lomi, loli, msi, lsi, ldi} ∧ ERAx(x, z) ∈ {mom, mol, lom, lol, mfi, lfi, rdi}.
stable(A) :-
  object(B), object(C),
  verticalContact(B,A), verticalContact(C,A), stable(B), stable(C), 
    (
      once(
        mostOverlapsMostI(A,B);
        mostOverlapsLessI(A,B);
        lessOverlapsMostI(A,B);
        lessOverlapsLessI(A,B);
        mostStartsI(A,B);
        lessStartsI(A,B);
        leftDuringI(A,B)
    );
    (
      once(
        mostOverlapsMost(A,C);
        mostOverlapsLess(A,C);
        lessOverlapsMost(A,C);
        lessOverlapsLess(A,C);
        mostFinishesI(A,C);
        lessFinishesI(A,C);
        rightDuringI(A,C)
      )
    )
  ), !.

% Rule 1.6: 
% ∃y ∈ θ such that y is ERA-stable and CD(y, x) = vc and CR(x, y) = ss: 
% ERAx(x, y) ∈ {ms, mf, msi, ls, mfi, lf, cd, cdi, ld, rd, mom, momi, lomi, mol}.
stable(A) :-
  object(B), 
  verticalContact(B,A),
  surfaceContact(A,B),stable(B), 
  once(
    mostStarts(A,B);
    mostStartsI(A,B);
    mostFinishes(A,B);
    mostFinishesI(A,B);
    lessFinishes(A,B);
    lessStarts(A,B);
    centerDuring(A,B);
    centerDuringI(A,B);
    leftDuring(A,B);
    rightDuring(A,B);
    mostOverlapsMost(A,B);
    mostOverlapsMostI(A,B);
    lessOverlapsMostI(A,B);
    mostOverlapsLess(A,B)
  ), !.

% Rule 1.7: 
% ∃y, z ∈ θ such that y and z are both ERAstable and CD(y, x) = hc and CD(z, x) = vc : 
% ((ERAx(x, y) ∈ {mi} ∧ ERAx(x, z) ∈ {mom, mol, lom, lol, mfi, lfi, rdi}) 
% ∨ (ERAx(x, y) ∈ {m} ∧ ERAx(x, z) ∈ {momi, moli, lomi, loli, msi, lsi, ldi})).
stable(A) :-
  object(B), object(C), 
  horizontalContact(B,A), verticalContact(C,A),stable(B), stable(C), 
  (
    (
      meetsI(A,B),
      once(
        mostOverlapsMost(A,C);
        mostOverlapsLess(A,C);
        lessOverlapsMost(A,C);
        lessOverlapsLess(A,C);
        mostFinishesI(A,C);
        lessFinishesI(A,C);
        rightDuringI(A,C)
      )
    );
    (
      meets(A,B),
      once(
        mostOverlapsMostI(A,C);
        mostOverlapsLessI(A,C);
        lessOverlapsMostI(A,C);
        lessOverlapsLessI(A,C);
        mostStartsI(A,C);
        lessStartsI(A,C);
        leftDuringI(A,C)
      )
    )
  ), !.

% Rule 1.8: 
% ∃y, z ∈ θ such that y and z are both ERA-stable and CD(y, x) = CD(z, x) = hc : 
% ERAx(x, y) ∈ {m} ∧ ERAx(x, z) ∈ {mi}
stable(A) :-
  object(B), object(C), 
  horizontalContact(B,A), horizontalContact(C,A), stable(B), stable(C), 
  meetsI(A,B),
  meets(A,C), !.