:- module(contact, [
	contactRelation/4,
  contactEdges/4,
  contactPointsWithEdges/4,
  contactPointsWithPoints/4,
  contactDimension/4,
  noContact/2,
  surfaceContact/2,
  pointContact/2,
  pointSurfaceContact/2,
  horizontalContact/2,
  verticalContact/2
	]).

:- use_module(points).
:- use_module(edges).
:- use_module(era).
:- use_module(objects).
:- use_module(compare).
:- use_module(constants).
:- use_module(vertical_allen).


% From https://mathworld.wolfram.com/Circle-LineIntersection.html
circleLineIntersects([CX,CY],R,[[LX1,LY1],[LX2,LY2]]) :-
  Dx is LX2 - LX1,
  Dy is LY2 - LY2,
  Fx is LX1 - CX,
  Fy is LY1 - CY,
  DrP is Dx**2 + Dy**2,
  A = DrP,
  A =\= 0,
  B is 2 * (Fx * Dx + Fy * Dy),
  C is Fx**2 + Fy**2 - R**2,
  Discr is B**2 - 4*A*C,
  Discr >= 0,
  RDisrc is sqrt(Discr),
  T1 is (-B - RDisrc) / (2*A),
  T2 is (-B + RDisrc) / (2*A),
  ((T1 >= 0, T1 =< 1, !); (T2 >= 0, T2 =< 1, !)).


dist([X1,Y1],[X2,Y2], Distance) :-
  Distance is sqrt((X2-X1)**2 + (Y2 -Y1)**2).

slope([[X1,Y1],[X2,Y2]], Slope) :-
  XDelta is X2 - X1,
  YDelta is Y2 - Y1,
  Slope is atan(YDelta, XDelta).

slopeDifference(SlopeA,SlopeB,Diff) :-
  FirstDiff is abs(SlopeA-SlopeB),
  (FirstDiff < pi/2 -> 
    Diff = FirstDiff;
    SlopeA > SlopeB ->
      Diff is abs((SlopeA - pi)-SlopeB);
      Diff is abs((SlopeB - pi)-SlopeA)
  ).

parallel(EdgeA,EdgeB,T) :-
  slope(EdgeA, EdgeASlope),
  slope(EdgeB, EdgeBSlope),
  slopeDifference(EdgeASlope,EdgeBSlope,SlopeDiff),
  T > SlopeDiff.

pointDisplacementOnLine([[X1,Y1],[X2,Y2]], [X3,Y3], Displacement) :-
  XDelta is X2 - X1,
  YDelta is Y2 - Y1,
  \+ (XDelta = 0, YDelta = 0),
  Displacement is ((X3 -X1) * XDelta + (Y3 - Y1) * YDelta) / (XDelta**2 + YDelta**2).

distLinePoint([[X1,Y1],[X2,Y2]], [X3,Y3], Distance) :-
  pointDisplacementOnLine([[X1,Y1],[X2,Y2]], [X3,Y3], U),
  XDelta is X2 - X1,
  YDelta is Y2 - Y1,
  (U < 0 -> 
    dist([X3,Y3],[X1,Y1],Distance);
    (U > 1 -> dist([X3,Y3],[X2,Y2],Distance);
      (
        PX is X1 + U * XDelta,
        PY is Y1 + U * YDelta,
        dist([X3,Y3],[PX,PY],Distance)
      )
    )
  ).

minDistEdges([PointA1,PointA2],[PointB1,PointB2],Distance) :-
  distLinePoint([PointA1,PointA2], PointB1, DistanceB1),
  distLinePoint([PointA1,PointA2], PointB2, DistanceB2),
  distLinePoint([PointB1,PointB2], PointA1, DistanceA1),
  distLinePoint([PointB1,PointB2], PointA2, DistanceA2),
  min_list([DistanceB1, DistanceB2, DistanceA1, DistanceA2], Distance).


continuingEdges([PointA1,PointA2],[PointB1,PointB2],T) :-
  parallel([PointA1,PointA2],[PointB1,PointB2], 0.1),
  dist(PointA1,PointA2,Len),
  DMin is T/Len + 1,
  (dist(PointA1,PointB1,D), D =< T -> 
    pointDisplacementOnLine([PointA2,PointA1],PointB2,Displacement);
  dist(PointA1,PointB2,D), D =< T ->
    pointDisplacementOnLine([PointA2,PointA1],PointB1,Displacement);
  dist(PointA2,PointB1,D), D =< T ->
    pointDisplacementOnLine([PointA1,PointA2],PointB2,Displacement);
  dist(PointA2,PointB2,D), D =< T ->
    pointDisplacementOnLine([PointA1,PointA2],PointB1,Displacement);
    false
  ),
  Displacement > DMin.
  

contactEdges(R1,R2, T, [R1Edge, R2Edge]) :-
  sameSituation(R1,R2),
  edges(R1,R1Edges),
  edges(R2,R2Edges),
  member(R1Edge, R1Edges),
  member(R2Edge, R2Edges),
  parallel(R1Edge,R2Edge, 0.1),
  \+ continuingEdges(R1Edge,R2Edge,T),
  minDistEdges(R1Edge, R2Edge, Distance),
  Distance =< T.
  

contactPointsWithEdges(R1,R2,T,[Point, Edge]) :-
  sameSituation(R1,R2),
  points(R1,R1Points),
  edges(R2, R2Edges),
  member(Point, R1Points),
  member(Edge, R2Edges),
  circleLineIntersects(Point,T,Edge).

contactPointsWithPoints(R1,R2,T,[R1Point, R2Point]) :-
  sameSituation(R1,R2),
  points(R1,R1Points),
  points(R2, R2Points),
  member(R1Point, R1Points),
  member(R2Point, R2Points),
  dist(R1Point, R2Point, Distance),
  Distance < T.

contactRelation(R1,R2, n, T) :-
  sameSituation(R1,R2),
  (
    before(R1,R2,T);
    after(R1,R2,T);
    above(R1,R2,T);
    below(R1,R2,T)
  ), !.

contactRelation(R1, R2, ss, T) :-
  sameSituation(R1,R2),
  contactEdges(R1,R2,T,_),
  !.

contactRelation(R1, R2, ps, T) :-
  sameSituation(R1,R2),
  (contactPointsWithEdges(R1,R2,T,_);
  contactPointsWithEdges(R2,R1,T,_)),
  !.

contactRelation(R1, R2, pp, T) :-
  sameSituation(R1,R2),
  contactPointsWithPoints(R1,R2,T,_), !.

noContact(R1,R2) :- tolerance(T), contactRelation(R1,R2, n, T).
surfaceContact(R1,R2) :- tolerance(T), contactRelation(R1,R2, ss, T).
pointContact(R1,R2) :- tolerance(T), contactRelation(R1,R2, pp, T).
pointSurfaceContact(R1,R2) :- tolerance(T), contactRelation(R1,R2, ps, T).

contactDimension(R1, R2, D, T) :-
  sameSituation(R1,R2),
  contactRelation(R1, R2, R, T),
  (R = n -> D = n;
    (once(meets(R1,R2,T) ; meetsI(R1,R2,T)) -> 
      D = hc; 
      D = vc
    )
  ), !.


horizontalContact(R1, R2) :- tolerance(T), contactDimension(R1,R2, hc, T).
verticalContact(R1, R2) :- tolerance(T), contactDimension(R1,R2, vc, T).
