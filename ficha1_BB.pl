%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Inteligência Artificial MIEI /3  LEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Base de Conhecimento com informacao genealogica.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado filho: Filho,Pai -> {V,F}

filho( joao,jose ).
filho( jose,manuel ).
filho( carlos,jose ).
filho( paulo, antonio).

pai( paulo,filipe ).
pai( paulo,maria ).

avo( antonio,nadia ).
neto( nuno, ana ).

sexo( joao ).
sexo( jose ).
sexo( maria ).
sexo ( joana ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado pai: Pai,Filho -> {V,F}

pai( P,F ) :- filho( F,P ).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado avo: Avo,Neto -> {V,F}

avo( A,N ) :-
	filho( N,X ),
	pai( X,A ).

avo( A,N ) :-
	filho( N,X ),
	pai( A,X ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado bisavo: Bisavo,Bisneto -> {V,F}

bisavo( A,D ) :-
	descendente( D,A,3 ).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado descendente: Descendente,Ascendente -> {V,F}

descendente( D, A) :-
	filho( D,A ).
descendente( D,A ) :-
	filho( D,X ),
	descendente( X,A ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado descendente: Descendente,Ascendente,Grau -> {V,F}


descendente(X,Y,1) :- filho(X,Y).
descendente(X,Y,N) :- filho(X,Z), G is N-1, descendente(Z,Y,G).


