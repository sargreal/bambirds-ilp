:- module(helpers, [
  get_learning_file/2
]).

learning_set("_stable.pl").

get_learning_file(Path,File) :- learning_set(Set), string_concat(Path, Set, File).