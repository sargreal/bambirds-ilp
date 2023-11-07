supports(A,B) :-
  \+ below(A,B),
  mobile(B),
  verticalContact(A,B).