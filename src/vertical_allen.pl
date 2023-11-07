% Vertical Allen interval algebra
:- module(vertical_allen, [
  below/3,
  above/3,
  on/3,
  onI/3,
  overlapsY/3,
  overlapsYI/3,
  startsY/3,
  startsYI/3,
  duringY/3,
  duringYI/3,
  finishesY/3,
  finishesYI/3,
  equalY/3,
  below/2,
  above/2,
  on/2,
  onI/2,
  overlapsY/2,
  overlapsYI/2,
  startsY/2,
  startsYI/2,
  duringY/2,
  duringYI/2,
  finishesY/2,
  finishesYI/2,
  equalY/2
]).
:- use_module(objects).
:- use_module(compare).
:- use_module(constants).

bottom(X,XBottom) :- y(X,XBottom).
top(X,XTop) :- bottom(X,XBottom), height(X,XHeight), XTop is XBottom + XHeight.


below(X,Y,T) :- 
  sameSituation(X,Y),
  top(X,XTop),
  bottom(Y,YBottom),
  less_with_tolerance(XTop,YBottom,T).
below(X,Y) :-
  tolerance(T), below(X,Y,T).

above(X,Y,T) :- below(Y,X,T).
above(X,Y) :- below(Y,X).

on(X,Y,T) :- 
  sameSituation(X,Y),
  bottom(X,XBottom),
  top(Y,YTop),
  equal_with_tolerance(XBottom,YTop,T).
on(X,Y) :-
  tolerance(T), on(X,Y,T).

onI(X,Y,T) :- on(Y,X,T).
onI(X,Y) :- on(Y,X).

overlapsY(X,Y,T) :-
  sameSituation(X,Y),
  bottom(X,XBottom), bottom(Y,YBottom),
  top(X,XTop),
  top(Y,YTop),
  less_with_tolerance(XBottom,YBottom,T),
  greater_with_tolerance(XTop,YBottom,T),
  less_with_tolerance(XTop,YTop,T).
overlapsY(X,Y) :-
  tolerance(T), overlapsY(X,Y,T).

overlapsYI(X,Y,T) :- overlapsY(Y,X,T).
overlapsYI(X,Y) :- overlapsY(Y,X).

startsY(X,Y,T) :-
  sameSituation(X,Y),
  bottom(X,XBottom), bottom(Y,YBottom),
  top(X,XTop),
  top(Y,YTop),
  equal_with_tolerance(XBottom,YBottom,T), less_with_tolerance(XTop,YTop,T).
startsY(X,Y) :-
  tolerance(T), startsY(X,Y,T).

startsYI(X,Y,T) :- startsY(Y,X,T).
startsYI(X,Y) :- startsY(Y,X).

duringY(X,Y,T) :-
  sameSituation(X,Y),
  bottom(X,XBottom), bottom(Y,YBottom),
  top(X,XTop),
  top(Y,YTop),
  greater_with_tolerance(XBottom,YBottom,T), less_with_tolerance(XTop,YTop,T).
duringY(X,Y) :-
  tolerance(T), duringY(X,Y,T).

duringYI(X,Y,T) :- duringY(Y,X,T).
duringYI(X,Y) :- duringY(Y,X).

finishesY(X,Y,T) :-
  sameSituation(X,Y),
  bottom(X,XBottom), bottom(Y,YBottom),
  top(X,XTop),
  top(Y,YTop),
  greater_with_tolerance(XBottom,YBottom,T), equal_with_tolerance(XTop,YTop,T).
finishesY(X,Y) :-
  tolerance(T), finishesY(X,Y,T).

finishesYI(X,Y,T) :- finishesY(Y,X,T).
finishesYI(X,Y) :- finishesY(Y,X).

durY(X,Y,T) :- startsY(X,Y,T),!; duringY(X,Y,T),!; finishesY(X,Y,T),!.
durY(X,Y) :-
  tolerance(T), durY(X,Y,T).
durYI(X,Y,T) :- durY(Y,X,T).
durYI(X,Y) :- durY(Y,X).

equalY(X,Y,T) :-
  sameSituation(X,Y),
  bottom(X,XBottom), bottom(Y,YBottom),
  top(X,XTop),
  top(Y,YTop),
  equal_with_tolerance(XBottom,YBottom,T), equal_with_tolerance(XTop,YTop,T).
equalY(X,Y) :-
  tolerance(T), equalY(X,Y,T).
