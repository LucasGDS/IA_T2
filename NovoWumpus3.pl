%	T2 INF1771 - INTELIGENCIA ARTIFICIAL
%	LUCAS GOMES DA SILVA - 1312010
%	MIGUEL BALDEZ BOING - 1312013

:-dynamic estado/5.
:-dynamic visitado/2.
:-dynamic brilho/2.
:-dynamic powerup/2.
:-dynamic ouro_pego/2.
:-dynamic powerup_pego/2.
:-dynamic brisa/2.
:-dynamic fedor/2.
:-dynamic flash/2.
:-dynamic brisa_sentida/2.
:-dynamic fedor_sentido/2.
:-dynamic flash_sentido/2.
:-dynamic nos_abertos/2.
:-dynamic destino/2.
:-dynamic nao_passar/2.

% Seta o estado inicial e os nos abertos
inicializa() :-
	assert(estado(1,1,norte,0,0)),
	assert(destino(1,2)),
	assert(nos_abertos(2,1)),
	assert(visitado(1,1)).

% Altera do estado 1 para o estado 2
altera(Estado1,Estado2) :- retract(Estado1), assert(Estado2).

casa_da_frente(X,Y1,X,Y2,norte):- Y2 is Y1 + 1, Y1 < 12.
casa_da_frente(X,Y1,X,Y2,sul):- Y2 is Y1 - 1, Y1 > 1.
casa_da_frente(X1,Y,X2,Y,leste):- X2 is X1 + 1, X1 < 12.
casa_da_frente(X1,Y,X2,Y,oeste):- X2 is X1 - 1, X1 > 1.

% Verifica se X,Y eh adjacente a A,B
adjacente(X,Y,A,B):- casa_da_frente(X,Y,A,B,norte).
adjacente(X,Y,A,B):- casa_da_frente(X,Y,A,B,sul).
adjacente(X,Y,A,B):- casa_da_frente(X,Y,A,B,leste).
adjacente(X,Y,A,B):- casa_da_frente(X,Y,A,B,oeste).

% Posicao a direita
direita(norte,leste).
direita(leste,sul).
direita(sul,oeste).
direita(oeste,norte).

% Se na casa oposta já foi sentida uma brisa, entao no meio tem um buraco.
% Se duas casas diagonais tem uma brisa e a adjacente foi visitada, a outra adjacente tem um buraco.
% O mesmo para o fedor e o flash.
buraco(X,Y) :- casa_da_frente(X,Y,X1,Y1,norte), casa_da_frente(X,Y,X2,Y2,sul), brisa_sentida(X1,Y1), brisa_sentida(X2,Y2).
buraco(X,Y) :- casa_da_frente(X,Y,X1,Y1,leste), casa_da_frente(X,Y,X2,Y2,oeste), brisa_sentida(X1,Y1), brisa_sentida(X2,Y2).
buraco(X,Y) :- casa_da_frente(X,Y,X1,Y1,norte), casa_da_frente(X,Y,X2,Y2,leste), brisa_sentida(X1,Y1), brisa_sentida(X2,Y2), casa_da_frente(X2,Y2,X3,Y3,norte), visitado(X3,Y3).
buraco(X,Y) :-casa_da_frente(X,Y,X1,Y1,norte), casa_da_frente(X,Y,X2,Y2,oeste), brisa_sentida(X1,Y1), brisa_sentida(X2,Y2), casa_da_frente(X2,Y2,X3,Y3,norte), visitado(X3,Y3).
buraco(X,Y) :-casa_da_frente(X,Y,X1,Y1,sul), casa_da_frente(X,Y,X2,Y2,leste), brisa_sentida(X1,Y1), brisa_sentida(X2,Y2), casa_da_frente(X2,Y2,X3,Y3,sul), visitado(X3,Y3).
buraco(X,Y) :-casa_da_frente(X,Y,X1,Y1,sul), casa_da_frente(X,Y,X2,Y2,oeste), brisa_sentida(X1,Y1), brisa_sentida(X2,Y2), casa_da_frente(X2,Y2,X3,Y3,sul), visitado(X3,Y3).

inimigo(X,Y) :- casa_da_frente(X,Y,X1,Y1,norte), casa_da_frente(X,Y,X2,Y2,sul), fedor_sentido(X1,Y1), fedor_sentido(X2,Y2).
inimigo(X,Y) :- casa_da_frente(X,Y,X1,Y1,leste), casa_da_frente(X,Y,X2,Y2,oeste), fedor_sentido(X1,Y1), fedor_sentido(X2,Y2).
inimigo(X,Y) :- casa_da_frente(X,Y,X1,Y1,norte), casa_da_frente(X,Y,X2,Y2,leste), fedor_sentido(X1,Y1), fedor_sentido(X2,Y2), casa_da_frente(X2,Y2,X3,Y3,norte), visitado(X3,Y3).
inimigo(X,Y) :-casa_da_frente(X,Y,X1,Y1,norte), casa_da_frente(X,Y,X2,Y2,oeste), fedor_sentido(X1,Y1), fedor_sentido(X2,Y2), casa_da_frente(X2,Y2,X3,Y3,norte), visitado(X3,Y3).
inimigo(X,Y) :-casa_da_frente(X,Y,X1,Y1,sul), casa_da_frente(X,Y,X2,Y2,leste), fedor_sentido(X1,Y1), fedor_sentido(X2,Y2), casa_da_frente(X2,Y2,X3,Y3,sul), visitado(X3,Y3).
inimigo(X,Y) :-casa_da_frente(X,Y,X1,Y1,sul), casa_da_frente(X,Y,X2,Y2,oeste), fedor_sentido(X1,Y1), fedor_sentido(X2,Y2), casa_da_frente(X2,Y2,X3,Y3,sul), visitado(X3,Y3).

teletransporte(X,Y) :- casa_da_frente(X,Y,X1,Y1,norte), casa_da_frente(X,Y,X2,Y2,sul), flash_sentido(X1,Y1), flash_sentido(X2,Y2).
teletransporte(X,Y) :- casa_da_frente(X,Y,X1,Y1,leste), casa_da_frente(X,Y,X2,Y2,oeste), flash_sentido(X1,Y1), flash_sentido(X2,Y2).
teletransporte(X,Y) :- casa_da_frente(X,Y,X1,Y1,norte), casa_da_frente(X,Y,X2,Y2,leste), flash_sentido(X1,Y1), flash_sentido(X2,Y2), casa_da_frente(X2,Y2,X3,Y3,norte), visitado(X3,Y3).
teletransporte(X,Y) :-casa_da_frente(X,Y,X1,Y1,norte), casa_da_frente(X,Y,X2,Y2,oeste), flash_sentido(X1,Y1), flash_sentido(X2,Y2), casa_da_frente(X2,Y2,X3,Y3,norte), visitado(X3,Y3).
teletransporte(X,Y) :-casa_da_frente(X,Y,X1,Y1,sul), casa_da_frente(X,Y,X2,Y2,leste), flash_sentido(X1,Y1), flash_sentido(X2,Y2), casa_da_frente(X2,Y2,X3,Y3,sul), visitado(X3,Y3).
teletransporte(X,Y) :-casa_da_frente(X,Y,X1,Y1,sul), casa_da_frente(X,Y,X2,Y2,oeste), flash_sentido(X1,Y1), flash_sentido(X2,Y2), casa_da_frente(X2,Y2,X3,Y3,sul), visitado(X3,Y3).

% Marca se sentiu brisa, fedor ou flash
percebe_sensores(X,Y) :- brisa(X,Y), fedor(X,Y), flash(X,Y), assert(brisa_sentida(X,Y)), assert(fedor_sentido(X,Y)), assert(flash_sentido(X,Y)).
percebe_sensores(X,Y) :- brisa(X,Y), fedor(X,Y), assert(brisa_sentida(X,Y)), assert(fedor_sentido(X,Y)).
percebe_sensores(X,Y) :- brisa(X,Y), flash(X,Y), assert(brisa_sentida(X,Y)), assert(flash_sentido(X,Y)).
percebe_sensores(X,Y) :- fedor(X,Y), flash(X,Y), assert(fedor_sentido(X,Y)), assert(flash_sentido(X,Y)).
percebe_sensores(X,Y) :- brisa(X,Y), assert(brisa_sentida(X,Y)).
percebe_sensores(X,Y) :- fedor(X,Y), assert(fedor_sentido(X,Y)).
percebe_sensores(X,Y) :- flash(X,Y), assert(flash_sentido(X,Y)).
percebe_sensores(_,_).

casa_perigosa(X,Y) :- buraco(X,Y); teletransporte(X,Y); inimigo(X,Y).

% Caso o agente entre em um teletransporte, o programa chama essa funcao
teleporta(X,Y):-
	visitado(X,Y),
	altera(	estado(_,_,Direcao,_,Ouro),
		estado(X,Y,Direcao,0,Ouro)).
teleporta(X,Y):-
	\+ visitado(X,Y),
	percebe_sensores(X,Y),!,
	novos_nos_abertos(X,Y),
	altera(	estado(_,_,Direcao,_,Ouro),
		estado(X,Y,Direcao,0,Ouro)).

% Adiciona um novo no aos nos_abertos se ele nunca foi visto
novo_no(X,Y,Direcao) :-
	(brisa(X,Y); fedor(X,Y); flash(X,Y)),
	casa_da_frente(X,Y,A,B,Direcao),
	\+ visitado(A,B),
	\+ nos_abertos(A,B),
	assert(nos_abertos(A,B)).
novo_no(X,Y,Direcao) :-
	casa_da_frente(X,Y,A,B,Direcao),
	\+ visitado(A,B),
	\+ nos_abertos(A,B),
	asserta(nos_abertos(A,B)).
novo_no(_,_,_).
	
% Adiciona os nos adjacentes aos nos abertos
novos_nos_abertos(X,Y):-
	novo_no(X,Y,norte),
	novo_no(X,Y,sul),
	novo_no(X,Y,leste),
	novo_no(X,Y,oeste).

% Pega um nó dos nós abertos e seta como próximo destino
novo_destino() :-
	nos_abertos(X,Y),
	\+ casa_perigosa(X,Y),
	retractall(destino(_,_)),
	assert(destino(X,Y)),
	retract(nos_abertos(X,Y)).
	
% Altera o nó destino para outro nó dos nós abertos
altera_destino() :-
	nos_abertos(X,Y),
	\+ casa_perigosa(X,Y),
	destino(X_Destino,Y_Destino),
	retract(nos_abertos(X,Y)),
	retractall(destino(_,_)),
	assert(destino(X,Y)),
	asserta(nos_abertos(X_Destino,Y_Destino)).

% Dist é a distancia de Manhattan entre os pontos (X,Y) e (A,B)
distancia(X,Y,A,B,Dist) :- X >= A, Y >= B, Dist is (X-A) + (Y-B).
distancia(X,Y,A,B,Dist) :- X >= A, Y < B, Dist is (X-A) + (B-Y).
distancia(X,Y,A,B,Dist) :- X < A, Y >= B, Dist is (A-X) + (Y-B).
distancia(X,Y,A,B,Dist) :- X < A, Y < B, Dist is (A-X) + (B-Y).

% Finalizar o jogo ao chegar na origem com os tres ouros
melhor_acao(	subir	) :-
	estado(1,1,_,_,3).

% Pega o terceiro ouro
melhor_acao(	pegar	) :-
	brilho(X,Y),
	\+ ouro_pego(X,Y),
	retract( estado(X,Y,Direcao,Viradas,2)),
	retractall(destino(_,_)),
	assert(	estado(X,Y,Direcao,Viradas,3)),
	assert(ouro_pego(X,Y)),
	assert(destino(1,1)).

% Pega o primeiro ou segundo ouro
melhor_acao(	pegar	) :-
	brilho(X,Y),
	\+ ouro_pego(X,Y),
	retract( estado(X,Y,Direcao,Viradas,Ouro1)),
	Ouro2 is Ouro1 + 1, Ouro1 < 3,
	assert(	estado(X,Y,Direcao,Viradas,Ouro2)),
	assert(ouro_pego(X,Y)).

% Pega o powerup
melhor_acao(	pegar	) :-
	powerup(X,Y),
	\+ powerup_pego(X,Y),
	estado(X,Y,_,_,_),
	assert(powerup_pego(X,Y)).

% Chegar ao nó destino
melhor_acao(	mover_para_frente	):-
	estado(X1,Y1,Direcao,_,_),
	casa_da_frente(X1,Y1,X2,Y2,Direcao),
	destino(X2,Y2),
	percebe_sensores(X2,Y2),!,
	novos_nos_abertos(X2,Y2),
	novo_destino(),
	assert(visitado(X2,Y2)),
	retractall(nao_passar(_,_)),
	altera(	estado(X1,Y1,Direcao,_,Ouro),
		estado(X2,Y2,Direcao,0,Ouro)).

% Se aproximar do nó destino
melhor_acao(	mover_para_frente	):-
	estado(X1,Y1,Direcao,_,_),
	casa_da_frente(X1,Y1,X2,Y2,Direcao),
	visitado(X2,Y2),
	destino(X_Destino,Y_Destino),
%	\+ nao_passar(X2,Y2),
	distancia(X1,Y1,X_Destino,Y_Destino,D1),distancia(X2,Y2,X_Destino,Y_Destino,D2),D2 < D1,
	altera(	estado(X1,Y1,Direcao,_,Ouro),
		estado(X2,Y2,Direcao,0,Ouro)).

melhor_acao(	mover_para_frente	):-
	estado(X1,Y1,Direcao,Viradas,Ouro),
	Viradas > 3,
	casa_da_frente(X1,Y1,X2,Y2,Direcao),
	\+ visitado(X2,Y2),
	\+ casa_perigosa(X2,Y2),
	percebe_sensores(X2,Y2),!,
	novos_nos_abertos(X2,Y2),
%	assert(nao_passar(X1,Y1)),
	assert(visitado(X2,Y2)),
	altera(	estado(X1,Y1,Direcao,Viradas,Ouro),
		estado(X2,Y2,Direcao,Viradas,Ouro)).
		
melhor_acao(	mover_para_frente	):-
	estado(X1,Y1,Direcao,Viradas,Ouro),
	Viradas > 3,
	casa_da_frente(X1,Y1,X2,Y2,Direcao),
	visitado(X2,Y2),
%	\+ nao_passar(X2,Y2),
%	assert(nao_passar(X1,Y1)),
	altera(	estado(X1,Y1,Direcao,Viradas,Ouro),
		estado(X2,Y2,Direcao,Viradas,Ouro)).


%melhor_acao(	virar_a_direita		):-
%	estado(X,Y,Direcao1,Qnt_viradas,Ouro),
%	Qnt_viradas > 3,
%	direita(Direcao1,Direcao2),
%	altera_destino(),
%	retractall(nao_passar(_,_)),
%	altera(	estado(X,Y,Direcao1,Qnt_viradas,Ouro),
%		estado(X,Y,Direcao2,0,Ouro)
%).

% Virar a direita
melhor_acao(	virar_a_direita		):-
	estado(X,Y,Direcao1,Qnt_viradas1,Ouro),
	Qnt_viradas1 < 8,
	direita(Direcao1,Direcao2),
	Qnt_viradas2 is Qnt_viradas1 + 1,
	altera(	estado(X,Y,Direcao1,Qnt_viradas1,Ouro),
		estado(X,Y,Direcao2,Qnt_viradas2,Ouro)
).

% Atirar no inimigo
melhor_acao(	atirar	) :-
	estado(X,Y,Direcao,_,_),
	casa_da_frente(X,Y,A,B,Direcao),
	inimigo(A,B).
	
% Nao exite melhor acao
melhor_acao( cometer_seppuku ).







