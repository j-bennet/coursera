# used: python 2.7

from sys import stdout
from twisted.protocols import basic
from twisted.internet import reactor, protocol
from twisted.internet.endpoints import TCP4ClientEndpoint

class EchoClientHandler(basic.LineReceiver):

	def connectionMade(self):
		stdout.write("Connection is established\r\n") 

	def connectionLost(self, reason):
		stdout.write("Connection is lost.\r\n")

	def lineReceived(self, line):
		stdout.write("Client received: {}\r\n".format(line))

class EchoClientFactory(protocol.Factory):
	def buildProtocol(self, addr):
		return EchoClientHandler()

def gotProtocol(clientProtocol):
	stdout.write("Client got protocol.\r\n")
	
	# send the first chunk of data
	clientProtocol.sendLine("1st line from client!")
	
	reactor.callLater(1, clientProtocol.sendLine, "2nd line from client!")
	
	reactor.callLater(2, clientProtocol.sendLine, "3rd line from client!")

point = TCP4ClientEndpoint(reactor, "localhost", 1234)
attempt = point.connect(EchoClientFactory())
attempt.addCallback(gotProtocol)
reactor.run()