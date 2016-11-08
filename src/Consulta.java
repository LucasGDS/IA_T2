/*	T2 INF 1771 - INTELIGENCIA ARTIFICIAL
 * LUCAS GOMES DA SILVA - 1312010
 * MIGUEL BALDEZ BOING - 1312013
 */
package test;

import org.jpl7.*;
import java.util.Map;
import java.lang.System;

public class Consulta //classe para o botao "Inicio" no menu 
{
	public static final int  QTDOUROS = 1;
	public static void start()
	{
		String query;
		boolean fim = false;
		String estado1 = "estado(1,1,norte,0,[[1,2],[2,1]],[])";
		while (fim == false)
		{
			Query q1 = new Query("consult", new Term[] {new Atom("NovoWumpus.pl")});
			System.out.println("consult " + (q1.hasSolution() ? "succeeded" : "failed"));
			
			//query = "assert poco(" + /*x poco*/  ","+/*y poco*/ ")." ;
			//System.out.println(query);
			//Query a1 = new Query(query);
			
			query = "melhor_acao(" + estado1 + ",Melhor_acao,Estado2).";
			System.out.println(query);
			Query q2 = new Query(query);
			 Map<String, Term>[] solution = q2.allSolutions();		
			 if (solution != null) 
			 {	
			     //System.out.println("X = " + solution[0].get("X"));
				 System.out.println(solution[0].get("Melhor_acao"));
				 System.out.println(solution[0].get("Estado2"));
				 
				 Term estado2 = solution[0].get("Estado2");
				 for (Term oneTerm : estado2.args())
					  System.out.println(oneTerm);
				 
				 
			 }
			 
			 
			 fim = true;
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
