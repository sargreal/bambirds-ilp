supports(A,B) :-
  \+ below(A,B),
  \+ fixed(B),
  verticalContact(A,B).