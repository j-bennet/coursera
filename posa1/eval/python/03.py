#!/usr/bin/python
#Python 2.7 (cpython)

import threading

MAX_COUNT = 3

cond = threading.Condition()

displayed_word = "" #Shared object used to print out the word
num_threads = 0     

class Thread_Obj(threading.Thread):
	def __init__(self, title = "", count = 0):
		self.title = title
		self.count = count
		threading.Thread.__init__( self )
		

	def run(self):
		global displayed_word
		for i in range(self.count):
			cond.acquire()

			#When more than one thread,
			#do not display the same word twice in a row.
			while displayed_word == self.title:		
				cond.wait()
			
			displayed_word = self.title;
			print "%s" % (displayed_word)

			cond.notify_all()
			cond.release()

		

ping_th = Thread_Obj("Ping!", MAX_COUNT)
pong_th = Thread_Obj("Pong!", MAX_COUNT)

print "Ready...Set...Go!\n"

ping_th.start()
pong_th.start()

ping_th.join()
pong_th.join()

print "Done!"