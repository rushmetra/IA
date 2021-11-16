%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Inteligência Artificial MIEI /3  LEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Operacoes aritmeticas.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
& Extensao do predicado soma: X,Y,Soma -> {V , F}

soma(X,Y,Soma) :-
	Soma is X+Y.

soma(X,Y,Z,Soma) :-
	Soma is X+Y+Z.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado app: X op Y, R -> R

app(X+Y, R) :- R is X+Y.
app(X-Y, R) :- R is X-Y.
app(X*Y, R) :- R is X*Y.
app(X/Y, R) :- R is X/Y.
	

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado maior1: X,Y,R -> {V,F}


maior1(X,Y,X) :-
    X > Y.
maior1(X,Y,Y).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado maior2: X,Y,R -> {V,F}

maior2(X,Y,X) :-
    X > Y, ! .
maior2(X,Y,Y).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado maior3: X,Y,R -> {V,F}

maior3(X,Y,X) :-
    X > Y.
maior3(X,Y,Y) :-
    X =< Y.


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
& Extensao do predicado menor: X,Y,R -> R

menor(X,Y,X):-
	X < Y.
menor(X,Y,Y):-
	X>=Y.

menor3(X,Y,Z, R):-
	X < Y, menor(X,Z,R).

menor3(X,Y,Z, R):-
	X >= Y, menor(Y,Z,R).


menor_lista([H|T], Min):-
	menor_lista(T, H, Min).

menor_lista([], Min, Min).
menor_lista([H|T], Min0, Min):-
	Min1 is menor(H, Min0),
	menor_lista(T, Min1, Min).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
& Extensao do predicado pertence: Membro, Lista -> {V, F} 

pertence(X, [X|T]).
pertence(X, [Y|T]):-
	X \= Y,
	pertence(X,T).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
& Extensao do predicado comprimento: Lista, Comprimento -> {V, F} 

comprimento([], 0).
comprimento([X|T], R):-
	comprimento(T, R1),
	R is 1 + R1.



soma_lista([], Acc, R).
soma_lista([H|T], OldAcc, R):- 
	soma_lista(T, NewAcc, R),
	Acc is NewAcc + H.

somal([], 0).
somal([H|T], S):-
	somal(T, S1),
	S is S1 + H.
	

max1([H|T], Max):-
	max(T,H,Max).

max([H|T], A, Maximo):- H > A,
		max(T, H, Maximo).
max([H|T],A,Maximo):- H <= A,
		max(T,A,Maximo).
max([],A,A).


minimo([H|T], Minimo):-
	min(T,H,Minimo).
min([H|T], A, Minimo):- H <= A,
		min(T, H, Minimo).
min([H|T],A,Minimo):- H > A,
		min(T,A,Minimo).
min([],A,A).


append([],L,L).
append([H|L1], L2; [H|L3]):- append([L1,L2,L3]).

mdc(X , Y, R) :-
	X > Y,
	X1 is X - Y,
	mdc( X1,Y,R ).
mdc(X,Y,R):-
	Y > X,
	Y1 is Y-X,
	mdc( X, Y1, R).
mdc(X,X,X).