/*	T2 INF 1771 - INTELIGENCIA ARTIFICIAL
 * LUCAS GOMES DA SILVA - 1312010
 * MIGUEL BALDEZ BOING - 1312013
 */
package test;
import java.util.concurrent.TimeUnit;

public class Persona //classe do personagem
{
	int pontos = 0;
	int energia=100;
	String direcao="norte";
	int posy=11;
	int posx=0;
	int tesouros=0;
	
	
	public char seen[][];
		
	//singleton
		private static Persona persona = null;	
		private Persona() {}
		public static Persona getPersona() {
			if(persona == null)
			{
				persona = new Persona();
			}
			return persona;
		}	
	
	public void andar()
	{
		switch(direcao)
		{
		case"norte":
			if(posy>0)
			{
				posy = posy-1;
				pontos = pontos-1;
			}	
			else
				System.out.println("ENCONTROU A PAREDE");
			break;
		case"sul":
			if(posy<11)
			{
				posy = posy+1;
				pontos = pontos-1;
			}	
			else
				System.out.println("ENCONTROU A PAREDE");
			break;
		case"oeste":
			if(posx>0)
			{
				posx = posx-1;
				pontos = pontos-1;
			}	
			else
				System.out.println("ENCONTROU A PAREDE");
			break;
		case"leste":
			if(posx<11)
			{
				posx = posx+1;
				pontos = pontos-1;
			}
			else
				System.out.println("ENCONTROU A PAREDE");
			break;
		
		
		default:
			
			;
		}
		System.out.println(Panel.getPanel().mapa[posy][posx]);
		Panel.getPanel().revalidate();
        Panel.getPanel().repaint(); //NAO PINTA
        try {
			TimeUnit.SECONDS.sleep(1); //ESPERA PRA MUDANCAS SEREM VISIVEIS...PRINT VISIVEL,MAS SEM DESENHO
		} catch (InterruptedException e) {
			// TODO
			e.printStackTrace();
		}
        
	}
	
	public void virarDireita()
	{
		switch(direcao)
		{
		case"norte":
			 direcao = "leste";
			 pontos = pontos-1;
			break;
		case"leste":
			direcao = "sul";
			pontos = pontos-1;
			break;	
		case"sul":
			direcao = "oeste";
			pontos = pontos-1;
			break;
		case"oeste":
			direcao = "norte";
			pontos = pontos-1;
			break;
			
		default:
			;
		}
		System.out.println("GIROU");
		Panel.getPanel().revalidate();
        Panel.getPanel().repaint(); //NAO ESTA PINTANDO
		//Panel.getPanel().paintImmediately(posx, posy, 50, 50);
	
	}
	
	public void pegar()
	{
		pontos = pontos-1;
		if(Panel.getPanel().mapa[posy][posx]=='O')
		{pontos = pontos + 100;}
		else if(Panel.getPanel().mapa[posy][posx]=='U')
		{energia = energia + 20;}
	}
	
	//TODO public void atirar()
	
	public void reset()
	{
		pontos=0;
		energia=100;
		direcao="norte";
		posy=11;
		posx=0;
		
		for (int i=0;i<12;i++)
		{
			for (int j=0;j<12;j++)
			{
				
				seen[i][j]='?';
			}
		}
		seen[11][0]=Panel.getPanel().mapa[11][0];
		Panel.getPanel().revalidate();
        Panel.getPanel().repaint();
	}
	
	
	{
		seen = new char[12][12];
		for (int i=0;i<12;i++)
		{
			for (int j=0;j<12;j++)
			{
				
				seen[i][j]='?';
			}
		}
		seen[11][0]=Panel.getPanel().mapa[11][0];
	}
}
