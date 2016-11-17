/*	T2 INF 1771 - INTELIGENCIA ARTIFICIAL
 * LUCAS GOMES DA SILVA - 1312010
 * MIGUEL BALDEZ BOING - 1312013
 */

package test;
import javax.swing.JFrame;
import javax.swing.SwingUtilities;

	public class Main {
		public static void main(String[] args)
		{
			SwingUtilities.invokeLater(new Runnable()
	        {	
				public void run(){
				final JFrame f= Window.getWindow();
				f.setVisible(true);
				}
	        });
		}
}
