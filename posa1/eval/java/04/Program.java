
import java.util.concurrent.*;

public class Program {

	static final int TOTAL_HITS= 3;
	/**
	 * @param args
	 */
	public class PingPongPlayer extends Thread 
	{
		protected String m_sentence;
		protected PingPongPlayer m_opponent;
		protected int m_nHits= 0;
		public Semaphore m_semaphore;
		
		public void setSentence(String sentence)
		{
			m_sentence= sentence;
		}
		
		public void setOpponent(PingPongPlayer player)
		{
			m_opponent= player;
		}
		
		public void setSemaphore(Semaphore semaphore)
		{
			m_semaphore= semaphore;
		}
		
		public void run() {
			// TODO Auto-generated method stub
			while (m_nHits < TOTAL_HITS) {
				try {
					m_semaphore.acquire();
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				System.out.println(m_sentence);
				m_opponent.m_semaphore.release();
				m_nHits++;
			}
		}
	}
	
	public PingPongPlayer m_player1= new PingPongPlayer();
	public PingPongPlayer m_player2= new PingPongPlayer();
	
	public void startGame()
	{
		Semaphore semaphorePlayer1= new Semaphore(1);
		Semaphore semaphorePlayer2= new Semaphore(1);
		
		System.out.println("Ready... Set... Go!\n");
		
		// configure players
		m_player1.setSentence("Ping ...");
		m_player1.setOpponent(m_player2);
		m_player1.setSemaphore(semaphorePlayer1);
		m_player2.setSentence("Pong ...");
		m_player2.setOpponent(m_player1);
		m_player2.setSemaphore(semaphorePlayer2);
		// set player semaphores to zero
		try {
			semaphorePlayer1.acquire();
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			semaphorePlayer2.acquire();
		} catch (InterruptedException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		// start threads
		m_player1.start();
		m_player2.start();
		
		// let player 1 start
		m_player1.m_semaphore.release();
		
		// wait for players to finish
		try {
			m_player1.join();
		} catch (InterruptedException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		try {
			m_player2.join();
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("Done!");
	}
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Program instance= new Program();
		instance.startGame();
	}
}