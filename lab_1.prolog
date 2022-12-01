%  ["~/Projects/studia/semestr_3/programowanie_w_logice/lab_1.prolog"].

% Zadania (Prolog)

% 1) 
    % Długość listy można w Prologu zdefiniować następująco:
    %   length(0,[]).
    %   length(N,[_|L]) :- length(M,L), N is M+1.


my_length([],0).
my_length([_|L],N) :- 
    my_length(L,M), N is M+1.

my_member([V|Other],N) :- 
    N == V; my_member(Other,N). 
my_member([V],N):- 
    N == V.


% 2)
    % Proszę zdefiniować predykaty member/2 oraz sil/2, fib/2 i nwd/3. 

silnia(0,1).
silnia(N,S) :- 
    N > 0,
    N1 is N-1,
    silnia(N1,S1), 
    S is N * S1.

fib(0,0).
fib(1,1).
fib(N,R) :-
    N > 1,
    N1 is N-1,
    N2 is N1-1,
   	fib(N1,R1),
    fib(N2,R2),
    R is R1 + R2.

nwd(1,1,1).
nwd(A,B,R) :-
    A > 0,
    B > 0,
    B1 is A mod B,
    B1 \= 0,
    nwd(B,B1,R).
nwd(A,B,R) :-
    A > 0,
    B > 0,
    B1 is A mod B,
    B1 == 0,
    R is B.

%Testy
% my_length([1,2,3],L);
% my_member([5],5);
% silnia(15,S);
% silnia(12,123);
% fib(0,0);
% fib(0,1);
% fib(0,F);
% fib(1,0);
% fib(1,1);
% fib(1,F1);
% fib(2,0);
% fib(2,3);
% fib(2,F2)
% fib(6,F)