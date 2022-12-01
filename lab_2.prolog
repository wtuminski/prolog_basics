% 2)
    % Niech będzie dana baza danych zawierająca predykaty parent/2, female/1 i male/1. 
    % Proszę zdefiniować predykaty child/2, mother/2, sister/2, has_a_child/1, grandparent/2 oraz predecessor/2. 

parent(bob,ann).
parent(bob,jim).
parent(jane,ann).
parent(jane,frank).
parent(ann,philip).
parent(ann,sam).
parent(jim,marie).
parent(jim,john).
parent(philip,karen).
parent(philip,fin).
parent(karen,alfred).
parent(alfred,rosalia).

female(ann).
female(jane).
female(sam).
female(marie).

male(bob).
male(jim).
male(frank).
male(philip).
male(john).

child(ann,bob).
child(Parent,Child) :-
    parent(Child,Parent).

mother(Child,Parent) :-
    parent(Child,Parent),
    female(Parent).

sister(Sister,Sibling) :-
    female(Sister),
    Sister \= Sibling,
    parent(Sibling, Parent),
    parent(Sister,Parent).

has_a_child(Parent) :-
    parent(_,Parent).

grandparent(Grandchild,Grandparent) :-
    parent(Grandchild, Parent),
    parent(Parent, Grandparent).

predecessor(Person,Predecessor) :-
    parent(Person,Predecessor).

predecessor(Person,Predecessor) :-
    parent(Person, Parent),
    predecessor(Parent,Predecessor).


% 3)
    % Niech będzie dany następujący program:
     f(1,one).
     f(s(1),two).
     f(s(s(1)),three).
     f(s(s(s(X))),N) :- f(X,N). 
    % Jak odpowiada Prolog na pytanie 
    % f(s(1),A)?  => A = two
    % f(s(s(1)),two)? => false
    % f(s(s(s(s(s(s(1)))))),C)? => C = one
    % f(D,three)?  => D = s(s(1)) 

    % ODP: Przy regule rekurencyjnej wyciąga 3 x `s()` i wywołuje f z tym co zostaje w środku.


% 4)
    % Proszę zdefiniować predykat rzym/2, który transformuje rzymskie liczby do liczb dziesiętnych.
    % Liczby rzymskie można po prostu reprezentować jako listy, n.p. [x,l,v,i,i]. 

conversionHelper(X,[[V,V1]|_],R):-
    X = V,
    R = V1.
conversionHelper(X,[_|T],R1) :-
    conversionHelper(X,T,R1).

convert(Roman,Decimal):-
    conversionHelper(
        Roman,
        [[i,1],[v,5],[x,10],[l,50],[c,100],[d,500],[m,1000]],
        R
     ),
     Decimal is R.

rome([],0).
rome([H1,H2|T],D) :-
    rome(T,D1),
    convert(H1,D2),
    convert(H2,D3),
    D2 < D3,
    D is D1-D2+D3.
rome([H|T],D) :-
    rome(T,D1),
    convert(H,D2),
    D is D1+D2.

% 5)
    % Proszę zdefiniować predykaty plus/3, times/3, fib/2 oraz sum-up/2 w sposobie rekurencyjnym.
    % Predykat sum-up(N,X) ma być spełniony, jeżeli X jest sumą liczb od 0 do N.

plus(A,B,C) :-
    B = 0,
    C is A.
plus(A,B,C) :-
    A1 is A + 1,
    B1 is B - 1,
    plus(A1,B1,C1),
    C is C1.

times(_,B,C) :-
    B = 0,
    C is 0.
times(A,B,C) :-
    B > 0,
    B1 is B - 1,
    times(A,B1,C1),
    C is A + C1.
times(A,B,C) :-
    B < 0,
    B1 is B + 1,
    times(A,B1,C1),
    C is -A + C1.

fib(0,0).
fib(1,1).
fib(N,R) :-
    N > 1,
    N1 is N-1,
    N2 is N-2,
    fib(N1,R1),
    fib(N2,R2),
    R is R1+R2.

sumUp(N,R) :-
    N = 0,
    R is N.
sumUp(N,R) :-
    N1 is N-1,
    sumUp(N1,R1),
    R is R1+N.

% 6)
    % Predykat sil/2 da się zrealizować następująco.

    %   sil(X,N) :- sil(X,N,1).
    %   sil(0,A,A).
    %   sil(X,N,A) :- X > 0, A1 is A * X, X1 is X - 1, sil(X1,N,A1).

    % Proszę zdefiniować predykaty z zadania 6 używając tą technikę. 
    % (Zmienna A z predykatu sil/3 się nazywa akumulator.)

plus2(A,B,C) :-
    plus2(A,B,C,0).
plus2(A,B,C,ACC) :-
    B = 0,
    C is A + ACC.
plus2(A,B,C,ACC) :-
    B1 is B - 1,
    ACC1 is ACC + 1,
    plus2(A,B1,C1,ACC1),
    C is C1.


times2(A,B,C) :-
    times2(A,B,C,0).
times2(_,B,C,ACC) :-
    B = 0,
    C is ACC.
times2(A,B,C,ACC) :-
    B > 0,
    B1 is B - 1,
    ACC1 is ACC + A,
    times2(A,B1,C1,ACC1),
    C is C1.
times2(A,B,C,ACC) :-
    B < 0,
    B1 is B + 1,
    ACC1 is ACC - A,
    times2(A,B1,C1,ACC1),
    C is C1.

fib2(N,R) :-
    fib2(N,R,0,1).
fib2(0,R,R,_).
fib2(1,R,_,R).
fib2(N,R,A1,A2) :-
    N > 1,
    N1 is N-1,
    A3 is A1+A2,
    fib2(N1,R,A2,A3).


sumUp2(N,R):-
    sumUp2(N,R,0).
sumUp2(0,A,A).
sumUp2(N,R,A) :-
    N > 0,
    N1 is N-1,
    A1 is A+N,
    sumUp2(N1,R,A1).
