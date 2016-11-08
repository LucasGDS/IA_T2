/*	T2 INF 1771 - INTELIGENCIA ARTIFICIAL
 * LUCAS GOMES DA SILVA - 1312010
 * MIGUEL BALDEZ BOING - 1312013
 */
package test;
import java.awt.Dimension;
import java.awt.Toolkit;
import javax.swing.JFrame;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;

public class Window extends JFrame 
{
	private static final long serialVersionUID = 1L;
	public String FileName="mapa.txt"; 
	
	// Dimensões da janela
	public static int JAN_X=800;
	public static int JAN_Y=800;	
	
	// Singleton
	public static Window janela = null;
	public static Window getWindow() {
		if(janela == null)
			janela = new Window();
		return janela;
	}
	
	//construtor
	public Window()
	{
		super("Wumpus");
		Toolkit tk=Toolkit.getDefaultToolkit();
		Dimension screenSize=tk.getScreenSize();
		int sl=screenSize.width;
		int sa=screenSize.height;
		int x=sl/2-JAN_X/2;
		int y=sa/2-JAN_Y/2;
		setBounds(x,y,JAN_X,JAN_Y);
		setDefaultCloseOperation(EXIT_ON_CLOSE);
		
		//Criar menu
		JMenuBar menuBar = new JMenuBar();
		
		// Botar menu na janela
	    super.setJMenuBar(menuBar);
	    LoadMap loadaction= new LoadMap();
	    RandomizeMap randomaction= new RandomizeMap();
	    Start start = new Start();
		JMenuItem carrMenuItem = new JMenuItem("Carregar");
		JMenuItem randMenuItem = new JMenuItem("Randomizar");
		JMenuItem startMenuItem = new JMenuItem("Iniciar");
		carrMenuItem.addActionListener(loadaction);
		randMenuItem.addActionListener(randomaction);
		startMenuItem.addActionListener(start);
		menuBar.add(carrMenuItem);
		menuBar.add(randMenuItem);
		menuBar.add(startMenuItem);
		randomaction.randomize();
		 // Botar o painel na janela
		getContentPane().add(Panel.getPanel());
		
	}
}
