:- module(compare, [
  less_with_tolerance/3,
  greater_with_tolerance/3,
  less_equal_with_tolerance/3,
  equal_with_tolerance/3,
  greater_equal_with_tolerance/3
]).

less_with_tolerance(X, Y, T) :-
  X < Y - T.

greater_with_tolerance(X,Y,T) :- less_with_tolerance(Y,X,T).

equal_with_tolerance(X, Y, T) :-
  Min is Y - T,
  Max is Y + T,
  between(Min, Max, X).

less_equal_with_tolerance(X,Y,T) :-
  less_with_tolerance(X,Y,T); equal_with_tolerance(X,Y,T).

greater_equal_with_tolerance(X,Y,T) :-
  less_equal_with_tolerance(Y,X,T).