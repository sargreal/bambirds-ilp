% Extended Rectangle Algebra
:- module(allen, [
  before/3,
  after/3,
  meets/3,
  meetsI/3,
  mostOverlapsMost/3,
  mostOverlapsMostI/3,
  lessOverlapsMost/3,
  lessOverlapsMostI/3,
  mostOverlapsLess/3,
  mostOverlapsLessI/3,
  lessOverlapsLess/3,
  lessOverlapsLessI/3,
  lessStarts/3,
  lessStartsI/3,
  leftDuring/3,
  leftDuringI/3,
  centerDuring/3,
  centerDuringI/3,
  rightDuring/3,
  rightDuringI/3,
  lessFinishes/3,
  lessFinishesI/3,
  mostFinishes/3,
  mostFinishesI/3,
  equal/3
]).
:- use_module(objects).
:- use_module(compare).

before(X,Y,T) :- 
  x(X,XStart), x(Y,YStart), width(X,XWidth),
  XEnd is XStart + XWidth,
  less_with_tolerance(XEnd,YStart,T).

after(X,Y,T) :- before(Y,X,T).

meets(X,Y,T) :- 
  x(X,XStart), x(Y,YStart), width(X,XWidth),
  XEnd is XStart + XWidth,
  equal_with_tolerance(XEnd,YStart,T).

meetsI(X,Y,T) :- meets(Y,X,T).

mostOverlapsMost(X,Y,T) :-
  x(X,XStart), x(Y,YStart), width(X,XWidth), width(Y,YWidth), centerX(X,XCenter), centerX(Y,YCenter),
  XEnd is XStart + XWidth,
  YEnd is YStart + YWidth,
  less_with_tolerance(XStart,YStart,T),
  greater_equal_with_tolerance(XCenter,YStart,T),
  greater_equal_with_tolerance(XEnd,YCenter,T),
  less_with_tolerance(XEnd,YEnd,T), !.

mostOverlapsMostI(X,Y,T) :- mostOverlapsMost(Y,X,T).

mostOverlapsLess(X,Y,T) :-
  x(X,XStart), x(Y,YStart), width(X,XWidth), centerX(X,XCenter), centerX(Y,YCenter),
  XEnd is XStart + XWidth,
  less_with_tolerance(XStart,YStart,T),
  greater_equal_with_tolerance(XCenter,YStart,T),
  less_with_tolerance(XEnd,YCenter,T),!.

mostOverlapsLessI(X,Y,T) :- mostOverlapsLess(Y,X,T).

lessOverlapsMost(X,Y,T) :-
  x(X,XStart), x(Y,YStart), width(X,XWidth), width(Y,YWidth), centerX(X,XCenter), centerX(Y,YCenter),
  XEnd is XStart + XWidth,
  YEnd is YStart + YWidth,
  less_with_tolerance(XCenter,YStart,T),
  greater_equal_with_tolerance(XEnd,YCenter,T),
  less_with_tolerance(XEnd,YEnd,T),!.

lessOverlapsMostI(X,Y,T) :- lessOverlapsMost(Y,X,T).

lessOverlapsLess(X,Y,T) :-
  x(X,XStart), x(Y,YStart), width(X,XWidth), centerX(X,XCenter), centerX(Y,YCenter),
  XEnd is XStart + XWidth,
  less_with_tolerance(XCenter,YStart,T),
  greater_with_tolerance(XEnd,YStart,T),
  less_with_tolerance(XEnd,YCenter,T),!.

lessOverlapsLessI(X,Y,T) :- lessOverlapsLess(Y,X,T).


mostStarts(X,Y,T) :-
  x(X,XStart), x(Y,YStart), width(X,XWidth), width(Y,YWidth), centerX(Y,YCenter),
  XEnd is XStart + XWidth,
  YEnd is YStart + YWidth,
  equal_with_tolerance(XStart,YStart,T),
  greater_equal_with_tolerance(XEnd,YCenter,T),
  less_with_tolerance(XEnd,YEnd,T).

mostStartsI(X,Y,T) :- mostStarts(Y,X,T).

lessStarts(X,Y,T) :-
  x(X,XStart), x(Y,YStart), width(X,XWidth), centerX(Y,YCenter),
  XEnd is XStart + XWidth,
  equal_with_tolerance(XStart,YStart,T),
  greater_with_tolerance(XEnd,YStart,T),
  less_with_tolerance(XEnd,YCenter,T).

lessStartsI(X,Y,T) :- lessStarts(Y,X,T).


leftDuring(X,Y,T) :-
  x(X,XStart), x(Y,YStart), width(X,XWidth), centerX(Y,YCenter),
  XEnd is XStart + XWidth,
  greater_with_tolerance(XStart,YStart,T),
  less_with_tolerance(XEnd,YCenter,T),!.

leftDuringI(X,Y,T) :- leftDuring(Y,X,T).

centerDuring(X,Y,T) :-
  x(X,XStart), x(Y,YStart), width(X,XWidth), width(Y,YWidth), centerX(Y,YCenter),
  XEnd is XStart + XWidth,
  YEnd is YStart + YWidth,
  greater_with_tolerance(XStart,YStart,T),
  less_with_tolerance(XStart,YCenter,T),
  greater_with_tolerance(XEnd, YCenter, T),
  less_with_tolerance(XEnd,YEnd,T).

centerDuringI(X,Y,T) :- centerDuring(Y,X,T).

rightDuring(X,Y,T) :-
  x(X,XStart), x(Y,YStart), width(X,XWidth), width(Y,YWidth), centerX(Y,YCenter),
  XEnd is XStart + XWidth,
  YEnd is YStart + YWidth,
  greater_equal_with_tolerance(XStart,YCenter,T),
  less_with_tolerance(XEnd,YEnd,T),!.

rightDuringI(X,Y,T) :- rightDuring(Y,X,T).

mostFinishes(X,Y,T) :-
  x(X,XStart), x(Y,YStart), width(X,XWidth), width(Y,YWidth), centerX(Y,YCenter),
  XEnd is XStart + XWidth,
  YEnd is YStart + YWidth,
  greater_with_tolerance(XStart,YStart,T),
  less_equal_with_tolerance(XStart,YCenter,T),
  equal_with_tolerance(XEnd,YEnd,T).

mostFinishesI(X,Y,T) :- mostFinishes(Y,X,T).

lessFinishes(X,Y,T) :-
  x(X,XStart), x(Y,YStart), width(X,XWidth), width(Y,YWidth), centerX(Y,YCenter),
  XEnd is XStart + XWidth,
  YEnd is YStart + YWidth,
  greater_with_tolerance(XStart,YCenter,T),
  less_with_tolerance(XStart,YEnd,T),
  equal_with_tolerance(XEnd,YEnd,T).

lessFinishesI(X,Y,T) :- lessFinishes(Y,X,T).

equal(X,Y,T) :-
  x(X,XStart), x(Y,YStart), width(X,XWidth), width(Y,YWidth),
  XEnd is XStart + XWidth,
  YEnd is YStart + YWidth,
  equal_with_tolerance(XStart,YStart,T), equal_with_tolerance(XEnd,YEnd,T).
