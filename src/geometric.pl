:- module(geometric, [
  rot_shift/5
]).

rot_shift(_Angle, _CX, _CY, [], []).
rot_shift(Angle, CX, CY, [[X,Y] | PS], [[XRS, YRS] | PRS]) :-
	XR is X*cos(Angle) - Y*sin(Angle),
	YR is X*sin(Angle) + Y*cos(Angle),
	XRS is XR+CX,
	YRS is YR+CY,
	rot_shift(Angle, CX, CY, PS, PRS).