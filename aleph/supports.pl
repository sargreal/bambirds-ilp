:- use_module(library(aleph)).
:- aleph.

:- aleph_set(nodes,500).
:- aleph_set(minpos,2).
:- aleph_set(noise,10).
:- aleph_set(interactive, false).
:- aleph_set(check_useless,true).
:- aleph_set(verbosity,0).
% :- aleph_set(search,heuristic).

:- determination(supports/2,on/2).
:- determination(supports/2,before/2).
:- determination(supports/2,after/2).
:- determination(supports/2,meets/2).
:- determination(supports/2,meetsI/2).
:- determination(supports/2,mostOverlapsMost/2).
:- determination(supports/2,mostOverlapsMostI/2).
:- determination(supports/2,lessOverlapsMost/2).
:- determination(supports/2,lessOverlapsMostI/2).
:- determination(supports/2,mostOverlapsLess/2).
:- determination(supports/2,mostOverlapsLessI/2).
:- determination(supports/2,lessOverlapsLess/2).
:- determination(supports/2,lessOverlapsLessI/2).
:- determination(supports/2,lessStarts/2).
:- determination(supports/2,lessStartsI/2).
:- determination(supports/2,leftDuring/2).
:- determination(supports/2,leftDuringI/2).
:- determination(supports/2,centerDuring/2).
:- determination(supports/2,centerDuringI/2).
:- determination(supports/2,rightDuring/2).
:- determination(supports/2,rightDuringI/2).
:- determination(supports/2,lessFinishes/2).
:- determination(supports/2,lessFinishesI/2).
:- determination(supports/2,mostFinishes/2).
:- determination(supports/2,mostFinishesI/2).
:- determination(supports/2,equal/2).
:- determination(supports/2,noContact/2).
:- determination(supports/2,surfaceContact/2).
:- determination(supports/2,pointContact/2).
:- determination(supports/2,pointSurfaceContact/2).
:- determination(supports/2,horizontalContact/2).
:- determination(supports/2,verticalContact/2).
:- determination(supports/2,above/2).
:- determination(supports/2,below/2).
:- determination(supports/2,onI/2).
:- determination(supports/2,overlapsY/2).
:- determination(supports/2,overlapsYI/2).
:- determination(supports/2,startsY/2).
:- determination(supports/2,startsYI/2).
:- determination(supports/2,duringY/2).
:- determination(supports/2,duringYI/2).
:- determination(supports/2,finishesY/2).
:- determination(supports/2,finishesYI/2).
:- determination(supports/2,equalY/2).
:- determination(supports/2,object/1).
:- determination(supports/2,fixed/1).

:- mode(*,supports(+x,+x)).
:- mode(*,before(+x,-x)).
% :- mode(*,after(+x,-x)).
:- mode(*,meets(+x,-x)).
% :- mode(*,meetsI(+x,-x)).
:- mode(*,mostOverlapsMost(+x,-x)).
% :- mode(*,mostOverlapsMostI(+x,-x)).
:- mode(*,lessOverlapsMost(+x,-x)).
% :- mode(*,lessOverlapsMostI(+x,-x)).
:- mode(*,mostOverlapsLess(+x,-x)).
% :- mode(*,mostOverlapsLessI(+x,-x)).
:- mode(*,lessOverlapsLess(+x,-x)).
% :- mode(*,lessOverlapsLessI(+x,-x)).
:- mode(*,lessStarts(+x,-x)).
% :- mode(*,lessStartsI(+x,-x)).
:- mode(*,leftDuring(+x,-x)).
% :- mode(*,leftDuringI(+x,-x)).
:- mode(*,centerDuring(+x,-x)).
% :- mode(*,centerDuringI(+x,-x)).
:- mode(*,rightDuring(+x,-x)).
% :- mode(*,rightDuringI(+x,-x)).
:- mode(*,lessFinishes(+x,-x)).
% :- mode(*,lessFinishesI(+x,-x)).
:- mode(*,mostFinishes(+x,-x)).
% :- mode(*,mostFinishesI(+x,-x)).
:- mode(*,equal(+x,-x)).
:- mode(*,noContact(+x,-x)).
:- mode(*,surfaceContact(+x,-x)).
:- mode(*,pointContact(+x,-x)).
:- mode(*,pointSurfaceContact(+x,-x)).
:- mode(*,horizontalContact(+x,-x)).
:- mode(*,verticalContact(+x,-x)).
:- mode(*,above(+x,-x)).
% :- mode(*,below(+x,-x)).
:- mode(*,on(+x,-x)).
% :- mode(*,onI(+x,-x)).
:- mode(*,overlapsY(+x,-x)).
% :- mode(*,overlapsYI(+x,-x)).
:- mode(*,startsY(+x,-x)).
% :- mode(*,startsYI(+x,-x)).
:- mode(*,duringY(+x,-x)).
% :- mode(*,duringYI(+x,-x)).
:- mode(*,finishesY(+x,-x)).
% :- mode(*,finishesYI(+x,-x)).
:- mode(*,equalY(+x,-x)).
:- mode(*,object(-x)).
:- mode(*,fixed(+x)).


:- begin_bg.

:- use_module('<ROOT>/src/era').
:- use_module('<ROOT>/src/contact').
:- use_module('<ROOT>/src/objects').
:- use_module('<ROOT>/src/data').

:- load_data('<BACKGROUND>').

:- end_bg.

:-begin_in_pos.

<POSITIVE>

:-end_in_pos.

:-begin_in_neg.

<NEGATIVE>

:-end_in_neg.

:-aleph_read_all.