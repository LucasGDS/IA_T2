/*	T2 INF 1771 - INTELIGENCIA ARTIFICIAL
 * LUCAS GOMES DA SILVA - 1312010
 * MIGUEL BALDEZ BOING - 1312013
 */
package test;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class Start implements ActionListener //listener pro menu
{
	public void actionPerformed(ActionEvent e)
	{	
		 Thread queryThread = new Thread() {
		      public void run() {
		        comecaConsulta();
		      }
		    };
		    queryThread.start();
		//Persona.getPersona().reset();
		//comecaConsulta();
	}
	
	public void comecaConsulta()
	{
		//Consulta.testeAndar();
		Consulta.start();
		
	}
}
