% Allens interval algebra
:- module(allen, [
  before/3,
  after/3,
  meets/3,
  meetsI/3,
  overlaps/3,
  overlapsI/3,
  starts/3,
  startsI/3,
  during/3,
  duringI/3,
  finishes/3,
  finishesI/3,
  equal/3
]).
:- use_module(objects).
:- use_module(compare).

start(X,XStart) :- x(X,XStart).
length(X,XLength) :- width(X,XLength).
end(X,XEnd) :- start(X,XStart), length(X,XLength), XEnd is XStart + XLength.


before(X,Y,T) :- 
  sameSituation(R1,R2),
  start(X,XStart), start(Y,YStart),
  end(X,XEnd),
  less_with_tolerance(XEnd,YStart,T).

after(X,Y,T) :- before(Y,X,T).

meets(X,Y,T) :- 
  sameSituation(R1,R2),
  start(X,XStart), start(Y,YStart),
  end(X,XEnd),
  equal_with_tolerance(XEnd,YStart,T).

meetsI(X,Y,T) :- meets(Y,X,T).

overlaps(X,Y,T) :-
  sameSituation(R1,R2),
  start(X,XStart), start(Y,YStart),
  end(X,XEnd),
  end(Y,YEnd),

  less_with_tolerance(XStart,YStart,T),
  greater_with_tolerance(XEnd,YStart,T),
  less_with_tolerance(XEnd,YEnd,T).

overlapsI(X,Y,T) :- overlaps(Y,X,T).

starts(X,Y,T) :-
  sameSituation(R1,R2),
  start(X,XStart), start(Y,YStart),
  end(X,XEnd),
  end(Y,YEnd),
  equal_with_tolerance(XStart,YStart,T), less_with_tolerance(XEnd,YEnd,T).

startsI(X,Y,T) :- starts(Y,X,T).

during(X,Y,T) :-
  sameSituation(R1,R2),
  start(X,XStart), start(Y,YStart),
  end(X,XEnd),
  end(Y,YEnd),
  greater_with_tolerance(XStart,YStart,T), less_with_tolerance(XEnd,YEnd,T).

duringI(X,Y,T) :- during(Y,X,T).

finishes(X,Y,T) :-
  sameSituation(R1,R2),
  start(X,XStart), start(Y,YStart),
  end(X,XEnd),
  end(Y,YEnd),
  greater_with_tolerance(XStart,YStart,T), equal_with_tolerance(XEnd,YEnd,T).

finishesI(X,Y,T) :- finishes(Y,X,T).

dur(X,Y,T) :- starts(X,Y,T),!; during(X,Y,T),!; finishes(X,Y,T),!.
durI(X,Y,T) :- dur(Y,X,T).

equal(X,Y,T) :-
  sameSituation(R1,R2),
  start(X,XStart), start(Y,YStart),
  end(X,XEnd),
  end(Y,YEnd),
  equal_with_tolerance(XStart,YStart,T), equal_with_tolerance(XEnd,YEnd,T).
