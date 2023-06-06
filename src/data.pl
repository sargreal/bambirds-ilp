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
  load_data/1
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
