% Get corner points for objects
:- module(stable_helpers, [recursive_supports/2]).
:- use_module(data).

recursive_supports(A,B) :- supports(A,B).
recursive_supports(A,C) :- supports(A,B), recursive_supports(B,C), !.