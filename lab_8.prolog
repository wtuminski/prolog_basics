% 23) Niech będzie dana następująca definicja predykatu memberc(X,L).
%       memberc(X,[X|_]) :- !.
%       memberc(X,[_|L]) :- memberc(X,L).
%   Proszę porównać tą definicję z zwykłą definicją member(X,L).

% Różnica między memberc/2 a member/2 polega na tym, że memberc/2 zawiera instrukcję cut (znak !), która powoduje, że po znalezieniu elementu X w liście L, reszta rekurencji jest odcinana i nie jest już przeszukiwana. W przypadku member/2 rekurencja kontynuowana jest aż do końca listy.
% Na przykład, gdybyśmy chcieli sprawdzić, czy element a jest elementem listy [a,b,c,d], to memberc/2 zwróciłoby true po pierwszym porównaniu, natomiast member/2 sprawdziłoby wszystkie elementy listy, zanim zwróciłoby true.

    % Predykat memberc/2:
                    %            memberc(b,[a,b,c,d])
                    %                 |
                    %                 |
                    %                 V
                    %  memberc(b,[b,c,d])
                    %                 |
                    %                 |
                    %                 V
                    %           true

    % Predykat member/2:
                    %            member(b,[a,b,c,d])
                    %                 |
                    %                 |
                    %                 V
                    %  member(b,[b,c,d])
                    %                 |
                    %                 |
                    %                 V
                    %  member(b,[c,d])
                    %                 |
                    %                 |
                    %                 V
                    %           false


% 24) Proszę zdefiniować predykat delete(X,L1,L2), który jest spełniony, wtedy i tylko wtedy L2 jest listą L1 bez wszystkich wystąpień elementu X.
delete(_,[],[]).
delete(X,[X|L1],L2) :- delete(X,L1,L2).
delete(X,[Y|L1],[Y|L2]) :- X \= Y, delete(X,L1,L2).

% 25) Niech będzie dana następująca definicja.
%  max(X,Y,X) :- X >= Y, !.
%  max(X,Y,Y).

% Na kolejne pytanie Prolog odpowiada "błędnie":
%  ?- max(5,2,2).
%  yes

% Dlaczego Prolog tak odpowiada i jak można to zreperować (bez zmian cut'u i drugiej reguły)?  

% ODP: Prolog błędnie, ponieważ zapytanie nie spełnia warunków pierwszej definicji predykatu max/3 i od razu przechodzi do drugiej (bez stostowania "cut"), która to zwraca true.
max(X,Y,Z) :- X >= Y, !, X = Z.
max(X,Y,Y).

% 26) Proszę zdefiniować predykat if-then-else(W,C,A), który realizuje operator "if W then C else A". 

if_then_else(W,C,_) :- W, !, C.
if_then_else(_,_,A):- A.
