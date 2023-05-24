:- module(tikz, [
	write_tikz/0,
	build_tikz/0,
	export_tikz/0
	]).
:- use_module(data).
:- use_module(geometric).

drop_alphas([],[]).
drop_alphas([H|R], [H|R]) :-
    char_type(H, digit).
drop_alphas([_|R], D) :-
    drop_alphas(R, D).

replace_underscore([],[]).
replace_underscore([H|R], ['\\', '_' |D]) :-
  H = '_',
  replace_underscore(R, D).
replace_underscore([H|R], [H|D]) :-
  H \= '_',
  replace_underscore(R, D).

%% trim_name/2
%% trims atom name for export so it fits into small boxes
%% A : atom such as wood23
%% N : resulting name, e.g. "w23"
trim_name(Atom, Name) :-
	atom_string(Atom, Str),
	string_chars(Str, Chrs),
  replace_underscore(Chrs,Clean), !,
	string_chars(Name, Clean).


exportname(Name) :-
	((current_predicate(situation_name/1), situation_name(Name))->
	true;
	Name = 'scene').

%% writes TIKZ drawing commands
%% Out    : stream to write to
%% ID     : label of the object to add, e.g., wood2
%% Color  : fill color
%% Points : list of points
export_poly(Out,ID,Color,Points,CX,CY,A) :-
	format(Out, '\\draw[fill=~a] ', [Color]),
	forall(member([X,Y], Points), format(Out, '(~f,~f) -- ', [0.05*X,-0.05*Y])),
	trim_name(ID, Label),
	format(Out, 'cycle;~n\\node[rotate=~f] at (~f,~f) {\\small ~w};~n', [-180.0*(A / pi), 0.05*CX, -0.05*CY, Label]).

export_bounding_box(Out,ID,StrokeColor,[X0,Y0,X1,Y1]) :-
	format(Out, 
		'\\draw[~a] (~f,~f) rectangle (~f,~f); 
		\\draw (~f,~f) node {~w};~n', 
		[StrokeColor, 0.05*X0,-0.05*Y0, 0.05*X1,-0.05*Y1, 0.05*X0,-0.05*Y0, ID]
	).

%% exports a specific type of shape
export_shape(Out, ID, rect, X, Y, [W, H, A]) :-
	(hasMaterial(ID, M, _, _, _, _); M=lightgray),
	%% draw object
	XRa is (0.5*H),
	YRa is (0.5*W),
	rot_shift(A, X, Y, [[-XRa,-YRa], [-XRa,YRa], [XRa,YRa], [XRa,-YRa]], Points),
	export_poly(Out,ID,M,Points,X,Y,A).

export_shape(Out, ID, unknown, X, Y, _) :-
	hasMaterial(ID, M, _, _, _, _),
	trim_name(ID, Label),
	format(Out, '\\draw[fill=~a] (~f,~f) circle (8pt) node {\\small ~a};~n', [M, X*0.05, -0.05*Y, Label]).

export_shape(Out, ID, poly, X, Y, [_ | Points]) :-
	(hasMaterial(ID, M, _, _, _, _) ; M=lightgray), % hills are of shape type poly but don't have a material assigned
	export_poly(Out,ID,M,Points,X,Y,0).

export_shape(Out, ID, ball, X, Y, [R]) :-
	(hasMaterial(ID, M, _, _, _, _) ; hasColor(ID,M)), % birds are of shape type ball but don't have a material assigned; use red instead
	format(Out,'\\draw[draw,fill=~a] (~f, ~f) circle (~f) node {~w};~n', [M, 0.05*X, -0.05*Y, 0.05*R, ID]).

%%
%% Writes a latex file displaying the current scene, i.e., all objects mentioned as shape/6 predicates.
%% Also indicates where shots are planned according to list of Plans in the format
%% [[target, angle, strategy, confidence, pigs_affected] | ... ]
%%
write_tikz :-
	%% open file, write latex header
	exportname(SceneName),
	string_concat(SceneName, '.tex', TexName),
	open(TexName, write, Out),
	(\+ getenv('CONVERT_ENABLE', true) ->
			writeln(Out, '\\documentclass[tikz]{standalone}');
			(current_prolog_flag(windows, true) ->
				writeln(Out, '\\documentclass[tikz,convert={outext=.jpg,size=1500,{convertexe={magick.exe}}}]{standalone}');
				writeln(Out, '\\documentclass[tikz,convert={outext=.jpg,size=1500}]{standalone}')
			)
	),
	writeln(Out, '\\usetikzlibrary{matrix,backgrounds}'),
	writeln(Out, '\\definecolor{ice}{rgb}{0.6,0.7,1.0}'),
	writeln(Out, '\\definecolor{stone}{rgb}{0.5,0.5,0.5}'),
	writeln(Out, '\\definecolor{wood}{rgb}{0.9,0.6,0.1}'),
	writeln(Out, '\\definecolor{pork}{rgb}{0.1,1.0,0.1}'),
	writeln(Out, '\\definecolor{tnt}{rgb}{0.9,0.9,0.0}'),
	writeln(Out, '\\definecolor{hill}{rgb}{0.2,0.2,0.2}'),
	writeln(Out, '\\begin{document}'),
	writeln(Out, '\\begin{tikzpicture}[background rectangle/.style={fill=white!45}, show background rectangle]'),

	forall(shape(ID,Type,X,Y,_,Params), export_shape(Out,ID,Type,X,Y,Params)),

	%%  finish picture
	writeln(Out, '\\end{tikzpicture}'),

	%% finish document, close file, and typeset
	writeln(Out, '\\end{document}'),
	close(Out).

build_tikz :-
	exportname(SceneName),
	string_concat(SceneName, '.tex', TexName),
	string_concat(SceneName, '.pdf', PdfName),
	string_concat('pdflatex -halt-on-error -shell-escape ', TexName, PdfLatex),
	catch((shell(PdfLatex),
        (getenv('EXPORT_DISPLAY_ENABLE', true) ->
                (current_prolog_flag(windows, true)
                -> win_shell(open,PdfName);
                        (current_prolog_flag(apple, true)
                        -> (string_concat('open ', PdfName, AppleOpen),
                                shell(AppleOpen));
                             (string_concat('xdg-open ', PdfName, LinuxOpen),
                                shell(LinuxOpen))
                        )
                );
                true
        )),
        Error,
        print_message(error,Error)
     ).

export_tikz :-
	write_tikz,
	build_tikz.

