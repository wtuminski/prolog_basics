/* 
1)
*/
% a)
append([],[],[]).
append([H|T],L2,[H|T3]) :-
    append(T,L2,[H|T3]).
append([],[H|T2],[H|T3]) :-
    append(T2,L2,[H|T3]).

% b)
sum(N,L) :-
    sum(N,L,1).
sum(N,[H|T],Acc) :-
    Acc1 is H*Acc,
    sum(N,T,Acc1).
sum(N,[H],Acc) :-
    Acc1 is H*Acc,
	DoubleN is N*2,
    Acc1 >= DoubleN.   

% 2)
% a)
squares(1,[1]).
squares(N,L) :-
    N >= 1,
    N1 is N - 1,
    S is N*N,–
    squares(N1,T),
    append(T,[S],L).

% b)
inter([],_,[]).
inter([X|T],L2,[X|T1]) :-
    member(X,L2),
    inter(T,L2,T1).
inter([X|T],L2,L) :-
    \+ member(X, L2),
    inter(T,L2,L).

% 3
% a)
search(X,tree(X,_,_)).
search(X,leaf(X)).
search(X,leaf(_,L,R)):-
    search(X,L);
    search(X,R).
% b)

leaves(leaf(_),1).
leaves(tree(_,L,R),N) :-
    leaves(L,N1),
    leaves(R,N2),
    N is N1 + N2.

% c)
square(leaf(X),leaf(X2)) :-
    X2 is X*X.
square(tree(X,L,R),tree(X2,L2,R2)) :-
    X2 is X*X,
    square(L,L2),
    square(R,R2).
