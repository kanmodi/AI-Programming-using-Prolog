/* https://www.cpp.edu/~jrfisher/www/prolog_tutorial/pt_framer.html */
/* Open this code by double clicking. Prolog terminal will open. Then write the function ? - move(noofdisks, left, right, center). */
/* After this it will automatically */

move(1,X,Y,_) :-  
    write('Move top disk from '), 
    write(X), 
    write(' to '), 
    write(Y), 
    nl. 
move(N,X,Y,Z) :- 
    N>1, 
    M is N-1, 
    move(M,X,Z,Y), 
    move(1,X,Y,_), 
    move(M,Z,Y,X). 