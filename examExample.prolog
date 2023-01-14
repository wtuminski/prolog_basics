/*
1)
    a) Proszę zdefiniować predykat member(X,L), który jest spełniony, jeżeli X jest elementem listy L.
    b) Proszę rozszerzyć predykat member(X,L) tak, że jest spełniony, jeżeli X jest elementem listy L na jakimkolwiek poziomie. 
        Przykład:
	        ?- member(4,[1,2,[3,4,[5]],[6,7]]).
	        true.
 */

/* a) */
myMember(X,[X|_]).
myMember(X,[Y|T]) :- 
    X \= Y,
    myMember(X,T).

/* b) */
myMember2(X,[X|_]).
myMember2(X,[Y|T]) :- 
    X \= Y,
    myMember2(X,T).
myMember2(X,[Arr|_]) :-
    myMember2(X,Arr).


/*
2)
    a) Proszę zdefniować predykat suffix(L1,L2), który jest spełniony, jeżeli lista L1 jest końcem listy L2. 
        Przykład:
            ?- suffix([1,2,3],[1,2,3,4,5,6]).
            no.
            ?- suffix([1,2,3],[3,4,5,1,2,3]).
            true.
    b) Proszę zdefiniować predykat palindrom(L), który jest spełniony, jeżeli słowo w liście L jest palindromem. 
        Przykład:
            ?- palindrom([a,b,a,a]).
            no.
            ?- palindrom([a,b,a,b,a]).
            true.
*/

/* a) */
prefix([],[]).
prefix(L,L).
prefix([],_).
prefix([X|T1],[X|T2]) :-
    prefix(T1,T2).

suffix([],[]).
suffix(L,L).
suffix(L1,L2) :-
    reverse(L1,L1R),
    reverse(L2,L2R),
    prefix(L1R,L2R).

/* b) */
palindrom(L) :-
    reverse(L,LR),
    suffix(L,LR).
    
/*
3)
    a) Proszę zdefiniować predykat split(X,L,L1,L2), który jest spełniony, jeżeli lista L1 zawiera wszystkie elementy z listy L mniejsze albo równe X, a L2 zawiera wszystkie elementy większe od X. 
        Przykład:
            ?- split(5,[2,7,4,8,-1,5],L1,L2).
            L1 = [2,4,-1,5],
            L2 = [7,8].
    b) Proszę zdefniować predykat split(P,L,L1,L2), który jest spełniony, jeżeli lista L1 zawiera wszystkie elementy X z listy L spełniające predykat P, a L2 elementy niespełniające predykatu P. 
        Przykład:
            ?- split(odd,[2,7,4,8,-1,5],L1,L2).
            L1 = [7,-1,5],
            L2 = [2,4,8].
*/

/* a) */
split(X,[H|[]],[H],[]) :-  H =< X.
split(X,[H|[]],[],[H]) :- H > X.
split(X,[H|T],L1,L2) :-
    H =< X,
    split(X,T,L1Tail,L2),
    append([H],L1Tail,L1).
split(X,[H|T],L1,L2) :-
    H > X,
    split(X,T,L1,L2Tail),
    append([H],L2Tail,L2).

/* b) */
split2(P,[H|[]],[H],[]) :-  call(P,H).
split2(P,[H|[]],[],[H]) :- \+ call(P,H).
split2(P,[H|T],L1,L2) :-
    call(P,H),
    split2(P,T,L1Tail,L2),
    append([H],L1Tail,L1).
split2(P,[H|T],L1,L2) :-
    \+ call(P,H),
    split2(P,T,L1,L2Tail),
    append([H],L2Tail,L2).

odd(X) :- X mod 2 =:= 0.

/*
4)
    Drzewo binarne D można reprezentować przez term nil - puste drzewo - albo term drzewo(X,L,P) z elementem X i poddrzewami L i P. Proszę zdefiniować następujące predykaty dla drzew.
        a) search(D,X), który jest spełniony, jeżeli X jest elementem drzewa D.
        b) prod(D,P), który jest spełniony, jeżeli P jest iloczynem elementów drzewa D.
        c) postorder(D,L), który jest spełniony, jeżeli lista L zawiera elementy drzewa D w kolejności postfiksowej
*/

/* a) */
search(nil,nil).
search(tree(X,_,_),X).
search(tree(_,L,_),X) :- search(L,X),!.
search(tree(_,_,R),X) :- search(R,X),!.

/* b) */
discriminateNil(nil,1).
discriminateNil(X,X).

prod(nil, P) :- discriminateNil(nil, P).
prod(tree(P,nil,nil),P).
prod(tree(X,L,R),P) :-
    prod(L,LP),
    prod(R,RP),
    discriminateNil(X, XWithoutNil),
    P is XWithoutNil * LP * RP,
    !.

/* c) */
discriminateNilAndWrap(nil,[]).
discriminateNilAndWrap(X,[X]).

postorder(nil,[]).
postorder(tree(X,L,R),PostorderList) :-
    postorder(L,LL),
    postorder(R,LR),
    discriminateNilAndWrap(X, WrappedXWithoutNil),
    append(LL,LR,ChildrenList),
    append(ChildrenList,WrappedXWithoutNil,PostorderList),
    !.

