%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Ficha 5 -> Inteligência Artificial 2021/2022

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

% estado inicial 
inicial(jarros(0,0)).

% estado final
final(jarros(4,_)).
final(jarros(_,4)).

% transições possiveis transicao: Ei x Op x Ef

transicao(jarros(V1,V2),encher(1),jarros(8,V2)) :- V1 < 8.
transicao(jarros(V1,V2),encher(2),jarros(V1,5)) :- V1 < 5.

transicao(jarros(V1,V2),encher(1,2),jarros(NV1,NV2)):-
        V1 > 0,
        NV1 is max(V1 - 5 + V2,0),
        NV1 < V1,
        NV2 is V2 + V1 - NV1.
transicao(jarros(V1,V2),encher(2,1),jarros(NV1,NV2)):-
        V2 > 0,
        NV2 is max(V2 - 8 + V1,0),
        NV2 < V2,
        NV1 is V1 + V2 - NV2.

transicao(jarros(V1,V2),vazio(1),jarros(0,V2)):- V1 > 0.
transicao(jarros(V1,V2),vazio(2),jarros(V1,0)):- V2 > 0.

%--------------------------- Procura em profundidade ------------
resolve2df(Solucao) :- dfs_2(jarros(0,0),jarros(_,4),Solucao).


dfs_2(EstadoI,EstadoF,Solucao):- dfs_2_aux(EstadoI,EstadoF,[EstadoI],Solucao). 
dfs_2_aux(EstadoF,EstadoF,LA,Cam):- reverse(LA,Cam),write(Cam). 
dfs_2_aux(Act,Dest,LA,Cam):- transicao(Act,Move,EstadoX), 
                \+ member(EstadoX,LA), 
                dfs_2_aux(EstadoX,Dest,[EstadoX|LA],Cam).


%------------------ Procura em largura e) --------

bfs(Orig, Dest, Cam):- bfs2(Dest,[[Orig]],Cam).
bfs2(Dest,[[Dest|T]|_],Cam):- reverse([Dest|T],Cam). %o caminho aparece pela ordem inversa
bfs2(Dest,[LA|Outros],Cam):- LA=[Act|_],
	findall([X|LA],
(Dest\==Act,connect(Act,X),\+member(X,LA)),Novos),
	append(Outros,Novos,Todos),
	bfs2(Dest,Todos,Cam).








