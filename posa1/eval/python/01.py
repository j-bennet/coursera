# python -V
# Python 2.7.3

import threading

print "Ready... Set... Go!"

def print_task(text, counter, mylock, nextlock):
        while counter[0] >= 0:
                mylock.acquire()
                print text
                counter[0] -= 1
                nextlock.release()

counter = [ 4 ]
lock1   = threading.Lock()
lock2   = threading.Lock()

lock1.acquire()
lock2.acquire()

t1 = threading.Thread(target=print_task, args=("Ping!", counter, lock1, lock2 ))
t2 = threading.Thread(target=print_task, args=("Pong!", counter, lock2, lock1 ))

t1.start()
t2.start()

lock1.release()

t1.join()
t2.join()

print "Done!"