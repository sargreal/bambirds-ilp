:- module(data, [
  ground_plane/1,
  hill/5,
  shape/6,
  supports/2,
  slingshotPivot/2,
  hasMaterial/6,
  situation/1,
  inSituation/2,
  purge/0,
  current_filename/1,
  load_data/1,
  belongsTo/2,
  structure/1,
  bird/1,
  canCollapse/2,
  isBelow/2,
  isCollapsable/1,
  isLeft/2,
  isOn/2,
  isOver/2,
  isRight/2,
  protects/2,
  birdOrder/2,
  hasColor/2,
  pig/5,
  collapsesInDirection/3,
  hasSize/2,
  hasForm/2,
  hasOrientation/2
]).


:- dynamic(ground_plane/1).
:- dynamic(hill/5).
:- dynamic(shape/6).
:- dynamic(supports/2).
:- dynamic(slingshotPivot/2).
:- dynamic(hasMaterial/6).
:- dynamic(situation/1).
:- dynamic(inSituation/2).
:- dynamic(current_filename/1).
:- dynamic(belongsTo/2).
:- dynamic(structure/1).
:- dynamic(bird/1).
:- dynamic(canCollapse/2).
:- dynamic(isBelow/2).
:- dynamic(isCollapsable/1).
:- dynamic(isLeft/2).
:- dynamic(isOn/2).
:- dynamic(isOver/2).
:- dynamic(isRight/2).
:- dynamic(protects/2).
:- dynamic(protects/2).
:- dynamic(birdOrder/2).
:- dynamic(hasColor/2).
:- dynamic(pig/5).
:- dynamic(collapsesInDirection/3).
:- dynamic(hasSize/2).
:- dynamic(hasForm/2).
:- dynamic(hasOrientation/2).

purge :-
  retractall(ground_plane(_)),
  retractall(hill(_,_,_,_,_)),
  retractall(shape(_,_,_,_,_,_)),
  retractall(supports(_,_)),
  retractall(slingshotPivot(_,_)),
  retractall(hasMaterial(_,_,_,_,_,_)).

load_data(Filename) :-
  ((
      current_filename(CurrentFilename),
      unload_file(CurrentFilename),
      retractall(current_filename(_))
    ) ->
    true;true),
  purge,
  catch((
      consult(Filename),
      asserta(current_filename(Filename))
    ),
    error(existence_error(_,_),_),
    (
        writeln(user_error, 'Failed to load data as term, trying string'),
      term_to_atom(Filename, FilenameString),
      consult(FilenameString), 
      asserta(current_filename(FilenameString))
    )
  ).
