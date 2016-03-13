from sys import stdout
from twisted.internet import reactor, protocol
from twisted.internet.endpoints import TCP4ServerEndpoint

# This is the Service handler. It's going to do the actual work.
class EchoServerHandler(protocol.Protocol):
	lineBuffer = ''

	def dataReceived(self, data):
		self.lineBuffer += data
		eol = self.lineBuffer.find("\r\n")
		if eol != -1:
			line = self.lineBuffer[0:eol+2]
			self.lineBuffer = self.lineBuffer[eol+2:]
			#stdout.write("Line received: {}".format(line))
			self.transport.write(line)
		#else:
		#	stdout.write("Chunk received: {}\r\n".format(data))

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