
adjacente(X,Y,A,B):- A is X+1,B is Y.
adjacente(X,Y,A,B):- A is X-1,B is Y.
adjacente(X,Y,A,B):- A is X,B is Y+1.
adjacente(X,Y,A,B):- A is X,B is Y-1.

brisa(A,B) :- poco(X,Y),adjacente(X,Y,A,B).
fedor(A,B) :- inimigo(X,Y),adjacente(X,Y,A,B).
flash(A,B) :- tp(X,Y),adjacente(X,Y,A,B).

%melhor_acao(Estado1,Melhor_acao,Estado2).
