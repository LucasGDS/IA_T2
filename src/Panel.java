/*	T2 INF 1771 - INTELIGENCIA ARTIFICIAL
 * LUCAS GOMES DA SILVA - 1312010
 * MIGUEL BALDEZ BOING - 1312013
 */
package test;

import javax.imageio.ImageIO;
import javax.swing.JPanel;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

public class Panel extends JPanel {
	private static final long serialVersionUID = 1L;
	public static final int spritesize = 50;
	public static final int TXTPLAYER_X = 12 * spritesize;
	public static final int TXTPLAYER_Y = spritesize;
	
	public static final int persona = 0;
	public static final int	chao = 1;
	public static final int	ouro = 2;
	public static final int pit = 3;
	public static final int bat = 4;
    public static final int	enemy = 5;
    public static final int smallenemy = 6;
	public static final int	exit = 7;
	public static final int	up = 8;
	public static final int pn = 9;
	public static final int pl = 10;
	public static final int ps = 11;
	public static final int po = 12;
	
	public static final int QTD_IMG = 13;
	
	public char mapa[][];
	
	private BufferedImage[] imagem;
	
	//singleton
	private static Panel painel = null;	
	private Panel() {}
	public static Panel getPanel() {
		if(painel == null)
		{
			painel = new Panel();
		}
		return painel;
	}	
	
	public void pinto()
	{
		repaint();
	}
	
	//pinta tela
	@Override
	protected void paintComponent(Graphics g) 
	{
        int i,j;
		
		super.paintComponent(g);
        Graphics2D g2d = (Graphics2D) g.create();
        for(i=0;i<12;i++)
        {
        	for(j=0;j<12;j++)
        	{
        		switch(mapa[i][j])
        		{
        		case'.': 
        			g2d.drawImage(imagem[chao],j*spritesize,i*spritesize,null);
        			break;
        		case'O':
        			g2d.drawImage(imagem[ouro],j*spritesize,i*spritesize,null);
        			break;
        		case'P':
        			g2d.drawImage(imagem[pit],j*spritesize,i*spritesize,null);
        			break;
        		case'T':
        			g2d.drawImage(imagem[bat], j*spritesize,i*spritesize, null);
        			break;
        		case'U':
        			g2d.drawImage(imagem[up], j*spritesize,i*spritesize, null);
        			break;
        		case'd':
        			g2d.drawImage(imagem[smallenemy], j*spritesize,i*spritesize, null);
        			break;
        		case'D':
        			g2d.drawImage(imagem[enemy], j*spritesize,i*spritesize, null);
        			break;
        		default:
        			break;
        		}
        	}
        }
        g2d.drawImage(imagem[exit],0,11*spritesize,null);
        switch(Persona.getPersona().direcao)
        {
        case"norte":
        	g2d.drawImage(imagem[pn], Persona.getPersona().posx*spritesize, Persona.getPersona().posy*spritesize, null);
        	break;
        case"leste":
        	g2d.drawImage(imagem[pl], Persona.getPersona().posx*spritesize, Persona.getPersona().posy*spritesize, null);;
        	break;
        case"sul":
        	g2d.drawImage(imagem[ps], Persona.getPersona().posx*spritesize, Persona.getPersona().posy*spritesize, null);
        	break;
        case"oeste":
        	g2d.drawImage(imagem[po], Persona.getPersona().posx*spritesize, Persona.getPersona().posy*spritesize, null);
        	break;
        }
        
        g2d.drawString("Pontos: " + Persona.getPersona().pontos,TXTPLAYER_X,TXTPLAYER_Y);
        g2d.drawString("Energia: " + Persona.getPersona().energia,TXTPLAYER_X,TXTPLAYER_Y+20);
	}
	
	{
		mapa = new char[12][12];
		imagem = new BufferedImage[QTD_IMG];
		
		for(int i = 0; i < QTD_IMG ; i++)
		{
			try
			{
				imagem[i] = ImageIO.read(new File(Integer.toString(i) + ".png"));
			}
			catch(IOException e)
			{
				System.out.println(e.getMessage());
				System.exit(1);
			}
		}
		
	}
}
