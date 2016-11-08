%	T2 INF1771 - INTELIGENCIA ARTIFICIAL

%	LUCAS GOMES DA SILVA - 1312010
%	MIGUEL BALDEZ BOING - 1312013

% DECLARACAO DAS PROPRIEDADES DINAMICAS

:-dynamic visitado/2.
:-dynamic brilho/2.
:-dynamic powerup/2.
:-dynamic brisa/2.
:-dynamic fedor/2.
:-dynamic flash/2.
:-dynamic buraco/2.
:-dynamic inimigo/2.
:-dynamic teletransporte/2.
:-dynamic suspeita_buraco/2.
:-dynamic suspeita_inimigo/2.
:-dynamic suspeita_teletransporte/2.

% MARCA A CASA INICIAL COMO JÁ VISITADA

visitado(1,1).

% FUNÇÃO AUXILIAR PARA TESTAR SE UM ELEMENTO NÃO PERTENCE A LISTA



not_member(_, []) :- !.
not_member(X, [Head|Tail]) :- X \= Head, not_member(X, Tail).


% FUNÇÃO QUE VERIFICA SE A CASA X2,Y2 ESTA NA FRENTE DA X1,Y1, DE ACORDO COM A DIRECAO

casa_da_frente(X,Y1,X,Y2,norte):- Y2 is Y1 + 1, Y1 < 12.
casa_da_frente(X,Y1,X,Y2,sul):- Y2 is Y1 - 1, Y1 > 1.
casa_da_frente(X1,Y,X2,Y,leste):- X2 is X1 + 1, X1 < 12.
casa_da_frente(X1,Y,X2,Y,oeste):- X2 is X1 - 1, X1 > 1.

% FUNÇÃO QUE VERIFICA SE A CASA A,B É ADJACENTE À X,Y

adjacente(X,Y,A,B):- casa_da_frente(X,Y,A,B,norte).

adjacente(X,Y,A,B):- casa_da_frente(X,Y,A,B,sul).

adjacente(X,Y,A,B):- casa_da_frente(X,Y,A,B,leste).

adjacente(X,Y,A,B):- casa_da_frente(X,Y,A,B,oeste).

% FUNÇÃO AUXILIAR PARA O AGENTE VIRAR A DIREITA, MUDANDO A DIRECAO

direita(norte,leste).
direita(leste,sul).
direita(sul,oeste).
direita(oeste,norte).

% FUNÇÃO DE SENTIR ALGUM PERCEPTOR ESPECIFICO: ADICIONA UMA SUSPEITA DE BURACO, INIMIGO OU TELETRANSPORTE
% CASO JÁ EXISTA ALGUMA SUSPEITA, É COMPUTADO QUE HÁ, COM CERTEZA, UM BURACO, INIMIGO OU TELETRANSPORTE,
% JÁ QUE ESSA FUNÇÃO SÓ PODE SER CHAMADA UMA VEZ POR CASA

sentir_brisa(X,Y) :- casa_da_frente(X,Y,A,B,norte), suspeita_buraco(A,B), not(visitada(A,B)), assert(buraco(A,B)).
sentir_brisa(X,Y) :- casa_da_frente(X,Y,A,B,sul), suspeita_buraco(A,B), not(visitada(A,B)), assert(buraco(A,B)).
sentir_brisa(X,Y) :- casa_da_frente(X,Y,A,B,leste), suspeita_buraco(A,B), not(visitada(A,B)), assert(buraco(A,B)).
sentir_brisa(X,Y) :- casa_da_frente(X,Y,A,B,oeste), suspeita_buraco(A,B), not(visitada(A,B)), assert(buraco(A,B)).
sentir_brisa(X,Y) :- 	casa_da_frente(X,Y,A1,B1,norte), assert(suspeita_buraco(A1,B1)),
			casa_da_frente(X,Y,A2,B2,sul), assert(suspeita_buraco(A2,B2)),
			casa_da_frente(X,Y,A3,B3,leste), assert(suspeita_buraco(A3,B3)),
			casa_da_frente(X,Y,A4,B4,oeste), assert(suspeita_buraco(A4,B4)).

sentir_fedor(X,Y) :- casa_da_frente(X,Y,A,B,norte), suspeita_inimigo(A,B), not(visitada(A,B)), assert(inimigo(A,B)).
sentir_fedor(X,Y) :- casa_da_frente(X,Y,A,B,sul), suspeita_inimigo(A,B), not(visitada(A,B)), assert(inimigo(A,B)).
sentir_fedor(X,Y) :- casa_da_frente(X,Y,A,B,leste), suspeita_inimigo(A,B), not(visitada(A,B)), assert(inimigo(A,B)).
sentir_fedor(X,Y) :- casa_da_frente(X,Y,A,B,oeste), suspeita_inimigo(A,B), not(visitada(A,B)), assert(inimigo(A,B)).
sentir_fedor(X,Y) :- 	casa_da_frente(X,Y,A1,B1,norte), assert(suspeita_inimigo(A1,B1)),
			casa_da_frente(X,Y,A2,B2,sul), assert(suspeita_inimigo(A2,B2)),
			casa_da_frente(X,Y,A3,B3,leste), assert(suspeita_inimigo(A3,B3)),
			casa_da_frente(X,Y,A4,B4,oeste), assert(suspeita_inimigo(A4,B4)).

sentir_flash(X,Y) :- casa_da_frente(X,Y,A,B,norte), suspeita_teletransporte(A,B), not(visitada(A,B)), assert(teletransporte(A,B)).
sentir_flash(X,Y) :- casa_da_frente(X,Y,A,B,sul), suspeita_teletransporte(A,B), not(visitada(A,B)), assert(teletransporte(A,B)).
sentir_flash(X,Y) :- casa_da_frente(X,Y,A,B,leste), suspeita_teletransporte(A,B), not(visitada(A,B)), assert(teletransporte(A,B)).
sentir_flash(X,Y) :- casa_da_frente(X,Y,A,B,oeste), suspeita_teletransporte(A,B), not(visitada(A,B)), assert(teletransporte(A,B)).
sentir_flash(X,Y) :- 	casa_da_frente(X,Y,A1,B1,norte), assert(suspeita_teletransporte(A1,B1)),
			casa_da_frente(X,Y,A2,B2,sul), assert(suspeita_teletransporte(A2,B2)),
			casa_da_frente(X,Y,A3,B3,leste), assert(suspeita_teletransporte(A3,B3)),
			casa_da_frente(X,Y,A4,B4,oeste), assert(suspeita_teletransporte(A4,B4)).

% FUNCAO PERCEBE SENSORES QUE, QUANDO O AGENTE ESTÁ NUMA CASA COM BRISA,FEDOR OU FLASH É CHAMADA A FUNÇÃO ESPECIFICA DE CADA UM A CIMA

%percebe_sensores(X,Y) :- sentir_brisa(X,Y), brisa(X,Y), sentir_fedor(X,Y), fedor(X,Y), sentir_flash(X,Y), flash(X,Y).
%percebe_sensores(X,Y) :- sentir_brisa(X,Y), brisa(X,Y), sentir_fedor(X,Y), fedor(X,Y).
%percebe_sensores(X,Y) :- sentir_brisa(X,Y), brisa(X,Y), sentir_flash(X,Y), flash(X,Y).
%percebe_sensores(X,Y) :- sentir_fedor(X,Y), fedor(X,Y), sentir_flash(X,Y), flash(X,Y).
%percebe_sensores(X,Y) :- sentir_brisa(X,Y), brisa(X,Y).
%percebe_sensores(X,Y) :- sentir_fedor(X,Y), fedor(X,Y).
%percebe_sensores(X,Y) :- sentir_flash(X,Y), flash(X,Y).
percebe_sensores(X,Y) :- (sentir_brisa(X,Y), brisa(X,Y)); (sentir_fedor(X,Y), fedor(X,Y)); (sentir_flash(X,Y), flash(X,Y)).

% FUNÇÃO AUXILIAR QUE CONVERTE AS COORDENADAS DE UMA CASA X, Y EM UMA LISTA DA FORMA [X,Y]

casa_em_lista(X,Y,[X|Body]) :- Body = [Y].

% ADICIONA NOVOS NÓS ABERTOS NA CABECA DA LISTA DE NÓS ABERTOS

novos_nos_abertos(X,Y,NosAbertos,[NovoNo|NosAbertos]):-
	adjacente(X,Y,A,B),
	casa_em_lista(A,B,NovoNo),
	not(buraco(A,B)), not(inimigo(A,B)), not(teletransporte(A,B)), not(visitado(A,B)).

% FUNCAO QUE CALCULA A DISTANCIA ENTRE AS CASAS X,Y E A,B. O RESULTADO É Dist

distancia(X,Y,A,B,Dist) :- X > A, Y > B, Dist is (X-A) + (Y-B).
distancia(X,Y,A,B,Dist) :- X > A, Y < B, Dist is (X-A) + (B-Y).
distancia(X,Y,A,B,Dist) :- X < A, Y > B, Dist is (A-X) + (Y-B).
distancia(X,Y,A,B,Dist) :- X < A, Y < B, Dist is (A-X) + (B-Y).


% TODAS AS CONSULTAS NO PROLOG DEVEM SER FEITAS DA SEGUINTE FORMA:
% melhor_acao(Estado1,Acao,Estado2).
% ONDE O Estado1 É O ESTADO ANTERIOR A MELHOR ACAO DO MOMENTO, E Estado2 É O ESTADO DEPOIS DA AÇÃO.
% AS AÇÕES SÃO, EM ORDEM DE PRIORIDADE: subir, pegar_outo, pegar_powerup, atirar, mover_para_frente e virar_a_direita
% O ESTADO TEM O SEGUINTE PADRÃO:
% estado(X,Y, Direcao, Quantidade de viradas já feitas na casa, Lista de nós abertos, Lista de ouros coletados)

% SUBIR

melhor_acao(
	estado(1,1,_,_,NosAbertos,Lista_de_Ouros),
	subir,
	estado(1,1,_,_,NosAbertos,Lista_de_Ouros)
) :- length(Lista_de_Ouros,3).


% PEGAR OURO
% TERCEIRO OURO
melhor_acao(
	estado(X,Y,Direcao,Qnt_viradas,NosAbertos,Lista_de_Ouros),
	pegar_ouro,
	estado(X,Y,Direcao,Qnt_viradas,[Origem|NosAbertos],[Ouro|Lista_de_Ouros])
) :- 	brilho(X,Y), casa_em_lista(X,Y,Ouro), not_member(Ouro,Lista_de_Ouros),length(Lista_de_Ouros,3), casa_em_lista(1,1,Origem).
% OUTRO OURO
melhor_acao(
	estado(X,Y,Direcao,Qnt_viradas,NosAbertos,Lista_de_Ouros),
	pegar_ouro,
	estado(X,Y,Direcao,Qnt_viradas,NosAbertos,[Ouro|Lista_de_Ouros])
) :- 	brilho(X,Y), casa_em_lista(X,Y,Ouro), not_member(Ouro,Lista_de_Ouros).


% PEGAR POWERUP
melhor_acao(
	estado(X,Y,Direcao,Qnt_viradas,NosAbertos,Lista_de_Ouros),
	pegar_powerup,
	estado(X,Y,Direcao,Qnt_viradas,NosAbertos,Lista_de_Ouros)
) :- powerup(X,Y).


% ATIRAR
melhor_acao(
	estado(X,Y,Direcao,Qnt_viradas,NosAbertos,Lista_de_Ouros),
	atirar,
	estado(X,Y,Direcao,Qnt_viradas,NosAbertos,Lista_de_Ouros)
) :- inimigo(A,B),casa_da_frente(X,Y,A,B,Direcao).


% ANDAR PARA FRENTE
% SEM CHEGAR NO DESTINO, QUE É A CABECA DOS NÓS ABERTOS
melhor_acao(
	estado(X1,Y1,Direcao,_,[Destino|NosAbertos],Ouro),
	mover_para_frente,
	estado(X2,Y2,Direcao,0,[Destino|NosAbertos],Ouro)
) :-	casa_da_frente(X1,Y1,X2,Y2,Direcao),
	visitado(X2,Y2),
	casa_em_lista(Xdestino,Ydestino,Destino),
	distancia(X1,Y1,Xdestino,Ydestino,D1),distancia(X2,Y2,Xdestino,Ydestino,D2),D2 < D1,!.
melhor_acao(
	estado(X1,Y1,Direcao,_,[Cabeca|NosAbertos],Ouro),
	mover_para_frente,
	estado(X2,Y2,Direcao,0,NosAbertos,Ouro)
) :-	casa_da_frente(X1,Y1,X2,Y2,Direcao),
	casa_em_lista(X2,Y2,Cabeca),
	visitado(X2,Y2),!.
% CASA COM BRISA, FEDOR OU FLASH
melhor_acao(
	estado(X1,Y1,Direcao,_,[Cabeca|NosAbertos],Ouro),
	mover_para_frente,
	estado(X2,Y2,Direcao,0,NosAbertos,Ouro)
) :-	casa_da_frente(X1,Y1,X2,Y2,Direcao),
	casa_em_lista(X2,Y2,Cabeca),
	percebe_sensores(X2,Y2),
	assert(visitado(X2,Y2)),!.
% CASA SEM BRISA, FEDOR OU FLASH
melhor_acao(
	estado(X1,Y1,Direcao,_,[Cabeca|NosAbertos],Ouro),
	mover_para_frente,
	estado(X2,Y2,Direcao,0,NovosNosAbertos,Ouro)
) :-	casa_da_frente(X1,Y1,X2,Y2,Direcao),
	casa_em_lista(X2,Y2,Cabeca),
	novos_nos_abertos(X2,Y2,NosAbertos,NovosNosAbertos),
	assert(visitado(X2,Y2)),!.


% VIRAR A DIREITA
melhor_acao(

	estado(X,Y,Direcao1,Qnt_viradas1,NosAbertos,Ouro),

	virar_a_direita,

	estado(X,Y,Direcao2,Qnt_viradas2,NosAbertos,Ouro)

) :-	direita(Direcao1,Direcao2),
	Qnt_viradas2 is Qnt_viradas1 + 1, Qnt_viradas1 < 3.







