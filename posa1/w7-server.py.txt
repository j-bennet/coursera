# used: python 2.7

from sys import stdout
from twisted.internet import reactor, protocol
from twisted.internet.endpoints import TCP4ServerEndpoint
from twisted.protocols import basic
from  twisted.python import threadpool, threadable

# This is the Service handler. It's going to do the actual work.
class EchoServerHandler(basic.LineReceiver):

	threads = None

	def __init__(self):
		self.threads = threadpool.ThreadPool()
		self.threads.start()

	def returnFromThread(self, success, line):
		reactor.callFromThread(self.sendLine, line)

	def echoFromThread(self, line):
		return "{0}: {1}".format(threadable.getThreadID(), line)

	def lineReceived(self, line):
		self.threads.callInThreadWithCallback(self.returnFromThread, self.echoFromThread, line)

	def connectionMade(self):
		stdout.write("Connection is established\r\n")

	def connectionLost(self, reason):
		stdout.write("Connection is lost.\r\n")

# This is the Acceptor. It's going to return the Service Handler for doing work.
class EchoServerFactory(protocol.Factory):
	def buildProtocol(self, addr):
		return EchoServerHandler()

# Endpoint wraps the details if the connection, so it's part of the Wrapper Facade
endpoint = TCP4ServerEndpoint(reactor, 1234)
endpoint.listen(EchoServerFactory())

# Reactor is going to listen to events and forward them to the factory-created Handler.
reactor.run()