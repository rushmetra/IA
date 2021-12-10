%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Ficha 11 -> Inteligência Artificial 2021/2022

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Programacao em logica estendida
% Representacao de conhecimento imperfeito

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

:- op( 900,xfy,'::' ).
:- dynamic servico/2.
:- dynamic ato/4.

%--------------------------------- - - - - - - - - - - - - - - - -   -
% Aplicação do PMF

-servicoSaude(Servico, Nome) :- 
    nao(servicoSaude(Servico, Nome)), 
    nao(excecao(servicoSaude(Servico, Nome))).
	
-atoMedico(Ato, Prestador, Utente, Dia) :- 
    nao(atoMedico(Ato, Prestador, Utente, Dia)), 
    nao(excecao(atoMedico(Ato, Prestador, Utente, Dia))).

%--------------------------------- - - - - - - - - - -  -


% servicoSaude(Servico, Enfermeira) -> {V, F, D}

servicoSaude(ortopedia, amelia).
servicoSaude(obstetricia, ana).
servicoSaude(obstetricia, maria).
servicoSaude(obstetricia, mariana).
servicoSaude(geriatria, sofia).	
servicoSaude(geriatria, susana).

excecao(servicoSaude(_, E)) :-
	servicoSaude(c007, E).

excecao(servicoSaude(_, E)) :-
	servicoSaude(anp9, E).


% +servicoSaude(S, E) :: (findall(S, servicoSaude(S, zulmira), nao(nulo(S))), L),
%											   length(L, N),
%                                              N == 0).

+servicoSaude(Servico, Nome) :: (solucoes( Servico, (servicoSaude(Servico, Nome),
									nao(nulo(Servico))), S), comprimento(S,N), N==0).

% Tabela de dados
% atoMedico(Ato, Enfermeira, Utente, Data) -> {V,F,D}

atoMedico(penso, ana, joana, sabado).
atoMedico(gesso, amelia, jose, domingo).

excecao(atoMedico(_, E, U, D)) :-
	ato(c017, E, U, D).

excecao(atoMedico(A, E, _, _)) :-
	ato(A, E, c121, c251).

excecao(atoMedico(A, _, U, D)) :-
	ato(A, c313, U, D).


excecao(atoMedico(domicilio, susana, joao, segunda))
excecao(atoMedico(domicilio, susana, jose, segunda))

excecao(atoMedico(sutura, maria, josefa, terça))
excecao(atoMedico(sutura, maria, josefa, sexta))
excecao(atoMedico(sutura, mariana, josefa, terça))
excecao(atoMedico(sutura, mariana, josefa, sexta))

% +servicoSaude(S, E) :: (findall(S))


excecao(atoMedico(penso, ana, jacinta, C)) :- pertence(C, [segunda, terca, quarta, quinta, sexta]).

%-servicoSaude(_, Nome) :: (solucoes(D,(atoMedico(A,P,U,D)), S),
%						nao(pertence(feriado,S))
%						).

%-servicoSaude(_, Nome) :: (findall(D, (atoMedico(A,P,U,D)), S),
%						nao(pertence(feriado,S))
%						).

% c) versao prof 

+ato(A, P, U, Data) :: (findall(D,(ato( A, P, U, D)), S),
						nao(pertence(feriado, S))).


% d)
-servicosaude(_, Nome) :: (findall(Nome, ato(_, Nome, _, _), S),
												length(S, Nome),
												N == 0).
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
% Extensão do predicado que permite a involucao do conhecimento

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
nao( Questao ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

solucoes( X,Y,Z ) :-
    findall( X,Y,Z ).

comprimento( S,N ) :-
    length( S,N ).



pertence( X,[X|L] ).
pertence( X,[Y|L] ) :-
    X \= Y,
    pertence( X,L ).
