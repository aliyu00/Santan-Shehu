train(swansea, cardiff, [3,5,8,15,17,18,19,20,23],1,[4,5,6,7,10,14,18,22,23],2).
train(cardiff, manchester, [7,11,16],4,[8,14,19],5).
train(cardiff, bristol, [3,5,7,11,15,18,19,20],2,[5,6,7,10,14,16,18,22],2).
train(manchester, bristol, [5,6,7,8,11,15,18,19,20],4,[5,6,7,10,14,16,18,22],5).
train(manchester, swansea, [7,11,16],5,[8,14,19],6).
train(manchester, london, [6,7,11,16],4,[7,8,14,19],5).
train(cardiff, london, [5,6,7,11,18,19,20],3,[8,9,17,18,19,20,21],3). 
train(london, brussels, [6,7,8,11,13,17,18,20],5,[9,11,13,16,17,18,19,23],5). 
train(london, paris, [7,11,13,17,18,20],5,[9,11,13,16,18,20],6).
train(paris, brussels, [7,11,17],4,[9,13,19],3).
train(paris, munich, [7,11,13,17,22],8,[5,9,13,19,23],7).
train(munich, vienna, [8,9,11,13,17,19],6,[9,10,12,16,18,23],5). 
train(vienna, venice, [5,7,8,10,13,16,12,23],8,[2,4,7,9,12,20,21,23],9).
train(venice, paris, [4,11,20],11,[9,12,21],10).


%2.(i)
direct(X,Y, XDeps, XDur) :-
       train(X, Y, XDeps, XDur,_,_);
       train(Y, X,_,_, XDeps, XDur).
        mem_rem(H,[H|T],R) :- R=T. 
        mem_rem(X, [H|T], [H|R]) :- 
        mem_rem(X, T, R).

%2.(ii)
con(X,Dep, V, Arr, Y, Cs):-
member(Y,Cs), 
direct(X,Y, XDeps, XDur),
member(Dep, XDeps), 
Arr is (Dep+XDur) mod 24,
V=[].

con(X, Dep, V, Arr, Y, Cs) :- 
direct(X, A, XDeps, XDur),
member(Dep, XDeps),
mem_rem(A, Cs, CsN),  
con(A, DepN, Vn, Arr, Y, CsN), 
MaxDep is DepN-XDur,
between(0, MaxDep, Dep),
ArrA is (Dep + XDur) mod 24,
append([via(ArrA, A, DepN)],Vn,V).

%2.(iii)
connection(X,Dep,V,Arr,Y):-
findall(Z,(train(Z,_,_,_,_,_) ;train(_,Z,_,_,_,_)),CitiesD),
sort(CitiesD, Cities),
writeln(Cities), 
con(X,Dep, V, Arr, Y, Cities).

/*
2.i ?- direct(london,manchester,[7,8,14,19],5).
       True

2.ii ?-

2.iii ?- connection(swansea,Dep,V,Arr,munich).
     V = [via(4, cardiff, 7), via(11, manchester, 11), via(15, london, 17), via(22, paris, 22)]	
     Dep = 3
     Arr = 6
       
