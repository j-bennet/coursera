import threading

mlock = threading.Lock()

def message(msg):
	mlock.acquire()
	print msg
	mlock.release()

class Chopstick:
	
	def __init__(self):
		self.lock = threading.Lock()

	def pick_up(self):
		self.lock.acquire(True)

	def put_down(self):
		self.lock.release()

class Philosopher:
	
	def __init__(self, index, lchopstick, rchopstick):
		self.index = index + 1
		self.lchopstick = lchopstick
		self.rchopstick = rchopstick

	def eat(self):

		self.lchopstick.pick_up()
		message('Philosopher {0} picks up left chopstick.'.format(self.index))

		self.rchopstick.pick_up()
		message('Philosopher {0} picks up right chopstick.'.format(self.index))
		
		message('Philosopher {0} eats.'.format(self.index))

		self.lchopstick.put_down()
		message('Philosopher {0} puts down left chopstick.'.format(self.index))

		self.rchopstick.put_down()
		message('Philosopher {0} puts down right chopstick.'.format(self.index))

	def eat_dinner(self):
		for i in xrange(self.times):
			self.eat()

	def eat_times(self, times):
		self.times = times
		self.th = threading.Thread(target=self.eat_dinner, name="Philosopher {0}".format(self.index))
		self.th.start()

def main():
	chopsticks = [Chopstick() for i in xrange(5)]
	philosophers = [Philosopher(i, chopsticks[i-1], chopsticks[i]) for i in xrange(5)]

	print 'Dinner is starting!'

	for p in philosophers:
		p.eat_times(5)

	for p in philosophers:
		p.th.join()

	print 'Dinner is over!'

main()