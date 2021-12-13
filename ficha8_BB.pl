 %--------------------------------- - - - - - - - - - -  -  -  -  -   -
% ITELIGÊNCIA ARTIFICIAL - MiEI/LEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Invariantes

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% PROLOG: definicoes iniciais

:- op( 900,xfy,'::' ).
:- dynamic filho/2.
:- dynamic pai/2.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado filho: Filho,Pai -> {V,F,D}

filho(joao, jose).
filho( jose,manuel ).
filho( carlos,jose ).

% Invariante Estrutural: não permite inserção de conhecimento duplicado.
+filho(F,P)::(findall((F,P), filho(F,P), S), 
			length(S,N),
			N==1).

% Invariante Referencial: nao admitir mais do que 2 progenitores
%                         para um mesmo individuo

+filho(F,P)::(findall((F,P),(filho(F,P), S)),
			length(S,N),
			N==1).

+filho(F,_)::(findall(Ps,(filho(F,Ps),S)),
			length(S,N),
			N=<2).

-filho(F,P)::(findall(F,(age(F,I)), S),
			length(S,N),
			N==0).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado que permite a evolucao do conhecimento

evolucao(Term) :- 
    findall(Invariant,+Term::Invariant,List), 
    insercao(Term),
    test(List).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Auxiliar

evolucao(Termo) :-
    findall(Invariante,+Termo::Invariante,Lista),
    insercao(Termo),
    teste(Lista).

insercao(Termo) :-
    assert(Termo).
insercao(Termo) :-
    retract(Termo),!,fail.