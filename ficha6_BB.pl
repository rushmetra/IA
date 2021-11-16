%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Ficha 6 -> Inteligência Artificial 2021/2022

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

inicial(_).
final(t).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

move(a,b,2).
move(b,c,2).
move(c,d,3).
move(d,t,3).
move(s,e,2).
move(e,f,5).
move(f,g,2).
move(g,t,2).
move(s,a,2).

% Add no fim para testar
% move(b,f,2).

estima(s,10).
estima(e,7).
estima(a,5).
estima(b,4).
estima(c,4).
estima(d,3).
estima(f,4).
estima(g,2).
estima(t,0).


goal(t).

adjacente(Nodo, ProxNodo, C):-
	move(Nodo, ProxNodo, C).
adjacante(Nodo, ProxNodo, C):-
	move(ProxNodo,Nodo, C).

adjcante2([Nodo|Caminho]/Custo/_, [ProxNodo, Nodo|Caminho]/NovoCusto/Est):-
	move(Nodo, ProxNodo, PassoCusto),
	\+ member(ProxNodo, Caminho),
	NovoCusto is Custo + PassoCusto,
	estima(ProxNodo, Est).

% resolve_dfs(Orig,Dest,Cam,Custo):-
%	dfs2(Orig,Dest,[Orig],Cam,Custo).

% dfs2(Dest,Dest,LA,Cam,0):- reserve(LA, Cam).

% dfs2(Act, Dest, LA, Cam, Custo):-
%	adjacente(Act, X, Peso),
%	\+ member(X, LA),
%	dfs2(X, Dest,[X|LA],Cam,NCusto),
%	Custo is NCusto + Peso.




%--------------------------- Procura em profundidade primeiro com custo ------------
% resolve_pp_c(s,C,Custo).

resolve_pp_c(Nodo, [Nodo|Caminho], C):-
	profundidadeprimeiro(Nodo, [Nodo], Caminho, C).

profundidadeprimeiro(Nodo,_, [], 0):-
	goal(Nodo).

profundidadeprimeiro(Nodo, Historico, [ProxNodo|Caminho], C):-
	adjacente(Nodo, ProxNodo, C1),
	nao(member(ProxNodo, Historico)),
	profundidadeprimeiro(ProxNodo, [ProxNodo|Historico], Caminho, C2), C is C1 + C2.

% melhor(Nodo, S, Custo):- findall((SS,CC), resolve_pp_c(Nodo, SS, CC), L),
% minimo(L, (S,Custo)).

% minimo([P,X], ).



% ---------------- pesquisa gulosa ----------------
% resolve_gulosa(s, Custo).

resolve_gulosa(Nodo, Caminho/Custo) :-
	estima(Nodo, Estima),
	agulosa([[Nodo]/0/Estima], InvCaminho/Custo/_),
	inverse(InvCaminho, Caminho).

agulosa(Caminhos, SolucaoCaminho):-
	obtem_melhor_g(Caminhos, MelhorCaminho),
	seleciona(MelhorCaminho, Caminhos, OutrosCaminhos),
	expande_gulosa(MelhorCaminho, ExpCaminhos),
	append(OutrosCaminhos, ExpCaminhos, NovoCaminhos),
	agulosa(NovoCaminhos, SolucaoCaminho).

obtem_melhor_g([Caminho], Caminho):- !.

obtem_melhor_g([Caminho1/Custo1/Est1,_/Custo2/Est2|Caminhos], MelhorCaminho):-
	Est1 =< Est2, !,
	obtem_melhor_g([Caminho1/Custo1/Est1|Caminhos], MelhorCaminho).

obtem_melhor_g([_|Caminhos], MelhorCaminho) :-
	obtem_melhor_g(Caminhos, MelhorCaminho).

expande_gulosa(Caminho, ExpCaminhos) :-
	findall(NovoCaminho, adjacente2(Caminho,NovoCaminho), ExpCaminhos).

% -------------------- pesquisa A* (a estrela) -------------------------

aestrela(Caminhos, SolucaoCaminho):-

obtem_melhor([Caminho], Caminho):- !.

obtem_melhor([Caminho1/Custo1/Est1,_/Custo2/Est2|Caminhos], MelhorCaminho):-
	Est1 =< Est2, !,
	obtem_melhor_g([Caminho1/Custo1/Est1|Caminhos], MelhorCaminho).

obtem_melhor([_|Caminhos], MelhorCaminho) :-
	obtem_melhor_g(Caminhos, MelhorCaminho).

expande_aestrela(Caminho, ExpCaminhos) :-
	findall(NovoCaminho, adjacente2(Caminho,NovoCaminho), ExpCaminhos).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado nao: Questao -> {V,F}

nao(Questao):-
    Questao, !, fail.
nao(Questao).

seleciona(E, [E|Xs], Xs).
seleciona(E, [X|Xs], [X|Ys]):- seleciona(E, Xs, Ys).

inverso(Xs, Ys):-
	inverso(Xs, [], Ys).

inverso([], Xs, Xs).
inverso([X|Xs], Ys, Zs):-
	inverso(Xs, [X|Ys], Zs).
























