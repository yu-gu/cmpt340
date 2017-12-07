female(elizabeth).
female(camilla).
female(diana).
female(catherine).
female(charlotte).
male(philip).
male(charles).
male(harry).
male(william).
male(george).
child_of(charles,philip).
child_of(william,charles).
child_of(harry,charles).
child_of(george,william).
child_of(charlotte,william).
child_of(charles,elizabeth).
child_of(william,diana).
child_of(harry,diana).
child_of(george,catherine).
child_of(charlotte,catherine).
married_to(elizabeth,philip).
married_to(philip,elizabeth).
married_to(charles,diana).
married_to(diana,charles).
married_to(charles,camilla).
married_to(camilla,charles).
married_to(william,catherine).
married_to(catherine,william).
aunt_of(X,Y):-female(X),child_of(Y,Z),child_of(Z,W),child_of(X,W).
grandchild_of(X,Y):-child_of(X,Z),child_of(Z,Y).
mother_of(X,Y):-female(X),child_of(Y,X).
father_of(X,Y):-male(X),child_of(Y,X).
stepmother_of(X,Y):-female(X),father_of(Z,Y),married_to(Z,X),not(mother_of(X,Y)).
nephew_of(X,Y):-male(X),grandchild_of(X,Z),child_of(Y,Z),not(child_of(X,Y)).
mother_in_law_of(X,Y):-married_to(Y,Z),mother_of(X,Z).
brother_in_law_of(X,Y):-male(X),mother_of(Y,Z),mother_in_law_of(X,Z).
ancestor_of(X,Y):-(grandchild_of(Y,Z),child_of(Z,X));(grandchild_of(X,Y));(child_of(Y,X)).


/**
son_of(X,Y):-male(X),child_of(Y,X).
*/