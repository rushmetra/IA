%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% I.A. - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Programacao em logica 
% Pesquisa Não Informada e Informada (Ficha 7)

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado move: LocalidadeO,LocalidadeD, CustoDistancia, CustoTempo -> {V,F}


move(elvas, borba, 15, 10 ).
move(borba, estremoz, 15, 10).
move(estremoz, evora, 40, 25).
move(evora, montemor, 20, 15).
move(montemor, vendasnovas, 15, 10).
move(vendasnovas, lisboa, 50, 30).
move(elvas, arraiolos, 50, 30).
move(arraiolos, alcacer, 90, 60).
move(alcacer, palmela, 35, 32).
move(palmela, almada, 25, 20).
move(palmela, barreiro, 25, 20).
move(barreiro, palmela, 30, 20).
move(almada, lisboa, 15, 20).
move(elvas, alandroal, 40, 25).
move(alandroal, redondo, 25, 10).
move(redondo, monsaraz, 30, 20).
move(monsaraz, barreiro, 120, 60).
move(barreiro, baixabanheira, 5, 5).
move(baixabanheira, moita, 7, 6).
move(moita, alcochete, 20, 20).
move(alcochete, lisboa, 20, 15).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado estima: Localidade, EstimaDistancia, EstimaTempo -> {V,F}

estima(elvas, 270, 150).
estima(borba, 250, 90 ).
estima(estremoz, 145, 85).
estima(evora, 95, 68).
estima(montemor, 70, 40). 
estima(vendasnovas, 45, 30).
estima(arraiolos,190, 80).
estima(alcacer, 65, 45).
estima(palmela, 40, 25).
estima(almada, 25, 20).
estima(alandroal, 180, 90).
estima(redondo, 170, 80).
estima(monsaraz, 120 ,70).
estima(barreiro, 30 ,20 ).
estima(baixabanheira, 33, 25).
estima(moita, 35, 20). 
estima(alcochete, 26, 15).
estima(lisboa, 0,0).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Extensão do predicado goal: Localidade -> {V,F}

goal(lisboa).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -

adjacente(Nodo, ProxNodo, CustoDistancia, CustoTempo):-
	move(Nodo, ProxNodo, CustoDistancia, CustoTempo).
adjacante(Nodo, ProxNodo, CustoDistancia, CustoTempo):-
	move(ProxNodo,Nodo, CustoDistancia, CustoTempo).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% resolve_gulosa(s, CustoDistancia, CustoTempo).

adjacente2([Nodo|Caminho]/Custo/_, [ProxNodo, Nodo|Caminho]/NovoCusto/Est):-
	move(Nodo, ProxNodo, CustoDistancia, CustoTempo),
	\+ member(ProxNodo, Caminho),
	NovoCusto is Custo + PassoCusto,
	estima(ProxNodo, Est).


resolve_gulosa(Nodo, Caminho/CustoDistancia, Caminho/CustoTempo) :-
	estima(Nodo, EstimaDistancia, EstimaTempo),
	agulosa([[Nodo]/0/EstimaDistancia, EstimaTempo], InvCaminho/CustoDistancia/CustoTempo/_),
	inverso(InvCaminho, Caminho). 

agulosa(Caminhos, SolucaoCaminho):-
	obtem_melhor_g(Caminhos, MelhorCaminho),
	seleciona(MelhorCaminho, Caminhos, OutrosCaminhos),
	expande_gulosa(MelhorCaminho, ExpCaminhos),
	append(OutrosCaminhos, ExpCaminhos, NovoCaminhos),
	agulosa(NovoCaminhos, SolucaoCaminho).

obtem_melhor_g([Caminho], Caminho):- !.

obtem_melhor_g([Caminho1/CustoD1/CustoT1/Est1,_/CustoD2/CustoT2/Est2|Caminhos], MelhorCaminho):-
	Est1 =< Est2, !,
	obtem_melhor_g([Caminho1/CustoD1/CustoT1/Est1/Est2|Caminhos], MelhorCaminho).

obtem_melhor_g([_|Caminhos], MelhorCaminho) :-
	obtem_melhor_g(Caminhos, MelhorCaminho).

expande_gulosa(Caminho, ExpCaminhos) :-
	findall(NovoCaminho, adjacente2(Caminho,NovoCaminho), ExpCaminhos).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% resolve_aestrela(s,C).

resolve_aestrela(Nodo, CaminhoDistancia/CustoDist, CaminhoTempo/CustoTempo) :-
    estima(Nodo,EstimaD, EstiimaT),
    aestrela_distancia([[Nodo]/0/Estima], InvCaminho/Custo/_),
    aestrela_Tempo([[Nodo]])
    inverso(InvCaminho, Caminho).	

aestrela(Caminhos, Caminho) :-
    obtem_melhor(Caminhos,Caminho),
    Caminho = [Nodo|_]/_/_,goal(Nodo).

aestrela_distancia(Caminhos, SolucaoCaminho) :-
    obtem_melhor(Caminhos, MelhorCaminho),
    seleciona(MelhorCaminho, Caminhos, OutrosCaminhos),
    expande_aestrela(MelhorCaminho, ExpCaminhos),
    append(OutrosCaminhos, ExpCaminhos, NovoCaminhos),
    aestrela(NovoCaminhos, SolucaoCaminho).

aestrela_tempo(Caminhos, Caminho):-
	obtem_melhor_tempo(Caminhos, Caminho),




adjacente_tempo([Nodo|Caminho]/Custo/_, [ProxNodo,Nodo|Caminho]/NovoCusto/EstimaTempo):-
	move(Nodo, ProxNodo, _, PassoTempo),
	\+ member(ProxNodo, Caminho),
	NovoCusto is Custo + PassoTempo,
	estima(ProxNodo, _, EstimaTempo).

adjacente_distancia([Nodo|Caminho]/Custo/):-


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
























