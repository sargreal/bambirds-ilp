:- module(objects, [
  x/2,
  y/2,
  height/2,
  width/2,
  centerX/2,
  centerY/2,
  object/1,
  object/2,
  sameSituation/2,
  fixed/1,
  mobile/1
]).
:- use_module(data).

object(Obj) :- hasMaterial(Obj,_,_,_,_,_).
object(Sit,Obj) :- obj(Obj), inSituation(Obj,Sit).
fixed(Obj) :- hasMaterial(Obj,hill,_,_,_,_).
mobile(Obj) :- object(Obj), \+ fixed(Obj).

sameSituation(ObjA,ObjB) :- inSituation(ObjA,Sit), inSituation(ObjB,Sit).

x(Obj,X) :- hasMaterial(Obj,_,X,_,_,_).
y(Obj,Y) :- hasMaterial(Obj,_,_,Y,_,_).
width(Obj,W) :- hasMaterial(Obj,_,_,_,W,_).
height(Obj,H) :- hasMaterial(Obj,_,_,_,_,H).
centerX(Obj,C) :- 
  x(Obj,X),
  width(Obj,W),
  C is X + round(W/2).
centerY(Obj,C) :- 
  x(Obj,X),
  height(Obj,H),
  C is X + round(H/2).