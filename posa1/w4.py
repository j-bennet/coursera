# cpython
import threading

tl = threading.Lock()
ts = threading.Semaphore(2)

def do_print(msg):
	for i in range(3):
		tl.acquire(True)
		print msg
		tl.release()
	ts.release()

def do_ping():
	do_print('Ping!')

def do_pong():
	do_print('Pong!')

def main():
	print "Ready... Set... Go!"
	print ''

	tl.acquire(True)

	ts.acquire(False)

	ts.acquire(False)

	t1 = threading.Thread(target=do_ping, name="Ping")
	t1.start()

	t2 = threading.Thread(target=do_pong, name="Pong")
	t2.start()

	tl.release()

	ts.acquire(True)
	ts.acquire(True)

	print "Done!"

main()