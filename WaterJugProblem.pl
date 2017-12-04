/*

http://www.dailyfreecode.com/code/prolog-water-jug-problem-start-state00-3107.aspx

http://www.dis.uniroma1.it/~corsoai1/index2.php?option=com_docman&task=doc_view&gid=7&Itemid=73

https://stackoverflow.com/questions/18040196/water-jug-puzzle-in-swi-prolog

http://www.binding-time.co.uk/wiki/index.php/The_Water_Jugs_Problem

http://www.dailyfreecode.com/Code/prolog-water-jug-problem-start-state00-3107.aspx

To run this program, write f(4,3).

*/

f(2,Y):-write(" 2 0 \n").
f(X,2):-write(" 0 2 \n").

f(X,Y):- Y = 0, X \= 4,
    format(" ~w 3 \n",X),
    f(X,3).

f(X,Y):-X = 0,Y \= 3,
        write(" 4 ~w \n",Y),
        f(4,Y).

f(X,Y):-X + Y >= 4, Y > 0, X \=4,
        Y1 is Y - 4 + X,
        format(" 4 ~w \n",Y1),
        f(4,Y1); X + Y >= 4, Y > 0, Y \= 3,
        Y1 is Y-4+X,
        format(" 4 ~w \n",Y1),
        f(4,Y1).

f(X,Y):-X + Y >= 3, X > 0, X \= 4,
        X1 is X - 3 + Y,
        format(" ~w 3 \n",X1),
        f(X1,3);X + Y >= 3, X > 0, Y \= 3,
        X1 is X-3+Y,
        format(" ~w 3 \n",X1),
        nl,
        f(X1,3).

f(X,Y):-X + Y =< 4, Y > 0,
        X1 is X+Y,
        format(" ~w 0 \n",X1),
        f(X1,0).

f(X,Y):-X + Y =< 3, X > 0,
        Y1 is X+Y,
        format(" 0 ~w \n",Y1),
        f(0,Y1).

f(X,Y):-X > 0,
        format(" 0 ~w \n",Y),
        f(0,Y).

f(X,Y):-Y>0,
        format(" ~w 0 \n",X),
        f(X,0).























