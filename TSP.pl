%%----------------------------------------------------------------
%% TRAVELING SALESMAN DATA
%%----------------------------------------------------------------
city(boston).
city(new_york).
city(phoenix).
city(portland).
city(tucson).
city(seattle).
city(washington).

c(boston,new_york, 2).
c(boston,phoenix, 6).
c(boston,portland, 3).
c(boston,seattle,8).
c(boston,tucson, 6).
c(boston,washington,4).

c(new_york,phoenix,2).
c(new_york,portland,1).
c(new_york,seattle,9).
c(new_york,tucson,7).
c(new_york,washington,2).

c(phoenix,portland,1).
c(phoenix,seattle,4).
c(phoenix,tucson,4).
c(phoenix,washington,5).

c(portland,seattle,5).
c(portland,tucson,6).
c(portland,washington,8).

c(seattle,tucson,6).
c(seattle,washington,7).

c(tucson,washington,9).


cost(A,B,V):-c(A,B,V);c(B,A,V).


%%----------------------------------------------------------------
%% TRAVELING SALESMAN PROGRAM
%%----------------------------------------------------------------

/* perm(A,B): B is a permutation of A; Generator of B's */
perm([],[]).
perm([A|S],[A|T]):-perm(S,T).
perm([A|S],[B|T]):-perm(S,T1), exchange(A,B,T1,T).

/* exchange A for B in set S to obtain set T*/
exchange(A,B,[B|T],[A|T]).
exchange(A,B,[C|S],[C|T]):-exchange(A,B,S,T).

cities(P):-setof(C,city(C),P).
walk([C|W]):-cities([C|P]),perm(P,W).

ccost([A|R],V):-ccost([A|R],V,A).

ccost([A],V,F):-cost(A,F,V),!.
ccost([A,B|R],V,F):-
	cost(A,B,V1),
	ccost([B|R],V2,F),
	V is V1+V2.

itinerary(W,V):- walk(W),ccost(W,V).

solve(X):-setof(V-W,itinerary(W,V),B),best(B,X).
best([K-P|R],X):-best(R,L-Q),better(K-P,L-Q,X),!.
best([X],X).

better(K-P,L-_,K-P):-K<L,!.
better(_,X,X).




