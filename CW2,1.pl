parent(mary,georgeVI).
parent(mary,henry). 
parent(mary,george). 
parent(georgeV,georgeVI).
parent(georgeV,henry). 
parent(georgeV,george). 
parent(elizabeth,elizabethII). 
parent(georgeVI,elizabethII). 
parent(alice,richard). 
parent(henry,richard). 
parent(elizabethII,charles). 
parent(elizabethII,andrew). 
parent(elizabethII,anne). 
parent(elizabethII,edward). 
parent(philip,charles). 
parent(philip,andrew). 
parent(philip,anne). 
parent(philip,edward).
parent(mary,georgeVI).
parent(mary,henry). 
parent(mary,george). 
parent(georgeV,georgeVI). 
parent(georgeV,henry). 
parent(georgeV,george). 
parent(elizabeth,elizabethII).
parent(georgeVI,elizabethII). 
parent(alice,richard). 
parent(henry,richard). 
parent(elizabethII,charles).
parent(elizabethII,andrew).
parent(elizabethII,anne). 
parent(elizabethII,edward).
parent(philip,charles). 
parent(philip,andrew). 
parent(philip,anne). 
parent(philip,edward).
parent(philip,charles). 
parent(philip,andrew). 
parent(philip,anne). 
parent(philip,edward).
parent(mary,georgeVI).
parent(mary,henry). 
parent(mary,george). 
parent(georgeV,georgeVI). 
parent(georgeV,henry). 
parent(georgeV,george). 
parent(elizabeth,elizabethII).
parent(georgeVI,elizabethII). 
parent(alice,richard). 
parent(henry,richard). 
parent(elizabethII,charles).
parent(elizabethII,andrew).
parent(elizabethII,anne). 
parent(elizabethII,edward).
parent(philip,charles). 
parent(philip,andrew). 
parent(philip,anne). 
parent(philip,edward).
parent(diana,william).
parent(diana,harry). 
parent(charles,william). 
parent(charles,harry). 
parent(sarah,beatrice).
parent(sarah,eugenie). 
parent(andrew,beatrice). 
parent(andrew,eugenie). 
parent(anne,peter). 
parent(anne,zara). 
parent(mark,peter). 
parent(mark,zara). 
parent(kate,georgejun). 
parent(kate,charlotte). 
parent(kate,louis). 
parent(william,georgejun). 
parent(william,charlotte). 
parent(william,louis). 
parent(meghan,archie). 
parent(harry,archie).

the_royal_females([mary,elizabeth,elizabethII,alice,anne,diana,sarah, beatrice,zara,eugenie,charlotte,kate,meghan]).
the_royal_males([georgeV,georgeVI,george,philip,charles,andrew,edward, richard,henry, 
                william,harry,peter,georgejun,mark,louis,archie]).


the_royal_family(X) :-
    the_royal_males(A),
    the_royal_females(B),
    append(A, B, X).


father(F, C) :-
    parent(F,C),
    the_royal_males(A),
    member(F, A).

mother(Z, C) :-
    parent(Z,C),
    the_royal_females(B),
    member(Z, B).

granddad(G, C) :-
    father(G, P),
    parent(P, C).


grandma(G, C) :-
    mother(G, P),
    parent(P, C).

has_child(P) :-
    parent(P,C),
    the_royal_family(F),
    member(C, F).

ancestor(A, X) :-
    parent(A, X);
    (
        parent(P, X),
        ancestor(A, P)
    ).

sibling(A, B) :-
    parent(P, A),
    parent(P, B),
    A\=B.


brother(A, B) :-
    sibling(A, B),
    the_royal_males(MALES),
    member(A, MALES).

cousin(X,Y) :- 
     sibling(Z,Y),
     parent(Z,X).

has_cousin_who_is_grandma(X) :-
    cousin(B, X),
    granddad(B, C),
    the_royal_family(FAMILY),
    member(C, FAMILY).


has_brother_who_is_granddad(X) :-
    brother(B, X),
    granddad(B, C),
    the_royal_family(FAMILY),
    member(C, FAMILY).



/*
    Question 1. - the royal family/1 
       
       ?- the_royal_family(X).
       X = [georgeV, georgeVI, george, philip, charles, andrew, edward, richard,...]

    Question 2. - mother 
       ?- mother(X,george).
       X = mary
         
    Question 3. - Grandma
       ?- grandma(G,anne)
       G = elizabeth
         
    Question 4. - has child
       ?- has_child(mary).
          true .
      
    Question 5. -  ancestor 
        ?- ancestor(X,anne).
        X = elizabethII
        X = philip
    
    Question 6. - sibling
        ?- sibling(A,anne).
        A = edward
        A = charles
        A = andrew
    
    
    Question 7. - sister
      ?- sister(charles,B).
         B = anne
         
    Question 8. - Who is a grandchild of George V
      ?- granddad(georgeV,C)
        C = elizabethII
        C = richard
    Question 9. - Who has a child 
      ?- has_child(P).
      
        P = elizabethII
        P = philip
        P = alice
        P = henry
        P = mary
        P = georgeV
        P = elizabeth
        P = Sarah
        P = Andrew
        P = Anne
        P = mark
        P = Kate
        P = meghan
        P = harry 
        
    Question 10. - Who is an ancestor of Archie
        ?- ancestor(A,archie).
        A = meghan
        A = harry
        A = diana
        A = charles
        A = elizabethII
        A = philip
        A = elizabeth
        A = georgeVI
        A = mary
        A = georgeV
        
    Question 11. - Who is a cousin of Eugenie
    ?- cousin (A, Eugiene).
      A = william
      A = harry
      A = peter
      A = zara
    
    Question 12. - Who has a cousin who is grandma
       ?- has_cousin_who_is_grandma(harry). 
          false.
    
    Question 13. - Who has a brother who is a grandfather 
        
        ?- has_brother_who_is_granddad(andrew).
           true .
   
*/
