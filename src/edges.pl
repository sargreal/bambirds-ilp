% Get edges for objects
:- module(edges, [edges/2]).
:- use_module(points).

edges(Object,Edges) :-
  points(Object,Points),
  createEdges(Points,Points,Edges).

createEdges(_,[], []).
createEdges([[X2,Y2]|_], [[X1,Y1]], [[[X1,Y1],[X2,Y2]]]).
createEdges(OriginalPoints, [[X1,Y1],[X2,Y2]|Rest], [[[X1,Y1],[X2,Y2]]|Edges]) :-
  createEdges(OriginalPoints,[[X2,Y2]|Rest], Edges).
