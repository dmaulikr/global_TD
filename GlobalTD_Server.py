from twisted.internet.protocol import Factory, Protocol
from twisted.internet import reactor
from struct import *

class MessageReader:
 
	def __init__(self, data):
		self.data = data
		self.offset = 0

	def readByte(self):
		retval = unpack('!B', self.data[self.offset:self.offset+1])[0]
		self.offset = self.offset + 1
		return retval
 
	def readInt(self):
		retval = unpack('!I', self.data[self.offset:self.offset+4])[0]
		self.offset = self.offset + 4
		return retval

	def readString(self):
		strLength = self.readInt()
		unpackStr = '!%ds' % (strLength)
		retval = unpack(unpackStr, self.data[self.offset:self.offset+strLength])[0]
		self.offset = self.offset + strLength
		return retval

class MessageWriter:
 
	def __init__(self):
		self.data = ""
 
	def writeByte(self, value):        
		self.data = self.data + pack('!B', value)
 
	def writeInt(self, value):
		self.data = self.data + pack('!I', value)
 
	def writeString(self, value):
		self.writeInt(len(value))
		packStr = '!%ds' % (len(value))
		self.data = self.data + pack(packStr, value)
		
		
class globalTD_player:

	def __init__(self, protocolID, playerNo):
		self.protocolID = protocolID
		self.playerNo = playerNo
		self.gameSession = None
		self.playerName = ""
		self.hblong = "0"
		self.hblat = "0"
		self.towerLongList = []
		self.towerLatList = []
		self.towerTypeList = []
		self.towerIdList = []
		self.creepTypeList = []
		self.creepToList = []
		self.creepIdList = []

class globalTD_gameSession:
	
	def __init__(self,sessionNo,creator):
		self.sessionNo = sessionNo
		self.creator = creator
		self.gameName = ""
		self.playerslist = []
		self.playerNumber = 0
		self.tLlong = "0"
		self.tLlat = "0"
		self.bRlong = "0"
		self.bRlat = "0"
		self.cClong = "0"
		self.cClat = "0"	
		self.gameState = "1"
		self.hbLongList = []
		self.hbLatList = []
		self.hbPlayerList = []
		self.towerLongList = []
		self.towerLatList = []
		self.towerTypeList = []
		self.towerPlayerList = []
		self.towerIdList = []
		self.creepTypeList = []
		self.creepFromList = []
		self.creepToList = []
		self.creepIdList = []
		
	def assignHB(self):
		for i,hbPlayerNo in enumerate(self.hbPlayerList): 
			for player in self.playerslist:
				if player.playerNo == hbPlayerNo:
					player.hblong = self.hbLongList[i]
					player.hblat = self.hbLatList[i]
		return
		
	def assignTower(self):
		pass
		
		
class 	globalTD_ServerLogic:

	def __init__(self,factory):
		self.players = []
		self.playerNumber = 0
		self.gameSessions = []
		self.sessionNumber = 0
		self.factory = factory
		
	def getPlayerID(self,protocol):
		pass
		
	def processData(self,sender,data):
		a = data.split('>')
		print a
		if len(a) > 1:
			command = a[0]
			content = a[1]
			msg = ""
			if command == "createGame":
				okToCreate = 1
				for tempSession in self.gameSessions:
					if tempSession.gameName == content:
						okToCreate = 0
				
				if okToCreate == 1:
					if(self.playerNumber < 400):
						self.playerNumber += 1
					else:
						self.playerNumber = 1
					newPlayer =	globalTD_player(sender,self.playerNumber)	
					if(self.sessionNumber < 100):
						self.sessionNumber += 1
					else:
						self.sessionNumber = 1
					gameSession = globalTD_gameSession(self.sessionNumber,newPlayer)
					gameSession.gameName = content
					gameSession.playerslist.append(newPlayer)
					gameSession.playerNumber += 1
					newPlayer.gameSession = gameSession
					
					self.players.append(newPlayer)
					self.gameSessions.append(gameSession)
					sender.player = newPlayer
					msg = "createGame>sessionID:%d" % sender.player.gameSession.sessionNo + " "
					msg += "playerID:%d" % sender.player.playerNo
				else: 
					msg = "createGame>INVALID"
				
				sender.message(msg)
				
			elif command == "joinGame":
				if(self.playerNumber < 400):
					self.playerNumber += 1
				else:
					self.playerNumber = 1
				newPlayer =	globalTD_player(sender,self.playerNumber)	
				for gameSession in  self.gameSessions:
					if gameSession.gameName == content:
						newPlayer.gameSession = gameSession
						gameSession.playerslist.append(newPlayer)
						gameSession.playerNumber += 1
						newPlayer.gameSession = gameSession
						self.players.append(newPlayer)
						sender.player = newPlayer
						msg = "joinGame>sessionID:%d" % sender.player.gameSession.sessionNo + " "
						msg += "playerID:%d" % sender.player.playerNo
						sender.message(msg)
			elif command == "iam":
				sender.player.playerName = content
			elif command == "set":
				varArr = content.split(' ')
				for var in varArr:
					varInfo = var.split(':')
					varName = varInfo[0]
					varValue = varInfo[1]
					if varName == "hbLong":
						sender.player.gameSession.hbLongList = varValue.split(',')
						if len(sender.player.gameSession.hbLongList) == len(sender.player.gameSession.hbLatList) and len(sender.player.gameSession.hbLatList) == len(sender.player.gameSession.hbPlayerList):
							sender.player.gameSession.assignHB()
						msg = ""
						for i,hbLong in enumerate(sender.player.gameSession.hbLongList):
							msg += "hb%d"%i  +" longtitude is:" + hbLong
						print msg
					elif varName == "hbLat":
						sender.player.gameSession.hbLatList = varValue.split(',')
						if len(sender.player.gameSession.hbLongList) == len(sender.player.gameSession.hbLatList) and len(sender.player.gameSession.hbLatList) == len(sender.player.gameSession.hbPlayerList):
							sender.player.gameSession.assignHB()
						msg = ""
						for i,hbLat in enumerate(sender.player.gameSession.hbLatList):
							msg += "hb%d"%i  +" latititude is:" + hbLat
						print msg				
					elif varName == "hbPlayer":
						sender.player.gameSession.hbPlayerList = varValue.split(',')
						if len(sender.player.gameSession.hbLongList) == len(sender.player.gameSession.hbLatList) and len(sender.player.gameSession.hbLatList) == len(sender.player.gameSession.hbPlayerList):
							sender.player.gameSession.assignHB()
						msg = ""
						for i,hbPlayer in enumerate(sender.player.gameSession.hbPlayerList):
							msg += "hb%d"%i  +" belongs to player: " + hbPlayer
						print msg						
					elif varName == "hb_lon":
						sender.player.gameSession.hbLongList.append(varValue)
						sender.player.hblong = varValue
						msg = "set hblong:" + sender.player.hblong  + " for player %d"%sender.player.playerNo
						print msg
					elif varName == "hb_lat":
						sender.player.gameSession.hbLatList.append(varValue)
						sender.player.hblat = varValue
						msg = "set hblat:" + sender.player.hblat + " for player %d"%sender.player.playerNo
						print msg
					elif varName == "hb_player":
						sender.player.gameSession.hbPlayerList.append(varValue)
						msg = "append player ID:%d " % sender.player.playerNo + "to the array"
						print msg							
					elif varName == "tL":
						varTemp = varValue.split(',')
						sender.player.gameSession.tLlong = varTemp[0]
						sender.player.gameSession.tLlat = varTemp[1]
						msg = "tL longtitude is:" + varTemp[0] + "     tL latitude is:" + varTemp[1]
						print msg		
					elif varName == "bR":
						varTemp = varValue.split(',')
						sender.player.gameSession.bRlong = varTemp[0]
						sender.player.gameSession.bRlat = varTemp[1]
						msg = "bR longtitude is:" + varTemp[0] + "     bR latitude is:" + varTemp[1]
						print msg					
					elif varName == "cC":
						varTemp = varValue.split(',')
						sender.player.gameSession.cClong = varTemp[0]
						sender.player.gameSession.cClat = varTemp[1]
						msg = "cC longtitude is:" + varTemp[0] + "     cC latitude is:" + varTemp[1]
						print msg	
					elif varName == "GS":
						sender.player.gameSession.gameState = varValue
						msg = "change gameState to " + gameState
						print msg
					elif varName == "allTowerLong":
						sender.player.gameSession.towerLongList = varValue.split(',')
						msg = ""
						for i,towterLong in enumerate(sender.player.gameSession.towerLongList):
							msg += "tower%d"%i  +" longtitude is:" + towterLong
						print msg	
					elif varName == "allTowerLat":
						sender.player.gameSession.towerLatList = varValue.split(',')
						msg = ""
						for i,towterLat in enumerate(sender.player.gameSession.towerLatList):
							msg += "tower%d"%i  +" latititude is:" + towterLat
						print msg	
					elif varName == "allTowerType":
						sender.player.gameSession.towerTypeList = varValue.split(',')
						msg = ""
						for i,towerType in enumerate(sender.player.gameSession.towerTypeList):
							msg += "tower%d"%i  +" type is:" + towerType
						print msg	
					elif varName == "allTowerPlayer":
						sender.player.gameSession.towerPlayerList = varValue.split(',')
						msg = ""
						for i,player in enumerate(sender.player.gameSession.towerPlayerList):
							msg += "tower%d"%i  +" belongs to player %d" % player
						print msg	
					elif varName == "allTowerId":
						sender.player.gameSession.towerIdList = varValue.split(',')
						msg = ""
						for i,towerId in enumerate(sender.player.gameSession.towerIdList):
							msg += "tower%d"%i  +" id is %d" % towerId
						print msg
						
					elif varName == "t_lat":
						sender.player.gameSession.towerLatList.append(varValue.split(','))
						sender.player.towerLatList.append(varValue.split(','))
						msg = ""
						#msg += "append " + varValue.split(',') + "to the t_lat list\n Current list is:"
						for i,towterLat in enumerate(sender.player.gameSession.towerLatList):
							msg += "tower%d"%i  +" lattitude is " + towterLat
						print msg		
					elif varName == "t_lon":
						sender.player.gameSession.towerLongList.append(varValue.split(','))
						sender.player.towerLongList.append(varValue.split(','))
						msg = ""
						#msg += "append " + varValue.split(',') + "to the t_lon list\n Current list is:"
						for i,towerLong in enumerate(sender.player.gameSession.towerLongList):
							msg += "tower%d"%i  +" longtitude is " + towerLong
						print msg
					elif varName == "t_type":
						sender.player.gameSession.towerTypeList.append(varValue.split(','))
						sender.player.towerTypeList.append(varValue.split(','))
						msg = ""
						#msg += "append " + varValue.split(',') + "to the t_type list\n Current list is:"
						for i,towterType in enumerate(sender.player.gameSession.towerTypeList):
							msg += "tower%d"%i  +" type is " + towterType
						print msg
					elif varName == "t_player":
						sender.player.gameSession.towerPlayerList.append(varValue.split(','))
						msg = ""
						#msg += "append " + varValue.split(',') + "to the t_player list\n Current list is:"
						for i,towerPlayer in enumerate(sender.player.gameSession.towerPlayerList):
							msg += "tower%d"%i  +" belongs to player " + towerPlayer
						print msg						
					elif varName == "c_type":
						sender.player.gameSession.creepTypeList.append(varValue.split(','))
						sender.player.creepTypeList.append(varValue.split(','))
						msg = ""
						#msg += "append " + varValue.split(',') + "to the c_type list\n Current list is:"
						for i,creepType in enumerate(sender.player.gameSession.creepTypeList):
							msg += "creep%d"%i  +" type is " + creepType
						print msg				
					elif varName == "c_from":
						sender.player.gameSession.creepFromList.append(varValue.split(','))
						msg = ""
						#msg += "append " + varValue.split(',') + "to the c_from list\n Current list is:"
						for i,creepFrom in enumerate(sender.player.gameSession.creepFromList):
							msg += "creep%d"%i  +" is belongs to player" + creepFrom
						print msg
					elif varName == "c_to":
						sender.player.gameSession.creepToList.append(varValue.split(','))
						sender.player.creepToList.append(varValue.split(','))
						msg = ""
						#msg += "append " + varValue.split(',') + "to the t_to list\n Current list is:"
						for i,creepTo in enumerate(sender.player.gameSession.creepToList):
							msg += "creep%d"%i  +" for player %d"%sender.player.playerNo+ " is going to attack player " + creepTo
						print msg				
			#	if (gameState == "2") and (len(tower1LatList) != 0) and (len(tower1LongList) != 0):
			#		tower1Updated = 1
			#		print "tower1Updated"
			#	elif (len(tower1LatList) == 0) or (len(tower1LongList) == 0):
			#		tower1Updated = 0
			#		print "tower1reseted"
			#	if (gameState == "2") and (len(tower2LatList) != 0) and (len(tower2LongList) != 0):
			#		tower2Updated = 1
			#		print "tower2Updated"
			#	elif (len(tower2LatList) == 0) or (len(tower2LongList) == 0):
			#		tower2Updated = 0
			#		print "tower2reseted"
			#	if (gameState == "1"):
			#		tower1Updated = 0
			#		tower2Updated = 0
			#		tower1LongList = []
			#		tower1LatList = []
			#		tower1TypeList = []
			#		tower2LongList = []
			#		tower2LatList = []
			#		tower2TypeList = []
			#		creep1TypeList = []
			#		creep2TypeList = []
			#		print "clear all the tower and creeps"
			#	if (gameState == "2") and (tower1Updated == 1) and (tower2Updated == 1):
			#		gameState = "3"
			#		print "gameState to 3"	
			elif command == "get":
				#try:
				#	name = getattr(self, "name")
				#except AttributeError:
				#	msg = "all>you should have a name first, using iam>"
				#	for c in self.factory.clients:
				#		c.message(msg)	
				#else:
					#msg = name+">"
				msg = "get>" 
				varArr = content.split(' ')		
				for varName in varArr:
					if varName == "hb1":
						msg += "hb1:"+hb1long+","+hb1lat+" "
					elif varName == "hb2":
						msg += "hb2:"+hb2long+","+hb2lat+" "
					elif varName == "GS":
						msg += "GS:"+sender.player.gameSession.gameState+" "							
					elif varName == "tL":
						msg += "tL:"+sender.player.gameSession.tLlong+","+sender.player.gameSession.tLlat+" "							
					elif varName == "bR":
						msg += "bR:"+sender.player.gameSession.bRlong+","+sender.player.gameSession.bRlat+" "							
					elif varName == "cC":
						msg += "cC:"+sender.player.gameSession.cClong+","+sender.player.gameSession.cClat+" "	
					elif varName == "t1_lon":
						msg += "t1_lon:" + ",".join(tower1LongList)	+ " "
					elif varName == "t1_lat":
						msg += "t1_lat:" + ",".join(tower1LatList) + " "
					elif varName == "t1_type":
						msg += "t1_type:" + ",".join(tower1TypeList) + " "
					elif varName == "t2_lon":
						msg += "t2_lon:" + ",".join(tower2LongList) + " "	
					elif varName == "t2_lat":
						msg += "t2_lat:" + ",".join(tower2LatList) + " "	
					elif varName == "t2_type":
						msg += "t2_type:" + ",".join(tower2TypeList) + " "	
					elif varName == "creep1":
						msg += "creep1:" + ",".join(creep1TypeList) + " "	
					elif varName == "creep2":
						msg += "creep2:" + ",".join(creep2TypeList) + " "								
				sender.message(msg)				
			elif command == "gameList":
				#msg = "%s>" % sender.player.playerNo
				tempGamenameList = []
				msg = "gameList>"
				for gameSession in self.gameSessions:
					if len(gameSession.playerslist) < 2 and len(gameSession.hbLongList)==1 and len(gameSession.hbLatList)==1 and len(gameSession.hbPlayerList)==1:
						tempGamenameList.append(gameSession.gameName)
				msg += ",".join(tempGamenameList)
				sender.message(msg)
			elif command == "del":
				msg = ""
				varArr = content.split(' ')
				for var in varArr:
					varInfo = var.split(':')
					varName = varInfo[0]
					varValue = varInfo[1]
					if varName == "tower":
						deleteArray = varValue.split(',')
						for deleteIndex in deleteArray
							del sender.player.gameSession.towerLongList[int(deleteIndex)]
							del sender.player.gameSession.towerLatList[int(deleteIndex)]
							del sender.player.gameSession.towerTypeList[int(deleteIndex)]
							del sender.player.gameSession.towerPlayerList[int(deleteIndex)]
							del sender.player.towerLongList[int(deleteIndex)]
							del sender.player.towerLatList[int(deleteIndex)]
							del sender.player.towerTypeList[int(deleteIndex)]
							msg += "tower" + deleteIndex + "has been deleted. "
						print msg
					elif varName == "creep":
						deleteArray = varValue.split(',')
						for deleteIndex in deleteArray
							del sender.player.gameSession.creepTypeList[int(deleteIndex)]
							del sender.player.gameSession.creepFromList[int(deleteIndex)]
							del sender.player.gameSession.creepToList[int(deleteIndex)]
							del sender.player.creepTypeList[int(deleteIndex)]
							del sender.player.creepToList[int(deleteIndex)]
							msg += "creep" + deleteIndex + "has been deleted. "		
						print msg
								

					
class GlobalTDServer_Protocol(Protocol):

	#playerNum = 0
	
	def __init__(self):
		self.inBuffer = ""
		self.player = None
		#self.playerNo = 
		
	def message(self, message):
		print message
		self.transport.write(message)

	def connectionMade(self):
		self.factory.clients.append(self)
		print "a client connected"
		print "clients are ", self.factory.clients
		self.factory.connectionMade(self)
		
	def connectionLost(self, reason):
		if self is None:
			print "not exist"
		else:
			self.factory.clients.remove(self)
		print "Connection lost: %s" % str(reason)
		self.factory.connectionLost(self)

	#def sendMessage(self, message):
	#	msgLen = pack('!I', len(message.data))
	#	self.transport.write(msgLen)
	#	self.transport.write(message.data)

	#def sendNotInMatch(self):
	#	message = MessageWriter()
	#	message.writeByte(MESSAGE_NOT_IN_MATCH)
	#	self.log("Sent MESSAGE_NOT_IN_MATCH")
	#	self.sendMessage(message)

	#def playerConnected(self, message):
	#	playerId = message.readString()
	#	alias = message.readString()
	#	continueMatch = message.readByte()
	#	self.log("Recv MESSAGE_PLAYER_CONNECTED %s %s %d" % (playerId, alias, continueMatch))
	#	self.factory.playerConnected(self, playerId, alias, continueMatch)
		
	def dataReceived(self, data):	
		self.inBuffer = self.inBuffer + data
		while(True):
			if (len(self.inBuffer) < 4):
				return;
		
			msgLen = unpack('!I', self.inBuffer[:4])[0]
			if (len(self.inBuffer) < msgLen):
				return;
		
			messageString = self.inBuffer[4:msgLen+4]
			self.inBuffer = self.inBuffer[msgLen+4:]
		
			self.factory.serverLogic.processData(self,messageString)
		
		
		#self.factory.serverLogic.processData(self,data)

class globalTDServer_Factory(Factory):

	def __init__(self):
		self.protocol = GlobalTDServer_Protocol
		self.serverLogic = globalTD_ServerLogic(self)
		self.clients = []

	def connectionMade(self,protocol):
		pass
	def connectionLost(self, protocol):
		#for existingPlayer in self.players:
		#	if existingPlayer.protocol == protocol:
		#		existingPlayer.protocol = None        
		pass
		
	def playerConnected(self, protocol, playerId, alias, continueMatch):
		pass
	#	for existingPlayer in self.players:
	#		if existingPlayer.playerId == playerId:
	#			existingPlayer.protocol = protocol
	#			protocol.player = existingPlayer
	#			if (existingPlayer.match):
	#				print "TODO: Already in match case"
	#			else:
	#				existingPlayer.protocol.sendNotInMatch()
	#			return
	#	newPlayer = CatRacePlayer(protocol, playerId, alias)
	#	protocol.player = newPlayer
	#	self.players.append(newPlayer)
	#	newPlayer.protocol.sendNotInMatch()

	
#def globalTDServer_main():
#from twisted.internet.protocol import Factory, Protocol
#from twisted.internet import reactor
	
def connectionFail(err):
	pass
	#print >>sys.stderr, 'Poem failed:', err
	#errors.append(err)
	#poem_done()
   
factory = globalTDServer_Factory()
port = reactor.listenTCP(8888, factory)
print "Global TD server started"
print "Server is %s" % port.getHost()
reactor.run()		
	

#if __name__ == '__main__':
 #   globalTDServer_main()
	
		