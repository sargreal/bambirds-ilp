:- module(angrybirds, [
  birdInSling/1,
  blackBird/1,
  blueBird/1,
  redBird/1,
  yellowBird/1,
  whiteBird/1,
  wood/1,
  stone/1,
  ice/1,
  pig/1,
  collapsesAway/2,
  collapsesTowards/2,
  smallSize/1,
  mediumSize/1,
  largeSize/1,
  formBar/1,
  formBlock/1,
  formCircle/1,
  formPoly/1,
  orientedVertically/1,
  orientedHorizontally/1,
  hill/1
]).
:- use_module(data).
:- use_module(objects).

birdInSling(Bird) :- birdOrder(Bird,0).
blackBird(Bird) :- bird(Bird), hasColor(Bird,black).
blueBird(Bird) :- bird(Bird), hasColor(Bird,blue).
redBird(Bird) :- bird(Bird), hasColor(Bird,red).
yellowBird(Bird) :- bird(Bird), hasColor(Bird,yellow).
whiteBird(Bird) :- bird(Bird), hasColor(Bird,white).
wood(Object) :- hasMaterial(Object,wood,_,_,_,_).
stone(Object) :- hasMaterial(Object,stone,_,_,_,_).
ice(Object) :- hasMaterial(Object,ice,_,_,_,_).
pig(Object) :- pig(Object,_,_,_,_).
collapsesAway(Struct1,Struct2) :- collapsesInDirection(Struct1,Struct2,away).
collapsesTowards(Struct1,Struct2) :- collapsesInDirection(Struct1,Struct2,towards).
smallSize(Object) :- object(Object), hasSize(Object,small).
mediumSize(Object) :- object(Object), hasSize(Object,medium).
largeSize(Object) :- object(Object), hasSize(Object,large).
formBar(Object) :- hasForm(Object,bar).
formBlock(Object) :- hasForm(Object,block).
formCircle(Object) :- object(Object),shape(Object, ball, _, _, _,_).
formPoly(Object) :- shape(Object, poly, _, _, _,_).
orientedVertically(Object) :- hasOrientation(Object,vertical).
orientedHorizontally(Object) :- hasOrientation(Object,horizontal).
hill(Object) :- hill(Object,_,_,_,_).