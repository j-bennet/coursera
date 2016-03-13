#!/usr/bin/python
import threading
import time    

class Player(threading.Thread):
    '''play ping pong!'''
    def __init__(self, string):
        '''init, call the super.__init__'''
        super(Player, self).__init__()
        self.string = string

    def run(self):
        '''run to print string'''
        global g_mutex
        for i in range(3):
            g_mutex.acquire()
            print self.string
            g_mutex.release()
            time.sleep(0)

def create_thread():
    '''thread run'''
    thread_pool = []
    strings = ['Ping!', 'Pong!']
    for string in strings:
        th = Player(string)
        thread_pool.append(th)
        
    for thread in thread_pool:
        thread.start()

    for thread in thread_pool:        
        threading.Thread.join(thread)
        
if __name__ == '__main__':
    '''main'''
    g_mutex = threading.Lock()
    print "Ready... Set... Go!"
    create_thread()
    print "Done!"