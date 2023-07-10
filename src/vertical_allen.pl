% Allens interval algebra
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

start(X,XStart) :- y(X,XStart).
len(X,XLength) :- height(X,XLength).
end(X,XEnd) :- start(X,XStart), len(X,XLength), XEnd is XStart + XLength.


below(X,Y,T) :- 
  sameSituation(X,Y),
  end(X,XEnd),
  start(Y,YStart),
  less_with_tolerance(XEnd,YStart,T).
below(X,Y) :-
  threshold(T), below(X,Y,T).

above(X,Y,T) :- below(Y,X,T).
above(X,Y) :- below(Y,X).

on(X,Y,T) :- 
  sameSituation(X,Y),
  start(X,XStart),
  end(Y,YEnd),
  equal_with_tolerance(XStart,YEnd,T).
on(X,Y) :-
  threshold(T), on(X,Y,T).

onI(X,Y,T) :- on(Y,X,T).
onI(X,Y) :- on(Y,X).

overlapsY(X,Y,T) :-
  sameSituation(X,Y),
  start(X,XStart), start(Y,YStart),
  end(X,XEnd),
  end(Y,YEnd),
  less_with_tolerance(XStart,YStart,T),
  greater_with_tolerance(XEnd,YStart,T),
  less_with_tolerance(XEnd,YEnd,T).
overlapsY(X,Y) :-
  threshold(T), overlapsY(X,Y,T).

overlapsYI(X,Y,T) :- overlapsY(Y,X,T).
overlapsYI(X,Y) :- overlapsY(Y,X).

startsY(X,Y,T) :-
  sameSituation(X,Y),
  start(X,XStart), start(Y,YStart),
  end(X,XEnd),
  end(Y,YEnd),
  equal_with_tolerance(XStart,YStart,T), less_with_tolerance(XEnd,YEnd,T).
startsY(X,Y) :-
  threshold(T), startsY(X,Y,T).

startsYI(X,Y,T) :- startsY(Y,X,T).
startsYI(X,Y) :- startsY(Y,X).

duringY(X,Y,T) :-
  sameSituation(X,Y),
  start(X,XStart), start(Y,YStart),
  end(X,XEnd),
  end(Y,YEnd),
  greater_with_tolerance(XStart,YStart,T), less_with_tolerance(XEnd,YEnd,T).
duringY(X,Y) :-
  threshold(T), duringY(X,Y,T).

duringYI(X,Y,T) :- duringY(Y,X,T).
duringYI(X,Y) :- duringY(Y,X).

finishesY(X,Y,T) :-
  sameSituation(X,Y),
  start(X,XStart), start(Y,YStart),
  end(X,XEnd),
  end(Y,YEnd),
  greater_with_tolerance(XStart,YStart,T), equal_with_tolerance(XEnd,YEnd,T).
finishesY(X,Y) :-
  threshold(T), finishesY(X,Y,T).

finishesYI(X,Y,T) :- finishesY(Y,X,T).
finishesYI(X,Y) :- finishesY(Y,X).

durY(X,Y,T) :- startsY(X,Y,T),!; duringY(X,Y,T),!; finishesY(X,Y,T),!.
durY(X,Y) :-
  threshold(T), durY(X,Y,T).
durYI(X,Y,T) :- durY(Y,X,T).
durYI(X,Y) :- durY(Y,X).

equalY(X,Y,T) :-
  sameSituation(X,Y),
  start(X,XStart), start(Y,YStart),
  end(X,XEnd),
  end(Y,YEnd),
  equal_with_tolerance(XStart,YStart,T), equal_with_tolerance(XEnd,YEnd,T).
equalY(X,Y) :-
  threshold(T), equalY(X,Y,T).
