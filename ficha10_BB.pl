%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Programacao em logica estendida
% Representacao de conhecimento imperfeito

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Definicoes iniciais

:- op( 900,xfy,'::' ).
:- dynamic jogo/3.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado jogo: Jogo,Arbitro,Ajudas -> {V,F,D}

-jogo( Jogo,Arbitro,Ajudas ) :-
    nao( jogo( Jogo,Arbitro,Ajudas ) ),
    nao( excecao( jogo( Jogo,Arbitro,Ajudas ) ) ).

jogo(1, aa, 500).

jogo(2, bb, xpto1).
excecao(jogo(Jogo, Arbitro, _)):-
		jogo(Jogo, Arbitro, xpto1).

excecao(jogo(3, cc, 500)).
excecao(jogo(3, cc, 2500)).

excecao(jogo(4, dd, Valor)) :-
		Valor >= 250,
		Valor <= 750.

jogo(5, ee, xpto5)
excecao(jogo(Jogo, Arbitro, _)):- jogo(Jogo, Arbitro, xpto5).
nulo(xpto765).

jogo(6, ff, 250).
excecao(jogo(6, ff, Valor)):- Valor > 5000.

-jogo(7,gg,2500).
jogo(7, gg, xpto7).
excecao(jogo(Jogo, Arbitro, _)):-
		jogo(Jogo, Arbitro, xpto7).

cerca(Valor, Superior, Inferior):- Superior is Valor * 1.25,
									Inferior is Valor * 0.75.

excecao(jogo(8, hh, Valor)):- cerca(1000, Superior, Inferior),
						  		Valor >= Inferior,
						  		Valor <= Superior.

proxima(Valor, Superior, Inferior):- Superior is Valor * 1.05,
									 Inferior is Valor * 0.95.

excecao(jogo(9, ii, Valor)):- proxima(3000, Superior, Inferior),
								Valor >= Inferior,
								Valor <= Superior.

%-----------------  Invariantes -------------------- --- - - - - - - - 

+jogo(_,_,_) :: (findall(Ajudas,(jogo(5, ee, Ajudas), nao(nulo(Ajudas))), S),
				length(S,N),
				N = 0).

+jogo(_,Arbitro,_) :: (findall(Arbitro, jogo(_,Arbitro, _), S),
				length(S, N),
				N <= 3).

+jogo(_,Arbitro,_) :: (findall((G1,G2), jogo(G1, Arbitro, _),
						jogo(G2, Arbitro, _), S),
						length(S,N),
						G2 is G1+1,
						N==0).



%--------------------------------- - - - - - - - - - -  -  -  -  -   -

evolucao( Termo ) :-
    solucoes( Invariante,+Termo::Invariante,Lista ),
    insercao( Termo ),
    teste( Lista ).

insercao( Termo ) :-
    assert( Termo ).
insercao( Termo ) :-
    retract( Termo ),!,fail.

teste( [] ).
teste( [R|LR] ) :-
    R,
    teste( LR ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado que permite a involucao do conhecimento

involucao( Termo ) :-
    solucoes( Invariante,-Termo::Invariante,Lista ),
    remocao( Termo ),
    teste( Lista ).

remocao( Termo ) :-
    retract( Termo ).
remocao( Termo ) :-
    assert( Termo ),!,fail.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado demo: Questao,Resposta -> {V,F}
%                            Resposta = { verdadeiro,falso,desconhecido }

demo( Questao,verdadeiro ) :-
    Questao.
demo( Questao,falso ) :-
    -Questao.
demo( Questao,desconhecido ) :-
    nao( Questao ),
    nao( -Questao ).



%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado nao: Questao -> {V,F}

nao( Questao ) :-
    Questao, !, fail.
nao( _ ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

solucoes( X,Y,Z ) :-
    findall( X,Y,Z ).

comprimento( S,N ) :-
    length( S,N ).
