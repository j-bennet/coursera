import threading

ping_semaphore=threading.Semaphore(1) # ping blocks first
pong_semaphore=threading.Semaphore(0) # Let pong go first

PING_PONG_NUMBER=3

def ping(times=1):
       for i in range(3):
                ping_semaphore.acquire() # block unil signaled
                print "Ping!"
                pong_semaphore.release() # signal pong



def pong(times=1):
        for i in range(times):
                pong_semaphore.acquire() # block until signaled
                print "Pong!"
                ping_semaphore.release() # signal ping

print "Ready... Set... Go!"
print

thread1=threading.Thread( target=ping, kwargs={ "times" : PING_PONG_NUMBER})
thread2=threading.Thread( target=pong, kwargs={ "times" : PING_PONG_NUMBER})
thread1.start()
thread2.start()
thread1.join()
thread2.join()

print "Done!"