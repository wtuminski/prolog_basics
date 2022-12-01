% 7)
    % Niech będą dane następujące predykaty:

    %  q1(X,Y) :- p(X,Y).                q2(X,Y) :- p(X,Z), q2(Z,Y).
    %  q1(X,Y) :- p(X,Z), q1(Z,Y).       q2(X,Y) :- p(X,Y).  

    %  q3(X,Y) :- p(X,Y).                q4(X,Y) :- q4(X,Z), p(Z,Y).  
    %  q3(X,Y) :- q3(X,Z), p(Z,Y).       q4(X,Y) :- p(X,Y).  

    % oraz baza danych dla predykat p:

    %  p(pam,bob).       
    %  p(tom,bob).
    %  p(tom,liz).
    %  p(bob,ann).      
    %  p(bob,pat).     
    %  p(pat,jim). 

    % Używając drzewo odpowiedzi proszę zilustrować, 
    % jak Prolog odpowiada na pytania ?-qi(tom,pat). oraz ?-qi(liz,jim).

% Odpowiedź:
% A) ?-qi(tom,pat).
% q1(tom,pat)
    % p(tom, pat) => false
    % p(tom, Z), q1(Z,pat).
    % p(Z,pat) => Z is bob.
    % q1(tom, bob) => true

% q2(tom,pat) => p(tom,Z), q2(Z,pat).
    % p(tom, Z) => Z is bob.
    % q2(bob,pat) => p(bob,Z1), q2(Z1,pat).
        % p(bob,Z1) => Z1 is ann.
            % q2(ann,pat) => p(ann,Z2), q2(Z2,pat).
                % p(ann, Z2) => false
                % p(ann,pat) => false (REDO q2(ann,pat))
        % p(bob, Z1) => Z1 is pat
            % q2(pat,pat) => p(pat,Z2), q2(Z2,pat).
                % p(pat,Z2) => Z2 is jim
                % q2(jim,pat) => p(jim,Z3), q2(Z3,pat).
                    % p(jim, Z3) => false
                    % p(jim,pat) => false (REDO q2(jim,pat))
                % p(pat,pat) => false ((REDO q2(pat,pat)))
        % p(bob,pat) => true (REDO q2(bob,pat))
% true

% q3(tom,pat) => p(tom,pat).
    % p(tom,pat) => false
    % q3(tom,Z), p(Z,pat) (REDO q3(tom,pat))
        % q3(tom,Z)
            % p(tom,Z) => Z is bob
        % p(bob,pat) => true
% true

% q4(tom,pat) => q4(tom,Z), p(Z,pat).
    % q4(tom,Z) => q4(tom,Z1), p(Z1,Z).
        % q4(tom,Z1) => q4(tom,Z2), p(Z2,Z1).
%  nieskończona pętla
                
            

% 8)
    % Proszę zdefiniować następujące predykaty dla list.

    % last(X,L), który jest spełniony, jeżeli X jest ostatnim elementem listy L.
    last(X,[X|[]]).
    last(X, [_|T]) :-
        last(X,T).

    % delete(X,L1,L2), który jest spełniony, jeżeli L2 równa się L1 bez elementu X.
    my_delete(_,[],[]).
    my_delete(X,[H1|T1],[H2|T2]):-
        H1 \= X,
        H1 = H2,
        my_delete(X,T1,T2).
    my_delete(X,[H1|T1],L2):-
        H1 = X,
        my_delete(X,T1,L2).

    % delete(L1,L2), który jest spełniony, jeżeli L2 równa się L1 bez ostatnich trzech elementów.
        delete2([],[]).
        delete2([_,_,_|[]],[]).
        delete2([H1|T1],[H2|T2]) :-
            H1 = H2,
            delete2(T1,T2).

    % reverse(L1,L2), który jest spełniony, jeżeli L2 jest listą L1 w odwrotnej kolejności.

    reverse([],[]).
    reverse([H|T],Reversed) :-
        reverse(T,RevTail),
        append(RevTail,[H],Reversed).


    % evenlength(L) oraz oddlength(L), które są spełnione, jeżeli długość listy L jest parzysta oraz nieparzysta.

        evenlength([]).
        evenlength([_,_|[]]).
        evenlength([_,_|T]):-
            evenlength(T).

        oddlength([_|[]]).
        oddlength(_|T) :-
            oddlength(T).
        
    % shift(L1,L2), który jest spełniony, jeżeli L2 równa się L1 po jednej rotacji do lewej.
    % Przykład:

    %  ?- shift([1,2,3,4,5],L).
    %  L = [2,3,4,5,1] 

    shift([],[]).
    shift([H|T],L2) :-
        append(T,[H],L2).

    % quadrat(L1,L2), który jest spełniony, jeżeli L2 zawiera quadraty elementów listy L1.
    % Przykład:

    %  ?- quadrat([1,2,3,4,5],L).
    %  L = [1,4,9,16,25] 

    quadrat([],[]).
    quadrat([H1|T1],[H2|T2]) :-
        H2 is H1**2,
        quadrat(T1,T2).

    % combine(L1,L2,L3), który jest spełniony, jeżeli L3 zawiera pary elementów z list L1 i L2.
    % Przykład:

    %  ?- combine([1,2,3,4],[a,b,c,d],L).
    %  L = [[1,a],[2,b],[3,c],[4,d]] 

    combine([],[],[]).
    combine([H1|T1],[H2|T2],[[H1,H2]|L3]) :-
        combine(T1,T2,L3).

    % palindrom(L), który jest spełniony, jeżeli lista L zawiera palindrom.
    % Przykłady:

    %  ?- palindrom([a,b,c]).
    %  no
    %  ?- palindrom([a,b,c,d,c,b,a]).
    %  yes 

    palindrom([]).
    palindrom([_]).
    palindrom([H|T]) :-
        reverse(T,[H|T1]),
        palindrom(T1).


    % p(X,L,Y,Z), który jest spełniony, jeżeli Y jest poprzednikiem elementu X w liście L a Z następcą elementu X w liście L.
    % Przykład:

    %  ?- p(3,[1,2,3,4,5],Y,Z).
    %  Y = 2, Z = 4 

    p(X,[Y,X,Z|_],Y,Z).
    p(X,[_|T],Y,Z) :-
        p(X,T,Y,Z).

    % q(X,L1,L2), który jest spełniony, jeżeli L2 równa się początku listy L1 do podwójnego wystąpienia elementu X.
    % Przykład:

    %  ?- q(3,[1,2,3,3,1,2,4],Z).
    %  Z = [1,2,3,3] 

    q(X,[H1,H2,X,X|_],[H1,H2,X,X]).
    q(X,[H|T1],[H|T2]) :-
        q(X,T1,T2).

% 9)
    % Niech będą dane następująca defincja predykatu append.

    % append([X|L1], L2, [X|L3]) :- append(L1, L2, L3).
    % append([], L, L).   

    % Proszę zilustrować, jak Prolog odpowiada na pytanie

    % ?- append(X, [3,4], [2,3,4]).
        % append([2|[]],[3,4],[2|[3,4]]) => append([],[3,4],[3,4]) => end.


