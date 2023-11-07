:- findall(P,pos(P),Ps),length(Ps,PL), write("Pos: "), writeln(PL).
:- findall(N,neg(N),Ns),length(Ns,NL), write("Neg: "), writeln(NL).
:- halt.