% Esse � o meta interpretador b�sico do Prolog segundo o livro do
% Bratko.


membro(X, [X|_]).
membro(X, [_|L]) :- membro(X, L).

teste(N1, N3) :-
    membro(N1, _),
    membro(N2, _),
    membro(N3, [N1, N2]).

prove( true) :- !.

prove( clause( Head, Body)) :-
    %dynamic( Head),
    clause( Head, Body).
    % prove( Body).

prove( ( Goal1, Goal2)) :-
    prove( Goal1),
    prove( Goal2).

prove( Goal) :-
    %dynamic(Goal),
    %not(=(Goal, true)),  % Isso resolve o problema de true/0 sem o corte! Mas n�o
                      % permite que o programa meta-interprete-se
    clause( Goal, Body),
    prove(Body).

% N�o � capaz de lidar com predicados embutidos nem com o corte.
% Por causa disso:
% ?- prove(member(X, [a, b, c])).
% false.
% -------------------------------
% ?- prove( prove( member(X, [a, b, c]))).
% ERROR: No permission to access private_procedure `clause/2'
% -----------------------------------------------------------
% >>> Exercicio 23.1:
% O erro ocorre justamente porque ele n�o pode lidar com o predicado
% embutido clause/2. Uma modifica��o simples para impedir isso �:
%
%prove( clause( Head, Body)) :-
%    clause( Head, Body).

%prove( A) :-
%    =(A, clause( Head, Body)),
%    clause(Head, Body).
%
% Por algum montivo a solu��o do Bratko n�o quer funcionar.
% ?- clause( member(X, L), Body).
% false.
% ------------------------------- ??????????
% A resposta esperada era
% X = _14
% L = [_14 | _15]
% Body = True; ...
%
% ?- [user].
% |: membro(X, [X|_]).
% |: membro(X, [_|L]) :- membro(X, L).
% |: :- dynamic(membro/2).  % N�o precisa desse dynamic.
% -------------------------------------
% L = [X|_],
% Body = true ;
% L = [_|_A],
% Body = membro(X, _A)


%:- dynamic(prove/2).
%:- dynamic(prove/1).
%:- dynamic(clause/2).
% N�o tenho permissao para alterar um est�tico embutido.
% Dinamizar prove/1 n�o funcionou

% O que fez funcionar:
%  Definir a opera��o que queremos (ex: membro/2).
%
% Problemas:
%  A presen�a de corte gera erro quando chamos prove/1 com prove/1. Isso
%  n�o ocorre quando temos prove( true) :- ! e chamamos prove/1 sozinho.
%
