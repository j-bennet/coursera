/**
 * This class implements the execution of every thread. Two instances of this
 * class are created (one for Ping!, another for Pong!). Both instances are
 * synchronized using the lockPingPong monitor object as a mutex.
 * 
 * It also has the main method, the entry point of the program.
 */
public class PingPong extends Thread
{
    /**
     * Line that this thread will be responsible of printing (Ping! or Pong!).
     */
    private String line;

    /**
     * Monitor object used to synchronize threads, preventing them from printing
     * lines non-stop.
     */
    private static Object lockPingPong = new Object();

    /**
     * Monitor object used to synchronize with the main thread, allowing the
     * application to be notified every time a thread terminates.
     */
    private static Object lockOverall = new Object();

    /**
     * Number of lines that every thread will print.
     */
    int linesRemaining = 3;

    /**
     * Constructor, only responsible of assigning the thread .
     * 
     * @param word
     *            Line that this thread will print.
     */
    public PingPong(String word)
    {
        line = word;
    }

    /**
     * . Returns the number of lines remaining to print for this thread.
     * 
     * @return Number of lines remaining to print for this thread.
     */
    public int getLinesRemaining()
    {
        return linesRemaining;
    }

    /**
     * Thread entry point. This method is called by the JVM when the thread is
     * started.
     */
    public void run()
    {
        while (linesRemaining > 0)
        {
            // Adquiere ownership of the mutex.
            synchronized (lockPingPong)
            {
                try
                {
                    // Print the line and decrement the counter.
                    System.out.println(line);
                    --linesRemaining;

                    // Notify the other thread that it's ready to go.
                    lockPingPong.notify();

                    // Wait for notification of the other thread.
                    lockPingPong.wait();
                }
                catch (InterruptedException e)
                {
                    e.printStackTrace();
                }

            }
        }

        // Once done, notify the main thread that we are done.
        synchronized (lockOverall)
        {
            lockOverall.notify();
        }
    }

    /**
     * Main program entry point.
     * 
     * @param args
     *            Command-line arguments (unused)
     */
    public static void main(String[] args)
    {
        // Create thread objects.
        PingPong ping = new PingPong("Ping!");
        PingPong pong = new PingPong("Pong!");

        // Print the previous lines.
        System.out.println("Ready... Set... Go!");
        System.out.println("");

        synchronized (lockOverall)
        {
            // Start threads.
            ping.start();
            pong.start();

            // Loop until there are no lines left to print.
            while (ping.getLinesRemaining() > 0 || pong.getLinesRemaining() > 0)
            {
                try
                {
                    // Wait for notification of the worker threads.
                    lockOverall.wait();
                }
                catch (InterruptedException e)
                {
                    e.printStackTrace();
                }
            }
        }

        // Print the last line.
        System.out.println("Done!");
    }
}