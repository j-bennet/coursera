/**
 * Used to select the type of thread, in complex cases, Factory Pattern could be
 * used
 * 
 */
enum Action {
	PING("Ping!"), PONG("Pong!");

	private final String value;

	Action(String str) {
		value = str;
	}

	@Override
	public String toString() {
		return value;
	}
}

/**
 * Implements class Runnable instead extends from Thread
 * 
 * @link 
 *       http://stackoverflow.com/questions/541487/implements-runnable-vs-extends
 *       -thread
 * 
 */
class PingPong implements Runnable {

	static private int MAX_ITERATIONS = 3;

	private Action action;

	public PingPong(Action act) {
		this.action = act;
	}

	/**
	 * The object of synchronization is the PingPong Class.
	 */
	@Override
	public void run() {
		synchronized (getClass()) {
			for (int i = 0; i < MAX_ITERATIONS; i++) {
				System.out.println(action.toString());
				getClass().notify();
				try {
					getClass().wait();
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}
			getClass().notify();
		}
	}

}

public class W4ProgrammingAssignment1 {

	/**
	 * Creates two threads, Ping and Pong, to alternately display "Ping" and
	 * "Pong" respectively on the console. The program should create output that
	 * looks like this: Ready… Set… Go!
	 * 
	 * Ping! Pong! Ping! Pong! Ping! Pong! Done!
	 * 
	 * Considerations: In case a three or more threads have to be created, the
	 * Pattern State could be used to set an order.
	 * 
	 * @param args
	 *            Not used
	 */
	public static void main(String[] args) {
		System.out.println("Ready… Set… Go!");
		System.out.println("");
		PingPong ping = new PingPong(Action.PING);
		PingPong pong = new PingPong(Action.PONG);
		Thread pingThread = new Thread(ping);
		Thread pongThread = new Thread(pong);
		// No need to use priority, it could start with "Ping!" or "Pong!"
		// pingThread.setPriority(Thread.MAX_PRIORITY);
		// pongThread.setPriority(Thread.MIN_PRIORITY);
		pingThread.start();
		pongThread.start();
		try {
			pingThread.join();
			pongThread.join();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		System.out.println("Done!");
	}

}