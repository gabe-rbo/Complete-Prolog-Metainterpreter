mi7(true) :- !.
mi7(!) :- !. % Tupla vazia

mi7(Goal) :-  % Goal n�o pode ser uma tupla, tem que ser um predicado
    \=(Goal, (_, _)),
    (built_in(Goal) -> call(Goal)
    ;   clause(Goal, Body),
        (encontra_cortes(Body, BodyEsq, BodyDir) -> mi7(BodyEsq), !, mi7(BodyDir) % Cortamos a raiz.
        ;   mi7(Body))).

mi7((Goal1, Goals)) :-  % Tupla.
    (encontra_cortes((Goal1, Goals), GoalsEsq, GoalsDir) -> mi7(GoalsEsq), !, mi7(GoalsDir)
    ;   mi7(Goal1), mi7(Goals)).

% Predicados Auxiliares
built_in(Predicate) :-
    predicate_property(Predicate, built_in).

% Encontra cortes agora funciona recursivamente sobre tuplas.
encontra_cortes((E, (!, Elementos)), E, Elementos) :- \=(E, (_, _)), !.
encontra_cortes((!, Elementos), !, Elementos) :- !. % N�o h� tupla vazia
encontra_cortes((E, !), E, !) :- !.
encontra_cortes((E1, Elementos), (E1, TuplaEsq), TuplaDir) :-
    encontra_cortes(Elementos, TuplaEsq, TuplaDir).
