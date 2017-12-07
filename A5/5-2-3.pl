%Problem2
%Fact: marriage
married_to(elizabeth,philip).
married_to(philip,elizabeth).
married_to(diana,charles).
married_to(charles,diana).
married_to(camilla,charles).
married_to(charles,camilla).
married_to(catherine,william).
married_to(william,catherine).

%Fact: child of
child_of(charles, elizabeth).
child_of(charles, philip).
child_of(william, diana).
child_of(william, charles).
child_of(george, william).
child_of(george, catherine).
child_of(charlotte, william).
child_of(charlotte, catherine).
child_of(harry,diana).
child_of(harry,charles).

%Fact: male
male(philip).
male(charles).
male(william).
male(harry).
male(george).

%Fact: female
female(elizabeth).
female(diana).
female(camilla).
female(catherine).
female(charlotte).



%Problem3
%a
aunt_of(X,Y):-
female(X),child_of(Y,Z),child_of(Z,P),child_of(X,P).

%b
grandchild_of(X,Y):-
child_of(X,P),child_of(P,Y).

%c
mother_of(X,Y):-
female(X),child_of(Y,X).

%d
stepmother_of(X,Y):-
female(X),father_of(Z,Y),married_to(Z,X),not(child_of(Y,X)).

%e
nephew_of(X,Y):-
male(X),grandchild_of(X,Z),child_of(Y,Z),not(child_of(X,Y)).


%f
mother_in_law_of(X,Y):-
female(X),married_to(Y,Z), mother_of(X,Z),not(child_of(Y,X)).

%g
brother_in_law_of(X,Y):-
male(X), sibling_of(X, S), married_to(S, Y).

%h - three cases using or expression
ancestor_of(X,Y):- 
child_of(Y,X); grandchild_of(Y,Z), child_of(Z,X); grandchild_of(Y,X).

%helper
father_of(X,Y):-
male(X),child_of(Y,X).

%helper
sibling_of(X, Y) :- 
child_of(X, P), child_of(Y, P), child_of(X, K), child_of(Y, K), (P \= K), (X \= Y).
