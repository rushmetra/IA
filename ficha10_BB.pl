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


excecao(jogo(IdJogo, CostaCarvalho, AjudasCusto)):-
                    jogo(IdJogo, CostaCarvalho, 500),
                    jogo(IdJogo, CostaCarvalho, 2000).




% jogo(J3, CostaCarvalho, );

% iv.

% jogo(J4,DuarteDurao, );












% Apontamentos da aula anterior (Segundo stor)
si(Q,verdadeiro):-
    Q.


si(Q,falso):-
    -Q.

si(Q,desconhecido) :-
     nao(Q),
     nao(-Q).