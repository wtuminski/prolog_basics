% 10) Proszę zdefiniować następujące predykaty dla list.
%   nth(N,L,X), który jest spełniony, jeżeli X jest N-tym elementem listy L.
        nth(0,[X|_],X).
        nth(N,[_|T],X) :-
            N1 is N - 1,
            nth(N1,T,X).

%   ordered(L), który jest spełniony, jeżeli lista L jest posortowana.
        ordered([]).
        ordered([_|[]]).
        ordered([A,B|T]) :-
            A =< B,
            ordered(T).

%   mergesort(L1,L2), który jest spełniony, jeżeli lista L2 jest wersją posortowaną listy L1. 
%   Predykat ma symulowac algorytm mergesort.

    split(Base,0,[],Base).
    split([H|BaseTail],1,[H],BaseTail).
    split([H|T],Index,L1,L2) :- 
        Index1 is Index - 1,
        split(T,Index1,L1Tail,L2),
        append([H],L1Tail,L1).

    merge_lists([],L2,L2).
    merge_lists(L1,[],L1).
    merge_lists([H1|L1],[H2|L2],[H1|MergedTail]) :-
        H1 =< H2,
        merge_lists(L1,[H2|L2],MergedTail).
    merge_lists([H1|L1],[H2|L2],[H2|MergedTail]) :-
        H1 > H2,
        merge_lists([H1|L1],L2,MergedTail).
       
    mergesort([],[]).
    mergesort([H|[]],[H]).
    mergesort(List,Sorted) :-
        length(List,Length),
        Mid is Length // 2,
        split(List,Mid,FirstPart,SecondPart),
        mergesort(FirstPart,FirstSortedPart),
        mergesort(SecondPart,SecondSortedPart),
        merge_lists(FirstSortedPart,SecondSortedPart,Sorted).


% 11) Proszę zdefiniować predykat permutation(L1,L2), który jest spełniony, jeżeli lista L2 jest permutacją listy L1.
%     Przy użyciu ";" powiennien być możliwe wyliczać wszystkie permutacje listy L1.

    get_permutation([], []).
    get_permutation([X], [X]) :-print([X]),!.
    get_permutation([BaseListHead|BaseListTail], Permutation) :- 
        get_permutation(BaseListTail, TailPermutation), 
        append(CalculatedList, TailPart, TailPermutation), 
        append(CalculatedList, [BaseListHead], HeadPart), 
        append(HeadPart, TailPart, Permutation).

% 12) Drzewo binarne D jest albo pusty (repezentowane przez nil) albo 
% zawiera element X i dwa poddrzewa L i P (reprezentowane przez drzewo(X,L,P)).
% Proszę zdefiniować następujące predykaty dla drzew.

%   size(D,N), który jest spełniony, jeżeli N jest ilością elementów drzewa D.
    size(nil, 0).
    size(tree(_,L,R),N) :-
        size(L,N1),
        size(R,N2),
        N is N1 + N2 + 1.

    % E.G.:
    % size(
    % 	tree(nil, 
    % 		tree(nil, 
    % 			tree(nil,nil,nil),
    % 	        nil
    % 		),
    %     nil
    %     )
    % ).

%   search(D,N), który jest spełniony, jeżeli N jest elementem drzewa D.
    search(tree(N,_,_),N).
    search(tree(_,L,R),N) :-
        search(L,N);
        search(R,N).
    % E.G.:
    % search(tree(a,nil,tree(b,nil,tree(c,nil,nil))),c).

% max(D,N), który jest spełniony, jeżeli N jest maximum elementów w drzewie D.
    max(nil,_).
    max(tree(X,L,R),N) :-
        N >= X,
        max(L,N),
        max(R,N).
    %   E.G.:
    %   max(tree(1,tree(2,nil,nil),tree(3,nil,tree(4,nil,nil))),4).

% times(N,D1,D2), który bierzy wszystkie wartości węzłów drzewa D1 razy N.
    times(_,nil,nil).
    times(N,tree(X1,L1,R1), tree(X2,L2,R2)) :-
        X2 is N*X1,
        times(N,L1,L2),
        times(N,R1,R2).
    %   E.G.:
    %   times(2,tree(2,nil,tree(4,nil,nil)),tree(4,nil,tree(8,nil,nil))).

%   preorder(D,L), który jest spełniony, jeżeli lista L zawiera elementy drzewa D w kolejności prefiksowym.
    preorder(nil,[]).
    preorder(tree(N,L,R),[N|T]) :-
        preorder(L,T1),
        preorder(R,T2),
        append(T1,T2,T).
        % E.G.:
        % preorder(tree(1,tree(2,nil,nil),tree(3,tree(4,nil,nil),nil)),[1,2,3,4]).

%   subtree(D1,D2), który jest spełniony, jeżeli drzewo D1 jest poddrzewem drzewa D1.
    subtree(D,tree(_,D,_)).
    subtree(D,tree(_,_,D)).
    subtree(D,tree(_,L,R)) :-
        subtree(D,L);
        subtree(D,R).
        %   E.G.:
        % subtree(
        %     tree(2,nil,nil),
        %     tree(1,
        %         tree(1,nil,nil),
        %         tree(2,
        %             tree(3,nil,tree(2,nil,nil)),
        %             nil
        %         )
        %     )
        % ).

%   subst(D1,D2,D3,D4), który jest spełniony, jeżeli drzewo D1 jest 
%     drzewem D2, w którym wszystkie poddrzewa D3 zostały zmienione na drzewo D4. 

    subst(nil,nil,_,_).
    subst(tree(N,nil,nil),tree(N,nil,nil),_,_).
    subst(tree(N,L1,R1),tree(N,L2,R2),D3,D4) :-
        L1 = D3,
        L2 is D4;
        L2 is L1;
        R1 = D3,
        R2 is D4;
        R2 is D4;
        subst(L1,L2,D3,D4),
        subst(R1,R2,D3,D4).
    % subst(tree(N,L1,R1),tree(N,L2,R2),D3,D4) :-
    %     subst(L1,L2,D3,D4),
    %     subst(R1,R2,D3,D4).
% subst(
%     tree(1,
%         tree(2,nil,nil),
%         tree(3,
%             tree(4,nil,nil),
%             nil
%         )
%     ),
%     D2,
%     tree(4,nil,nil),
%     nil
% ).