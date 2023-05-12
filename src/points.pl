% Get corner points for objects
:- module(points, [points/2, point/2]).
:- use_module(data).

rot_shift(_Angle, _CX, _CY, [], []).
rot_shift(Angle, CX, CY, [[X,Y] | PS], [[XRS, YRS] | PRS]) :-
	XR is X*cos(Angle) - Y*sin(Angle),
	YR is X*sin(Angle) + Y*cos(Angle),
	XRS is XR+CX,
	YRS is YR+CY,
	rot_shift(Angle, CX, CY, PS, PRS).

points(Object,Points) :-
  findall(Point, point(Object,Point), Points).

point(Object, Point):-
  shape(Object, Shape, X, Y, _, Spec),
  point(Shape, X, Y, Spec, Point).

point(ball, X, Y, [R], Point) :-
  between(0, 7, K),
  TX is X + ((R) * cos(K * (pi/4) + pi/8)),
  TY is Y + ((R) * sin(K * (pi/4) + pi/8)),
  Point = [TX, TY].
point(rect, X, Y, [W, H, A], Point) :-
  XRa is (0.5*H),
  YRa is (0.5*W),
  rot_shift(A, X, Y, [[-XRa,-YRa], [-XRa,YRa], [XRa,YRa], [XRa,-YRa]], Points),
  member(Point, Points).
point(poly, _, _, [_NPoints | Points], Point) :-
  member(Point, Points).