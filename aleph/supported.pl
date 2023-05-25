learning_set("1").

get_learning_file(Path,File) :- learning_set(Set), string_concat(Path, Set, File).

:- use_module(library(aleph)).
:- aleph.

:- determination(supported/1,before/2).
:- determination(supported/1,after/2).
:- determination(supported/1,meets/2).
:- determination(supported/1,meetsI/2).
:- determination(supported/1,mostOverlapsMost/2).
:- determination(supported/1,mostOverlapsMostI/2).
:- determination(supported/1,lessOverlapsMost/2).
:- determination(supported/1,lessOverlapsMostI/2).
:- determination(supported/1,mostOverlapsLess/2).
:- determination(supported/1,mostOverlapsLessI/2).
:- determination(supported/1,lessOverlapsLess/2).
:- determination(supported/1,lessOverlapsLessI/2).
:- determination(supported/1,lessStarts/2).
:- determination(supported/1,lessStartsI/2).
:- determination(supported/1,leftDuring/2).
:- determination(supported/1,leftDuringI/2).
:- determination(supported/1,centerDuring/2).
:- determination(supported/1,centerDuringI/2).
:- determination(supported/1,rightDuring/2).
:- determination(supported/1,rightDuringI/2).
:- determination(supported/1,lessFinishes/2).
:- determination(supported/1,lessFinishesI/2).
:- determination(supported/1,mostFinishes/2).
:- determination(supported/1,mostFinishesI/2).
:- determination(supported/1,equal/2).
:- determination(supported/1,noContact/2).
:- determination(supported/1,surfaceContact/2).
:- determination(supported/1,pointContact/2).
:- determination(supported/1,pointSurfaceContact/2).
:- determination(supported/1,horizontalContact/2).
:- determination(supported/1,verticalContact/2).
:- determination(supported/1,above/2).
:- determination(supported/1,below/2).
:- determination(supported/1,object/1).
:- determination(supported/1,fixed/1).

:- mode(*,before(+x,+x)).
:- mode(*,after(+x,+x)).
:- mode(*,meets(+x,+x)).
:- mode(*,meetsI(+x,+x)).
:- mode(*,mostOverlapsMost(+x,+x)).
:- mode(*,mostOverlapsMostI(+x,+x)).
:- mode(*,lessOverlapsMost(+x,+x)).
:- mode(*,lessOverlapsMostI(+x,+x)).
:- mode(*,mostOverlapsLess(+x,+x)).
:- mode(*,mostOverlapsLessI(+x,+x)).
:- mode(*,lessOverlapsLess(+x,+x)).
:- mode(*,lessOverlapsLessI(+x,+x)).
:- mode(*,lessStarts(+x,+x)).
:- mode(*,lessStartsI(+x,+x)).
:- mode(*,leftDuring(+x,+x)).
:- mode(*,leftDuringI(+x,+x)).
:- mode(*,centerDuring(+x,+x)).
:- mode(*,centerDuringI(+x,+x)).
:- mode(*,rightDuring(+x,+x)).
:- mode(*,rightDuringI(+x,+x)).
:- mode(*,lessFinishes(+x,+x)).
:- mode(*,lessFinishesI(+x,+x)).
:- mode(*,mostFinishes(+x,+x)).
:- mode(*,mostFinishesI(+x,+x)).
:- mode(*,equal(+x,+x)).
:- mode(*,noContact(+x,+x)).
:- mode(*,surfaceContact(+x,+x)).
:- mode(*,pointContact(+x,+x)).
:- mode(*,pointSurfaceContact(+x,+x)).
:- mode(*,horizontalContact(+x,+x)).
:- mode(*,verticalContact(+x,+x)).
:- mode(*,above(+x,+x)).
:- mode(*,below(+x,+x)).
:- mode(*,object(-x)).
:- mode(*,fixed(+x)).
:- mode(*,supported(+x)).

:-begin_bg.

:- use_module('../src/era').
:- use_module('../src/contact').
:- use_module('../src/objects').
:- use_module('../src/data').


:- get_learning_file('../data/learning/bg', BG), load_data(BG).

:-end_bg.

:-begin_in_pos.

:- get_learning_file('../data/learning/pos', POS), consult(POS).

:-end_in_pos.

:-begin_in_neg.

:- get_learning_file('../data/learning/neg', NEG), consult(NEG).

:-end_in_neg.

:-aleph_read_all.