/*	T2 INF 1771 - INTELIGENCIA ARTIFICIAL
 * LUCAS GOMES DA SILVA - 1312010
 * MIGUEL BALDEZ BOING - 1312013
 */
package test;

import java.util.Random;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JOptionPane;

public class RandomizeMap implements ActionListener
{
	public void actionPerformed(ActionEvent e)
	{	
		//Window.getWindow().FileName = JOptionPane.showInputDialog("Qual o arquivo?",Window.getWindow().FileName);
		randomize();
		Persona.getPersona().reset();
	}
	
	public void randomize()
	{
		int i,j;
		char temp;
		Random rgen = new Random();
		char[] rand;
		rand = new char[]{'U','U','U','.','.','.','.','.','.','.','.','.',
				'O','O','O','.','.','.','.','.','.','.','.','.',
				'd','d','D','D','.','.','.','.','.','.','.','.',
				'P','P','P','P','P','P','P','P','.','.','.','.',
				'T','T','T','T','.','.','.','.','.','.','.','.',
				'.','.','.','.','.','.','.','.','.','.','.','.',
				'.','.','.','.','.','.','.','.','.','.','.','.',
				'.','.','.','.','.','.','.','.','.','.','.','.',
				'.','.','.','.','.','.','.','.','.','.','.','.',
				'.','.','.','.','.','.','.','.','.','.','.','.',
				'.','.','.','.','.','.','.','.','.','.','.','.',
				'.','.','.','.','.','.','.','.','.','.','.','.',
		};
		
		for (i=0; i<rand.length; i++) {
		    int randomPosition = rgen.nextInt(rand.length);
		    temp = rand[i];
		    rand[i] = rand[randomPosition];
		    rand[randomPosition] = temp;
		}
		for(i=0;i<12;i++)
		{
			for(j=0;j<12;j++)
			{
				Panel.getPanel().mapa[i][j] = rand[i*12+j];
			}
		}
		for(i=0;i<12;i++)
		{
			System.out.println(Panel.getPanel().mapa[i]);
		}
		Panel.getPanel().revalidate();
        Panel.getPanel().repaint();
	}
}
