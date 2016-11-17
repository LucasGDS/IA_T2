/*	T2 INF 1771 - INTELIGENCIA ARTIFICIAL
 * LUCAS GOMES DA SILVA - 1312010
 * MIGUEL BALDEZ BOING - 1312013
 */
package test;

import org.jpl7.*;
import java.util.Map;
import java.util.Random;
import java.lang.System;

public class Consulta //classe para o botao "Inicio" no menu 
{
	public static final int  QTDOUROS = 1;
	public static void start()
	{
		StringBuilder sb = new StringBuilder();
		Term X;
		boolean fim = false;
		int i, j;
		
		//Query q1 = new Query("consult", new Term[] {new Atom("Wumpus_para_teste.pl")});
		Query q1 = new Query("consult", new Term[] {new Atom("NovoWumpus3.pl")});
		System.out.println("consult " + (q1.hasSolution() ? "succeeded" : "failed"));	
		Query q2 = new Query("inicializa().");
		q2.hasSolution();
		//System.out.println("consult " + (q2.hasSolution() ? "succeeded" : "failed"));
		Query qa, qb, qc, qd;
		for(i=0;i<12;i++)
		{
			for(j=0;j<12;j++)
			{
				int x = j + 1;
				int y = 12 - i;
				if(Panel.getPanel().mapa[i][j] == 'O'){
					qa = new Query("assert((brilho(" + x + "," + y + "))).");
					qa.hasSolution();
				}
				if(Panel.getPanel().mapa[i][j] == 'U'){
					qa = new Query("assert((powerup(" + x + "," + y + "))).");
					qa.hasSolution();
				}
				if(Panel.getPanel().mapa[i][j] == 'P'){
					qa = new Query("assert((brisa(" + (x+1) + "," + y + "))).");
					qa.hasSolution();
					qb = new Query("assert((brisa(" + (x-1) + "," + y + "))).");
					qb.hasSolution();
					qc = new Query("assert((brisa(" + x + "," + (y+1) + "))).");
					qc.hasSolution();
					qd = new Query("assert((brisa(" + x + "," + (y-1) + "))).");
					qd.hasSolution();
				}
				if(Panel.getPanel().mapa[i][j] == 'T'){
					qa = new Query("assert((flash(" + (x+1) + "," + y + "))).");
					qa.hasSolution();
					qb = new Query("assert((flash(" + (x-1) + "," + y + "))).");
					qb.hasSolution();
					qc = new Query("assert((flash(" + x + "," + (y+1) + "))).");
					qc.hasSolution();
					qd = new Query("assert((flash(" + x + "," + (y-1) + "))).");
					qd.hasSolution();
				}
				if(Panel.getPanel().mapa[i][j] == 'd' || Panel.getPanel().mapa[i][j] == 'D'){
					qa = new Query("assert((fedor(" + (x+1) + "," + y + "))).");
					qa.hasSolution();
					qb = new Query("assert((fedor(" + (x-1) + "," + y + "))).");
					qb.hasSolution();
					qc = new Query("assert((fedor(" + x + "," + (y+1) + "))).");
					qc.hasSolution();
					qd = new Query("assert((fedor(" + x + "," + (y-1) + "))).");
					qd.hasSolution();
				}
			}
		}
		
		while (fim == false)
		{
			Query q3 = new Query("melhor_acao(X),!.");
			 Map<String, Term>[] solution = q3.allSolutions();		
			 if (solution != null) 
			 {	
				 X = solution[0].get("X");
				 sb.setLength(0);
				 sb.append(X);
				 String acao = sb.toString();
				 System.out.println(acao);
				 if(acao.equals("subir") || acao.equals("cometer_seppuku")){
					 fim = true;
				 }
				 else if(acao.equals("mover_para_frente")){
					 Persona.getPersona().andar();
					//System.out.println(Panel.getPanel().mapa[Persona.getPersona().posy][Persona.getPersona().posx]);
					 char casa = Panel.getPanel().mapa[Persona.getPersona().posy][Persona.getPersona().posx];
					 if(casa == 'P'){
						 Persona.getPersona().energia = 0;
						 Persona.getPersona().pontos -= 1000;
					 }
					 else if(casa == 'd'){
						 Persona.getPersona().energia -= 20;
						 Persona.getPersona().pontos -= 20;
					 }
					 else if(casa == 'D'){
						 Persona.getPersona().energia -= 50;
						 Persona.getPersona().pontos -= 50;
					 }
					 else if(casa == 'T'){
						 Random rgen = new Random();
						 Persona.getPersona().posx = rgen.nextInt(12);
						 Persona.getPersona().posy = rgen.nextInt(12);
						 qa = new Query("teleporta(" + Persona.getPersona().posx + "," + Persona.getPersona().posy + ").");
						 qa.hasSolution();
					 }
					 if(Persona.getPersona().energia == 0){
						 fim = true;
						 Panel.getPanel().update();
					 }
				 }
				 else if(acao.equals("virar_a_direita")){
					 Persona.getPersona().virarDireita();
				 }
				 else if(acao.equals("pegar")){
					 Persona.getPersona().pegar();
				 }
			 }
		}
		
	}
	
	public static void testeAndar()
	{
		char next = '.';
		boolean fim = false;
		
		while(/*Persona.getPersona().tesouros<QTDOUROS||*/Panel.getPanel().mapa[Persona.getPersona().posy][Persona.getPersona().posx]!='O')
		{
			switch(Persona.getPersona().direcao)
			{
			case"norte":
				if(Persona.getPersona().posy>0)
				next = Panel.getPanel().mapa[Persona.getPersona().posy-1][Persona.getPersona().posx];
				else
				fim = true;
				break;
			case"sul":
				if(Persona.getPersona().posy<11)
					next = Panel.getPanel().mapa[Persona.getPersona().posy+1][Persona.getPersona().posx];
				else
					fim = true;
				break;
			case"oeste":
				if(Persona.getPersona().posx>0)
					next = Panel.getPanel().mapa[Persona.getPersona().posy][Persona.getPersona().posx-1];
				else
					fim = true;
				break;
			case"leste":
				if(Persona.getPersona().posx<11)
					next = Panel.getPanel().mapa[Persona.getPersona().posy][Persona.getPersona().posx+1];
				else
					fim = true;
				break;
			default:
				;
			}
			
			if (next == 'D'||next == 'd'||next == 'P'||next=='T'||fim == true)
			{
				Persona.getPersona().virarDireita();
				
			}
			else
				Persona.getPersona().andar();
		}
		
	}
	
	public void sair()
	{
		//voltar pro 1,1 e subir
	}
}
