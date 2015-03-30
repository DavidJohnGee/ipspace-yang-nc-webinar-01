#!/usr/bin/python
# A script which logs in to our MX and pulls interface terse stats 

import paramiko
import socket
import time
import sys

from lxml import etree
 
ROUTER_IP='192.168.10.87'
USERNAME='root'
PASSWORD='P@ssw0rd'
IFACE = "ge-0/0/0"
 
ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(
    paramiko.AutoAddPolicy())
 
COMMIT = """
<rpc>
  <commit/>
</rpc>"""

CLOSE = """
<rpc>
  <close-session/>
</rpc>
"""
 

GET_INT_INFO = """
<?xml version="1.0" encoding="utf-8"?>
<rpc>
        <get-interface-information>
                <terse/>
                <interface-name>{0}</interface-name>
        </get-interface-information>
</rpc>"""

socket = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
socket.connect((ROUTER_IP,22))
 
trans = paramiko.Transport(socket)
trans.connect(username=USERNAME, password=PASSWORD)
 
#CREATE CHANNEL FOR DATA COMM
ch = trans.open_session()
name = ch.set_name('netconf')
 
#Invoke NETCONF
ch.invoke_subsystem('netconf')

print "\n[IPSpace NCClient Demo] Opened NETCONF subchannel"
 
GET_IFACE_INFO = GET_INT_INFO.format(IFACE)

#SEND COMMAND
ch.send(GET_IFACE_INFO)

print "[IPSpace NCClient Demo] Sent interface query"

print GET_IFACE_INFO + "\n"
 
#Recieve data returned
data = ch.recv(2048)

buff1 = ""
buff2 = ""
FOUND = False

while data:
   data = ch.recv(2048)
   buff1 += data
   if data.find('<rpc-reply') == 0:
	FOUND = True
   if FOUND == True:
	buff2 += data
   if data.find('</rpc-reply') == 0:

     	#We have reached the end of reply
     	ch.send(COMMIT)
     	ch.send(CLOSE)


	ch.close()
	trans.close()
	socket.close()


ETREE_STRING = "<?xml version=\"1.0\"?>\n" + buff2

root = etree.fromstring(ETREE_STRING)

print "==== Interface Query Result ===="

for ele in root.iter():
	buff1 = ele.text
	buff2 = ele.tag

	if buffer1 and buffer1.strip():
		startplace = buffer2.index("}")
		print ele.tag[startplace+1:] + " : " + buffer1.strip()

print "================================"
