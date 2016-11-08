/*	T2 INF 1771 - INTELIGENCIA ARTIFICIAL
 * LUCAS GOMES DA SILVA - 1312010
 * MIGUEL BALDEZ BOING - 1312013
 */
package test;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import javax.swing.JOptionPane;

public class LoadMap implements ActionListener
{
	
	public void actionPerformed(ActionEvent e)
	{	
		Window.getWindow().FileName = JOptionPane.showInputDialog("Qual o arquivo?",Window.getWindow().FileName);
		if(Window.getWindow().FileName!=null)
		{
			LoadFile(Window.getWindow().FileName);
			Persona.getPersona().reset();
		}
		
	}
	
	public void LoadFile(String FileName)
	{
		int i,j;
		String line = new String();
		try {
			// abre arquivo
			File arq = new File(FileName);
			FileReader leitor = new FileReader(arq);
			BufferedReader bufferedReader = new BufferedReader(leitor);
			
			for(i=0;i<12;i++)
			{
				// lê linha
				line = bufferedReader.readLine();
				for(j=0;j<12;j++)
				{
					Panel.getPanel().mapa[i][j] = line.charAt(j);
				}
			}
			// fecha arquivo
			leitor.close();
			for(i=0;i<12;i++)
			{
				System.out.println(Panel.getPanel().mapa[i]);
			}
			Panel.getPanel().revalidate();
	        Panel.getPanel().repaint();
		} catch (IOException e) {
			System.out.println(e.getMessage());
			System.exit(1);
		}
	}
}
