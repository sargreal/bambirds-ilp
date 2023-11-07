supports(A,B) :-
  \+ below(A,B),
  mobile(B),
  verticalContact(A,B).

% x is fixed.
stable(A) :- fixed(A), !.
% x lies on the ground.
stable(A) :- on(A,B), fixed(B), !.
% the object that supports x is stable.
stable(A) :- object(B), A\=B, supports(B,A),  stable(B), !.