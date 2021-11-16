%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% inteligência Artificial - MiEI/3 LEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Operacoes sobre listas.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado pertence: Elemento,Lista -> {V,F}

pertence( X,[X|L] ).
pertence( X,[Y|L] ) :-
    X \= Y,
    pertence( X,L ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado comprimento: Lista,Comprimento -> {V,F}

comprimento( [],0 ).
comprimento( [X|L],N ) :-
    comprimento( L,N1 ),
    N is N1+1.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado quantos: Lista,Comprimento -> {V,F}

quantos([], 0).
quantos([X|L],N):-
	pertence(X, L),
	quantos(L, N).

quantos([X|L], N1):-
	nao(pertence(X, L)),
	quantos(L, N), N1 is N+1.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado apaga1: Elemento,Lista,Resultado -> {V,F}

apaga1(X, [], []).
apaga1(X,[X|L],L).
apaga1(X,[Y|L],[Y|N]):- X \= Y, apaga1(X, L, N).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado apagatudo: Elemento,Lista,Resultado -> {V,F}

apagatudo(X, [], []).
apagatudo(X, [X|L], N):- apagaTudo(X, L,N).
apagatudo(X,[Y|L],[Y|N]):- apagaTudo(X,L,N).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado adicionar: Elemento,Lista,Resultado -> {V,F}

% adicionar(X, [], [X]). Enganei-me aqui
adicionar(X, L, L):- pertence(X, L).
adicionar(X, L, [X|L):- nao(pertence(X, L)).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado concatenar: Lista1,Lista2,Resultado -> {V,F}

concatenar([], L, L).
concatenar([X|XS],YS, R):- concatenar(XS, YS, R1), R = [X|R1].

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado inverter: Lista,Resultado -> {V,F}

inverter([], []).
inverter([X|XS], R):- inverter(XS, R1), concatenar(R1, [X], R).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado sublista: SubLista,Lista -> {V,F}

prefix([], L).
prefix([X|XS], [X|YS]):- prefix(XS, YS).

sublista(L0, L1):- prefix(L0,L1).
sublista(L0, [_|L1]):- sublista(L0, L1).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado nao: Questao -> {V,F}

nao( Questao ) :-
    Questao, !, fail.
nao( Questao ).
