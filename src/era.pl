% Extended Rectangle Algebra
:- module(era, [
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
  mostStarts/3,
  mostStartsI/3,
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
  equal/3,
  before/2,
  after/2,
  meets/2,
  meetsI/2,
  mostOverlapsMost/2,
  mostOverlapsMostI/2,
  lessOverlapsMost/2,
  lessOverlapsMostI/2,
  mostOverlapsLess/2,
  mostOverlapsLessI/2,
  lessOverlapsLess/2,
  lessOverlapsLessI/2,
  lessStarts/2,
  lessStartsI/2,
  mostStarts/2,
  mostStartsI/2,
  leftDuring/2,
  leftDuringI/2,
  centerDuring/2,
  centerDuringI/2,
  rightDuring/2,
  rightDuringI/2,
  lessFinishes/2,
  lessFinishesI/2,
  mostFinishes/2,
  mostFinishesI/2,
  equal/2
]).
:- use_module(objects).
:- use_module(compare).
:- use_module(constants).

left(X,XLeft) :- x(X,XLeft).
right(X,XRight) :- left(X,XLeft), width(X,XWidth),
  XRight is XLeft + XWidth.

before(X,Y,T) :- 
  sameSituation(X,Y),
  left(Y,YLeft), right(X,XRight),
  less_with_tolerance(XRight,YLeft,T).
before(X,Y) :-
  tolerance(T), before(X,Y,T).

after(X,Y,T) :- before(Y,X,T).
after(X,Y) :- before(Y,X).

meets(X,Y,T) :- 
  sameSituation(X,Y),
  left(Y,YLeft), right(X,XRight),
  equal_with_tolerance(XRight,YLeft,T).
meets(X,Y) :-
  tolerance(T), meets(X,Y,T).

meetsI(X,Y,T) :- meets(Y,X,T).
meetsI(X,Y) :- meets(Y,X).

mostOverlapsMost(X,Y,T) :-
  sameSituation(X,Y),
  left(X,XLeft), left(Y,YLeft), centerX(X,XCenter), centerX(Y,YCenter), right(X,XRight), right(Y,YRight),
  less_with_tolerance(XLeft,YLeft,T),
  greater_equal_with_tolerance(XCenter,YLeft,T),
  greater_equal_with_tolerance(XRight,YCenter,T),
  less_with_tolerance(XRight,YRight,T), !.
mostOverlapsMost(X,Y) :-
  tolerance(T), mostOverlapsMost(X,Y,T).

mostOverlapsMostI(X,Y,T) :- mostOverlapsMost(Y,X,T).
mostOverlapsMostI(X,Y) :- mostOverlapsMost(Y,X).

mostOverlapsLess(X,Y,T) :-
  sameSituation(X,Y),
  left(X,XLeft), left(Y,YLeft), centerX(X,XCenter), centerX(Y,YCenter), right(X,XRight),
  less_with_tolerance(XLeft,YLeft,T),
  greater_equal_with_tolerance(XCenter,YLeft,T),
  less_with_tolerance(XRight,YCenter,T),!.
mostOverlapsLess(X,Y) :-
  tolerance(T), mostOverlapsLess(X,Y,T).

mostOverlapsLessI(X,Y,T) :- mostOverlapsLess(Y,X,T).
mostOverlapsLessI(X,Y) :- mostOverlapsLess(Y,X).

lessOverlapsMost(X,Y,T) :-
  sameSituation(X,Y),
  left(Y,YLeft), centerX(X,XCenter), centerX(Y,YCenter), right(X,XRight), right(Y,YRight),
  less_with_tolerance(XCenter,YLeft,T),
  greater_equal_with_tolerance(XRight,YCenter,T),
  less_with_tolerance(XRight,YRight,T),!.
lessOverlapsMost(X,Y) :-
  tolerance(T), lessOverlapsMost(X,Y,T).

lessOverlapsMostI(X,Y,T) :- lessOverlapsMost(Y,X,T).
lessOverlapsMostI(X,Y) :- lessOverlapsMost(Y,X).

lessOverlapsLess(X,Y,T) :-
  sameSituation(X,Y),
  left(Y,YLeft), centerX(X,XCenter), centerX(Y,YCenter), right(X,XRight),
  less_with_tolerance(XCenter,YLeft,T),
  greater_with_tolerance(XRight,YLeft,T),
  less_with_tolerance(XRight,YCenter,T),!.
lessOverlapsLess(X,Y) :-
  tolerance(T), lessOverlapsLess(X,Y,T).

lessOverlapsLessI(X,Y,T) :- lessOverlapsLess(Y,X,T).
lessOverlapsLessI(X,Y) :- lessOverlapsLess(Y,X).


mostStarts(X,Y,T) :-
  sameSituation(X,Y),
  left(X,XLeft), left(Y,YLeft), centerX(Y,YCenter), right(X,XRight), right(Y,YRight),
  equal_with_tolerance(XLeft,YLeft,T),
  greater_equal_with_tolerance(XRight,YCenter,T),
  less_with_tolerance(XRight,YRight,T).
mostStarts(X,Y) :-
  tolerance(T), mostStarts(X,Y,T).

mostStartsI(X,Y,T) :- mostStarts(Y,X,T).
mostStartsI(X,Y) :- mostStarts(Y,X).

lessStarts(X,Y,T) :-
  sameSituation(X,Y),
  left(X,XLeft), left(Y,YLeft), centerX(Y,YCenter), right(X,XRight),
  equal_with_tolerance(XLeft,YLeft,T),
  greater_with_tolerance(XRight,YLeft,T),
  less_with_tolerance(XRight,YCenter,T).
lessStarts(X,Y) :-
  tolerance(T), lessStarts(X,Y,T).

lessStartsI(X,Y,T) :- lessStarts(Y,X,T).
lessStartsI(X,Y) :- lessStarts(Y,X).


leftDuring(X,Y,T) :-
  sameSituation(X,Y),
  left(X,XLeft), left(Y,YLeft), centerX(Y,YCenter), right(X,XRight),
  greater_with_tolerance(XLeft,YLeft,T),
  less_with_tolerance(XRight,YCenter,T),!.
leftDuring(X,Y) :-
  tolerance(T), leftDuring(X,Y,T).

leftDuringI(X,Y,T) :- leftDuring(Y,X,T).
leftDuringI(X,Y) :- leftDuring(Y,X).

centerDuring(X,Y,T) :-
  sameSituation(X,Y),
  left(X,XLeft), left(Y,YLeft), centerX(Y,YCenter), right(X,XRight), right(Y,YRight),
  greater_with_tolerance(XLeft,YLeft,T),
  less_with_tolerance(XLeft,YCenter,T),
  greater_with_tolerance(XRight, YCenter, T),
  less_with_tolerance(XRight,YRight,T).
centerDuring(X,Y) :-
  tolerance(T), centerDuring(X,Y,T).

centerDuringI(X,Y,T) :- centerDuring(Y,X,T).
centerDuringI(X,Y) :- centerDuring(Y,X).

rightDuring(X,Y,T) :-
  sameSituation(X,Y),
  left(X,XLeft), centerX(Y,YCenter), right(X,XRight), right(Y,YRight),
  greater_equal_with_tolerance(XLeft,YCenter,T),
  less_with_tolerance(XRight,YRight,T),!.
rightDuring(X,Y) :-
  tolerance(T), rightDuring(X,Y,T).

rightDuringI(X,Y,T) :- rightDuring(Y,X,T).
rightDuringI(X,Y) :- rightDuring(Y,X).

mostFinishes(X,Y,T) :-
  sameSituation(X,Y),
  left(X,XLeft), left(Y,YLeft), centerX(Y,YCenter), right(X,XRight), right(Y,YRight),
  greater_with_tolerance(XLeft,YLeft,T),
  less_equal_with_tolerance(XLeft,YCenter,T),
  equal_with_tolerance(XRight,YRight,T).
mostFinishes(X,Y) :-
  tolerance(T), mostFinishes(X,Y,T).

mostFinishesI(X,Y,T) :- mostFinishes(Y,X,T).
mostFinishesI(X,Y) :- mostFinishes(Y,X).

lessFinishes(X,Y,T) :-
  sameSituation(X,Y),
  left(X,XLeft), centerX(Y,YCenter), right(X,XRight), right(Y,YRight),
  greater_with_tolerance(XLeft,YCenter,T),
  less_with_tolerance(XLeft,YRight,T),
  equal_with_tolerance(XRight,YRight,T).
lessFinishes(X,Y) :-
  tolerance(T), lessFinishes(X,Y,T).

lessFinishesI(X,Y,T) :- lessFinishes(Y,X,T).
lessFinishesI(X,Y) :- lessFinishes(Y,X).

equal(X,Y,T) :-
  sameSituation(X,Y),
  left(X,XLeft), left(Y,YLeft), right(X,XRight), right(Y,YRight),
  equal_with_tolerance(XLeft,YLeft,T), equal_with_tolerance(XRight,YRight,T).
equal(X,Y) :-
  tolerance(T), equal(X,Y,T).
