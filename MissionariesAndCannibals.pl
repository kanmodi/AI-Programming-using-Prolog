/*

https://en.wikipedia.org/wiki/Missionaries_and_cannibals_problem

http://www.geeksforgeeks.org/missionaries-and-cannibals/

http://artificialintelligence-notes.blogspot.in/2011/04/missionaries-and-cannibals-problem.html

http://learnfrommike.blogspot.in/2012/09/solving-missionaries-and-cannibals.html

http://www.dailyfreecode.com/Code/production-system-missionary-cannibal-3046.aspx

http://www.dailyfreecode.com/Code/prolog-missionary-cannibal-problem-3052.aspx

*/


% A Prolog program for the missionaries and cannibals problem (Problem 3.9, page 115).

% To run this problem, please start gprolog on a CS Linux
% workstation by typing gprolog. At the prompt ?- type in "[mission]." as
% follows:
%         | ?- [mission].
% and then type in "solve." as follows:
%         | ?- solve.

% To quit Prolog, type "halt." at ?-
% You may interrupt the execution by typing Ctrl-C and then "a" for abort.

solve :-
    initial( Start),
    breadthfirst( [ [Start] ], Solution),
    % Solution is a path (in reverse order) from initial to a goal
    write(Solution), nl,
    printsol(Solution).

% safe(NumOfMissionaries, NumOfCannibals) is true if NumOfMissionaries is 0 or 3 or equal to NumOfCannibals
safe(0, _).
safe(3, _).
safe(X, X).

% A state is represented by a term:
%    state( NumOfMissionaries, NumOfCannibals, BoatAtEast)
initial(state(3,3,1)).
goal(state(0,0,0)).
goalpath([Node | _]) :- goal(Node).

% move( State1, State2): making a move in State1 results in State2;

move( state( M1, C1, 1),   % Before move
      state( M2, C1, 0) )  % After move
   :- M1 > 1, M2 is M1-2, safe(M2, C1).  % Two missionaries from east to west

move( state( M1, C1, 0),   % Before move
      state( M2, C1, 1) )  % After move
   :- M1 < 2, M2 is M1+2, safe(M2, C1).  % Two missionaries from west to east

move( state( M1, C1, 1),   % Before move
      state( M1, C2, 0) )  % After move
   :- C1 > 1, C2 is C1-2, safe(M1, C2).  % Two cannibals from east to west

move( state( M1, C1, 0),   % Before move
      state( M1, C2, 1) )  % After move
   :- C1 < 2, C2 is C1+2, safe(M1, C2).  % Two cannibals from west to east

move( state( M1, C1, 1),   % Before move
      state( M1, C2, 0) )  % After move
   :- C1 > 0, C2 is C1-1, safe(M1, C2).  % One cannibal from east to west

move( state( M1, C1, 0),   % Before move
      state( M1, C2, 1) )  % After move
   :- C1 < 3, C2 is C1+1, safe(M1, C2).  % One cannibal from west to east

move( state( M1, C1, 1),   % Before move
      state( M2, C2, 0) )  % After move
   :- M1 > 0, M2 is M1-1,  % One missionary and one
      C1 > 0, C2 is C1-1, safe(M2, C2).  % cannibal from east to west

move( state( M1, C1, 0),   % Before move
      state( M2, C2, 1) )  % After move
   :- M1 < 3, M2 is M1+1,  % One missionary and one
      C1 < 3, C2 is C1+1, safe(M2, C2).  % cannibal from west to east

printsol([X]) :- write(X), write(': initial state'), nl.
printsol([X,Y|Z]) :- printsol([Y | Z]), write(X), explain(Y, X), nl.

explain(state(M1, C1, 1), state(M2, C2, _)) :-
    X is M1-M2, Y is C1-C2,
    write(': '), write(X), write(' missionaries and '),
    write(Y), write(' cannibals moved from East to West').
explain(state(M1, C1, 0), state(M2, C2, _)) :-
    X is M2-M1, Y is C2-C1,
    write(': '), write(X), write(' missionaries and '),
    write(Y), write(' cannibals moved from West to East').



% An implementation of breadth-first search.

% breadthfirst( [ Path1, Path2, ...], Solution):
%   each Pathi represents [Node | Ancestors ], where Node is in the open list and
%   Ancestors is a path from the parent of Node to the initial node in the search tree.
%   Solution is a path (in reverse order) from initial to a goal.

breadthfirst( [ Path | _], Path)  :-
    goalpath( Path ).  % if Path is a goal-path, then it is a solution.

breadthfirst( [Path | Paths], Solution)  :-
  extend( Path, NewPaths),
  append( Paths, NewPaths, Paths1),
  breadthfirst( Paths1, Solution).

% setof(X, Condition, Set) is a built-in function: it collects all X satisfying Condition into Set.
extend( [Node | Path], NewPaths)  :-
  setof( [NewNode, Node | Path],
         ( move( Node, NewNode), not(member( NewNode, [Node | Path] )) ),
         NewPaths),
  !.

extend( _, [] ).              % setof failed: Node has no successor

not(P) :- P, !, fail.
not(_).























































