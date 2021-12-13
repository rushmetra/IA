%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% ITELIGÊNCIA ARTIFICIAL - MiEI/LEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Programadog em logica estendida


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% PROLOG: definicoes iniciais

:- set_prolog_flag(discontiguous_warnings,off).
:- set_prolog_flag(single_var_warnings,off).
:- dynamic '-'/1.
:- dynamic mamal/1.
:- dynamic bat/1.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

voa( X ) :-
    ave( X ).

-voa( tweety ).

-voa( X ) :-
    mamifero( X ).

+voa(pitigui)


	
	
	

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado nao: Questao -> {V,F}

nao( Questao ) :-
    Questao, !, fail.
nao( Questao ).
