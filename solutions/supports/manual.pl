supports(A,B) :-
  \+ below(A,B),
  \+ fixed(B),
  verticalContact(A,B).
% supports(A,B) :-
%   overlapsY(B,A),
%   verticalContact(A,B).