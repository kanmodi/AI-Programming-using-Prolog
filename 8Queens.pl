/*

 prolog tutorial 2.11 Chess queens challenge puzzle 

 https://www.cpp.edu/~jrfisher/www/prolog_tutorial/2_11.html

 https://swish.swi-prolog.org/example/queens.pl

http://www.cse.scu.edu/~rdaniels/html/courses/Coen171/NQProlog.htm - for n queens

https://stackoverflow.com/questions/4852138/prolog-programming

To run this code, write solve(P).
The result is permutaion to place 8 queens in 64x64 chess board

 */

perm([X|Y],Z) :- perm(Y,W), takeout(X,Z,W).   
perm([],[]).

takeout(X,[X|R],R).
takeout(X,[F|R],[F|S]) :- takeout(X,R,S).

solve(P) :-
     perm([1,2,3,4,5,6,7,8],P), 
     combine([1,2,3,4,5,6,7,8],P,S,D),
     all_diff(S),
     all_diff(D).

combine([X1|X],[Y1|Y],[S1|S],[D1|D]) :-
     S1 is X1 +Y1,
     D1 is X1 - Y1,
     combine(X,Y,S,D).
combine([],[],[],[]).

all_diff([X|Y]) :-  \+member(X,Y), all_diff(Y).
all_diff([X]).

