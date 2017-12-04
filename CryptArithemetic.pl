conc([],L,L).
conc([H|T],L,[H|R]):-conc(T,L,R).

member(X,[X|_]).
member(X,[_|T]):-member(X,T).

insert(X,L,[X|L]):-not(member(X,L)).
insert(X,L,L):-member(X,L).

revacc([],R,R):-!.
revacc([H|T],A,R):-revacc(T,[H|A],R).
rev(L,R):-revacc(L,[],R).

tostr([],_,[]):-!.
tostr([N|L],A,[C|S]):-member([N|Vn],A),C is Vn+48,tostr(L,A,S).

%Solve Cryptarithmetic problem : eg. solve('SEND+MORE=MONEY',R)
solve(Str,R):-name(Str,Stl),conc(Ct,[61|C3],Stl),conc(C1,[43|C2],Ct),
	rev(C1,L1),rev(C2,L2),rev(C3,L3),!,							avalue(L1,L2,L3,[0,1,2,3,4,5,6,7,8,9],[],0,A),
	tostr(C1,A,S1),tostr(C2,A,S2),tostr(C3,A,S3),
	conc(S1,[32,43,32|S2],St1),conc(St1,[32,61,32|S3],St2),name(R,St2).

avalue([],[],[],_,A,0,A):-!.
avalue([],L2,[Z|L3],D,V,C,A):-avalue([0],L2,[Z|L3],D,V,C,A),!.
avalue([X|L1],[],[Z|L3],D,V,C,A):-avalue([X|L1],[0],[Z|L3],D,V,C,A),!.
avalue([X|L1],[Y|L2],[],D,V,C,A):-avalue([X|L1],[Y|L2],[0],D,V,C,A),!.
avalue([X|L1],[Y|L2],[Z|L3],D,V,C,A):-
	getv(X,D,V,V1,Vx),getv(Y,D,V1,V2,Vy),
	Sz is Vx+Vy+C,(Sz>9,Vz is Sz-10,Nc is 1;Sz<10,Vz is Sz,Nc is 0),
	(member([Z,Vz],V2),Nv = V2;
	not(member([Z,_],V2)),not(member([_,Vz],V2)),insert([Z,Vz],V2,Nv)),
	avalue(L1,L2,L3,D,Nv,Nc,A).

getv(X,_,V,V,0):-	X<1.
getv(X,_,V,V,Vx):-	X>0,member([X,Vx],V).
getv(X,D,V,V1,Vx):-	X>0,not(member([X,_],V)),member(Vx,D),
	not(member([_,Vx],V)),insert([X,Vx],V,V1).
