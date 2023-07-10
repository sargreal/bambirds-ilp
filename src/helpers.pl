:- module(helpers, [
  get_background_file/2,
  get_examples_file/2
]).

train_path("../data/train").

get_learning_file(Set,Type,FilePath) :- 
  train_path(Path),
  format(atom(FilePath), "~w/~w_~w.pl", [Path, Type, Set]).

get_background_file(Set,FilePath) :-
  get_learning_file(Set,"bg",FilePath).

get_examples_file(Set,FilePath) :-
  get_learning_file(Set,"exs",FilePath).