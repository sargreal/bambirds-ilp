:- use_module(library(aleph)).
:- aleph.

:- aleph_set(nodes,500).
:- aleph_set(minpos,2).
:- aleph_set(noise,10).
:- aleph_set(interactive, false).
:- aleph_set(check_useless,true).
:- aleph_set(verbosity,0).
% :- aleph_set(search,heuristic).

% :- determination(stable/1,stable/1).
:- determination(stable/1,recursive_supports/2).
:- determination(stable/1,supports/2).
:- determination(stable/1,on/2).
:- determination(stable/1,before/2).
:- determination(stable/1,after/2).
:- determination(stable/1,meets/2).
:- determination(stable/1,meetsI/2).
:- determination(stable/1,mostOverlapsMost/2).
:- determination(stable/1,mostOverlapsMostI/2).
:- determination(stable/1,lessOverlapsMost/2).
:- determination(stable/1,lessOverlapsMostI/2).
:- determination(stable/1,mostOverlapsLess/2).
:- determination(stable/1,mostOverlapsLessI/2).
:- determination(stable/1,lessOverlapsLess/2).
:- determination(stable/1,lessOverlapsLessI/2).
:- determination(stable/1,lessStarts/2).
:- determination(stable/1,lessStartsI/2).
:- determination(stable/1,leftDuring/2).
:- determination(stable/1,leftDuringI/2).
:- determination(stable/1,centerDuring/2).
:- determination(stable/1,centerDuringI/2).
:- determination(stable/1,rightDuring/2).
:- determination(stable/1,rightDuringI/2).
:- determination(stable/1,lessFinishes/2).
:- determination(stable/1,lessFinishesI/2).
:- determination(stable/1,mostFinishes/2).
:- determination(stable/1,mostFinishesI/2).
:- determination(stable/1,equal/2).
:- determination(stable/1,noContact/2).
:- determination(stable/1,surfaceContact/2).
:- determination(stable/1,pointContact/2).
:- determination(stable/1,pointSurfaceContact/2).
:- determination(stable/1,horizontalContact/2).
:- determination(stable/1,verticalContact/2).
:- determination(stable/1,above/2).
:- determination(stable/1,below/2).
:- determination(stable/1,onI/2).
:- determination(stable/1,overlapsY/2).
:- determination(stable/1,overlapsYI/2).
:- determination(stable/1,startsY/2).
:- determination(stable/1,startsYI/2).
:- determination(stable/1,duringY/2).
:- determination(stable/1,duringYI/2).
:- determination(stable/1,finishesY/2).
:- determination(stable/1,finishesYI/2).
:- determination(stable/1,equalY/2).
:- determination(stable/1,object/1).
:- determination(stable/1,fixed/1).
:- determination(stable/1,mobile/1).

:- mode(*,stable(+x)).
:- mode(*,supports(+x,-x)).
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