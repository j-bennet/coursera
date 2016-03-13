from sys import stdout
from twisted.internet import reactor, protocol
from twisted.internet.endpoints import TCP4ClientEndpoint

class EchoClientHandler(protocol.Protocol):
	def sendData(self, data):
		self.transport.write(data)

	def connectionMade(self):
		stdout.write("Connection is established\r\n") 

	def connectionLost(self, reason):
		stdout.write("Connection is lost.\r\n") 

class EchoClientFactory(protocol.Factory):
	def buildProtocol(self, addr):
		return EchoClientHandler()

def gotProtocol(clientProtocol):
	stdout.write("Client got protocol.\r\n")
	
	# send the first chunk of data
	clientProtocol.sendData("Hello ")
	
	# send the 2nd chunk of data 1 second later
	reactor.callLater(1, clientProtocol.sendData, "from ")
	
	# send the last chunk of data 2 seconds later
	reactor.callLater(2, clientProtocol.sendData, "client!\r\n")

point = TCP4ClientEndpoint(reactor, "localhost", 1234)
attempt = point.connect(EchoClientFactory())
attempt.addCallback(gotProtocol)
reactor.run()