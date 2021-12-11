%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Ficha 10 -> Inteligência Artificial 2021/2022

%--------------------------------- - - - - - - - - - -  -  -  -  -   -


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% jogo(IdJogo, Arbitro, AjudasCusto) -> {V,F,D}


% i.
jogo(IdJogo, Almeida_Antunes, 500);
% ii.
jogo(IdJogo, Baltazar_Borges, xpto0123);

excecao(jogo(Id,Arbitro,AjudasCusto)):-
				jogo(IdJogo, Arbitro, xpto0123).



% iii.


excecao(jogo(3, CostaCarvalho, 500)).
excecao(jogo(3, CostaCarvalho, 2500)).

% iv.
% jogo(J4,DuarteDurao, );

excecao(jogo(4,DuarteDurao,AjudasCusto)):-
    AjudasCusto >= 250,
    AjudasCusto <= 750.

% v.

excecao(jogo(5, EdgarEsteves, AjudasCusto)) :-
        jogo(5, EdgarEsteves,xpto0123).
nulo(xpto0123).


% vi.

jogo(J6, FranciscoFranca, );


% vii.

jogo(J7, GuerraGodinho, );


% viii. 

jogo(J8, HelderHeitor, );

% ix.

jogo(J9, IvoInocencio, );


% x.



% xi.



% xii.



% NEGACAO FORTE que nao existiu um jogo
-jogo(Id,Arbitro,AjudasCusto) :- nao (-Q).
    nao(jogo(Id,Arbitro,AjudasCusto)),
    nao(excecao(jogo(Id,Arbitro,AjudasCusto))).





% Apontamentos da aula anterior (Segundo stor)
si(Q,verdadeiro):-
    Q.


si(Q,falso):-
    -Q.

si(Q,desconhecido) :-
     nao(Q),
     nao(-Q).
