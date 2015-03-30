#!/usr/bin/python
# A script which logs in to our MX02 and changes the hostname back to MX02 - we made a mistake!

import paramiko
import socket
import time
import sys
 
ROUTER_IP='192.168.10.87'
USERNAME='root'
PASSWORD='P@ssw0rd'
 
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
 

SET_HOSTNAME = """
<?xml version="1.0" encoding="utf-8"?>
<rpc xmlns="urn:ietf:params:xml:ns:netconf:base:1.0" message-id="">
  <edit-config>
    <target>
      <candidate/>
    </target>
    <config>
      <configuration>
        <system>
          <host-name>{0}</host-name>
        </system>   
      </configuration>
    </config>
  </edit-config>
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
 
NEW_HOSTNAME = "MX03"
HOSTNAME_NC_STRING = SET_HOSTNAME.format(NEW_HOSTNAME)

#SEND COMMAND
ch.send(HOSTNAME_NC_STRING)

print "[IPSpace NCClient Demo] Sent Hostname change NETCONF call"

print HOSTNAME_NC_STRING
 
#Recieve data returned
data = ch.recv(2048)
while data:
   data = ch.recv(1024)
   #print data
   if data.find('<ok/>') == 0:
     #We have reached the end of reply
     ch.send(COMMIT)
     ch.send(CLOSE)


print "\n[IPSpace NCClient Demo] Hostname changed to " + NEW_HOSTNAME + "\n"
ch.close()
trans.close()
socket.close()
