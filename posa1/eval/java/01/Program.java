/**
 * The Class Program. Plays Ping/Pong thrice in order.
 */
public class Program
{
    
    /** Variable mutexLock. To allow synchronization of calls.*/
    Object mutexLock;
    
    /** Variable pinged. Flagging ping(true) and pong(false) */
    boolean pinged;
    
    public Program() 
    {
        mutexLock = new Object();
    }
    
    /**
     * Execute ping/pong.
     */
    public void execute()
    {
        System.out.println("Ready... Set... Go!");
        System.out.println();

        try
        {            
            //Initialize and start Ping Thread
            Thread ping = new Thread(new PingThread("ping"));
            ping.start();
            
            //Initialize and start Ping Thread
            Thread pong = new Thread(new PongThread("pong"));
            pong.start();
            
            //Wait for both Ping and Pong threads to complete execution
            ping.join();
            pong.join();
        } 
        catch (InterruptedException e)
        {
            e.printStackTrace();
        }

        System.out.println("Done!");        
    }
    
    public static void main(String argv[])
    {
        Program prog = new Program();
        prog.execute();
    }
    
    /**
     * The Class PongThread.
     */
    class PongThread implements Runnable
    {
        private String type;
        
        public PongThread(String type)
        {
            this.setType(type);
        }
        
        /* (non-Javadoc)
         * @see java.lang.Runnable#run()
         */
        @Override
        public void run()
        {
            for(int idx = 0; idx < 3; idx++)
            {
                synchronized(mutexLock)
                {
                    if (!pinged)
                        try
                        {
                            // Release mutexLock and wait for ping before ponging.
                            mutexLock.wait();
                        } 
                        catch (InterruptedException e)
                        {
                            e.printStackTrace();
                        }
                    pong();
                    //notify other threads of pong
                    mutexLock.notifyAll();
                }
            }
        }
        
        private void pong()
        {
            System.out.println(type + "!");
            pinged = false;            
        }

        public void setType(String type)
        {
            this.type = type;
        }   
    }
    

    /**
     * The Class PingThread.
     */
    class PingThread implements Runnable
    {
        private String type;
        
        public PingThread(String type)
        {
            setType(type);
        }

        /* (non-Javadoc)
         * @see java.lang.Runnable#run()
         */
        @Override
        public void run()
        {
            for(int idx = 0; idx < 3; idx++)
            {
                synchronized(mutexLock)
                {
                    if(pinged)
                        try
                        {
                            // Release mutexLock and wait for pong to happen before pinging
                            mutexLock.wait();
                        } 
                        catch (InterruptedException e)
                        {
                            e.printStackTrace();
                        }
                    
                    ping();
                    //notify other threads of ping
                    mutexLock.notifyAll();
                }
            }
        }
        
        private void ping()
        {
            System.out.println(type + "!");
            pinged = true;
        }

        public void setType(String type)
        {
            this.type = type;
        }   
    }
}